import 'package:flutter/material.dart';
import 'package:professional_identity_client/professional_identity_client.dart';

class AnalyticsMetricGrid extends StatelessWidget {
  final AnalyticsSummary summary;

  const AnalyticsMetricGrid({
    super.key,
    required this.summary,
  });

  Widget _buildMetricCard(
    ThemeData theme, {
    required String title,
    required int value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.6),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '$value',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final isCompact = constraints.maxWidth < 600;
            final cardWidth = isCompact
                ? (constraints.maxWidth - 12) / 2
                : (constraints.maxWidth - 48) / 5;

            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                SizedBox(
                  width: cardWidth,
                  child: _buildMetricCard(
                    theme,
                    title: 'Profile Views',
                    value: summary.totalProfileViews,
                    icon: Icons.visibility_rounded,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: _buildMetricCard(
                    theme,
                    title: 'Social Clicks',
                    value: summary.totalSocialLinkClicks,
                    icon: Icons.share_rounded,
                    color: Colors.purple,
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: _buildMetricCard(
                    theme,
                    title: 'Project Clicks',
                    value: summary.totalProjectClicks,
                    icon: Icons.folder_special_rounded,
                    color: Colors.amber.shade800,
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: _buildMetricCard(
                    theme,
                    title: 'CV Views',
                    value: summary.totalCvViews,
                    icon: Icons.description_rounded,
                    color: Colors.teal,
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: _buildMetricCard(
                    theme,
                    title: 'Shares',
                    value: summary.totalProfileShares,
                    icon: Icons.ios_share_rounded,
                    color: Colors.green,
                  ),
                ),
                if (summary.totalProfileLinkCopies != null &&
                    summary.totalProfileLinkCopies! > 0)
                  SizedBox(
                    width: cardWidth,
                    child: _buildMetricCard(
                      theme,
                      title: 'Link Copies',
                      value: summary.totalProfileLinkCopies!,
                      icon: Icons.copy_rounded,
                      color: Colors.indigo,
                    ),
                  ),
                if (summary.totalQrDownloads != null &&
                    summary.totalQrDownloads! > 0)
                  SizedBox(
                    width: cardWidth,
                    child: _buildMetricCard(
                      theme,
                      title: 'QR Downloads',
                      value: summary.totalQrDownloads!,
                      icon: Icons.download_rounded,
                      color: Colors.deepOrange,
                    ),
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withValues(
              alpha: 0.5,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                Icons.bolt_rounded,
                size: 18,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Total Recorded Interactions:',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${summary.totalEvents}',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
