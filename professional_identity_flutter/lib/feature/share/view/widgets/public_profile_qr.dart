import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// Reusable QR display widget for a public profile.
/// Renders a scannable QR code on a high-contrast white card,
/// with defensive sizing so it scales cleanly down to 320px screens.
class PublicProfileQr extends StatelessWidget {
  final String url;
  final double size;
  final bool showUrlSubtitle;

  const PublicProfileQr({
    super.key,
    required this.url,
    this.size = 200,
    this.showUrlSubtitle = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Ensure size never exceeds available width with margin
        final maxWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : (size + 32);
        final maxAllowed = (maxWidth - 32).clamp(140.0, size);
        final effectiveSize = maxAllowed < size ? maxAllowed : size;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 1.5,
                ),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: effectiveSize,
                  maxHeight: effectiveSize,
                ),
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: QrImageView(
                    data: url,
                    version: QrVersions.auto,
                    size: effectiveSize,
                    backgroundColor: Colors.white,
                    eyeStyle: const QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: Color(0xFF1E293B),
                    ),
                    dataModuleStyle: const QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.square,
                      color: Color(0xFF0F172A),
                    ),
                    errorCorrectionLevel: QrErrorCorrectLevel.M,
                  ),
                ),
              ),
            ),
            if (showUrlSubtitle) ...[
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  url,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
