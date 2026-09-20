import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:professional_identity_client/professional_identity_client.dart';

/// Lightweight custom-painted line and bar trend chart for profile views.
/// Zero external charting dependencies.
class ProfileViewsChart extends StatelessWidget {
  final List<DailyEventCount> dailyViews;

  const ProfileViewsChart({super.key, required this.dailyViews});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (dailyViews.isEmpty) {
      return Container(
        height: 180,
        alignment: Alignment.center,
        child: Text(
          'No activity recorded in this period',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
      );
    }

    final maxCount = dailyViews.map((e) => e.count).fold<int>(0, math.max);
    final effectiveMax = maxCount == 0 ? 5 : maxCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 180,
          child: CustomPaint(
            painter: _ChartPainter(
              data: dailyViews,
              maxCount: effectiveMax,
              lineColor: theme.colorScheme.primary,
              fillColor: theme.colorScheme.primary.withValues(alpha: 0.12),
              gridColor: theme.colorScheme.outlineVariant.withValues(
                alpha: 0.4,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatDate(dailyViews.first.date),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                fontSize: 10,
              ),
            ),
            Text(
              _formatDate(dailyViews.last.date),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatDate(DateTime d) {
    return '${d.month}/${d.day}';
  }
}

class _ChartPainter extends CustomPainter {
  final List<DailyEventCount> data;
  final int maxCount;
  final Color lineColor;
  final Color fillColor;
  final Color gridColor;

  _ChartPainter({
    required this.data,
    required this.maxCount,
    required this.lineColor,
    required this.fillColor,
    required this.gridColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0;

    // Draw horizontal grid lines (3 lines)
    for (int i = 0; i <= 3; i++) {
      final y = size.height * (i / 3);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final points = <Offset>[];
    final stepX = data.length > 1
        ? size.width / (data.length - 1)
        : size.width / 2;

    for (int i = 0; i < data.length; i++) {
      final x = data.length > 1 ? i * stepX : size.width / 2;
      final normalizedY = (data[i].count / maxCount).clamp(0.0, 1.0);
      final y = size.height - (normalizedY * (size.height - 16)) - 8;
      points.add(Offset(x, y));
    }

    // Draw filled area
    final fillPath = Path();
    fillPath.moveTo(points.first.dx, size.height);
    for (final p in points) {
      fillPath.lineTo(p.dx, p.dy);
    }
    fillPath.lineTo(points.last.dx, size.height);
    fillPath.close();

    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(fillPath, fillPaint);

    // Draw trend line
    final linePath = Path();
    linePath.moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      linePath.lineTo(points[i].dx, points[i].dy);
    }

    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(linePath, linePaint);

    // Draw circular dots
    final dotPaint = Paint()..color = lineColor;
    final whitePaint = Paint()..color = Colors.white;

    for (final p in points) {
      canvas.drawCircle(p, 4, dotPaint);
      canvas.drawCircle(p, 2, whitePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ChartPainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.maxCount != maxCount ||
        oldDelegate.lineColor != lineColor;
  }
}
