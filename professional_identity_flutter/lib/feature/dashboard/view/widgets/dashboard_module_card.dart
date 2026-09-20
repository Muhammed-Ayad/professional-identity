import 'package:flutter/material.dart';

class DashboardModuleCard extends StatelessWidget {
  final String title;
  final String count;
  final String subtitle;
  final IconData icon;
  final String buttonLabel;
  final VoidCallback onManage;

  const DashboardModuleCard({
    super.key,
    required this.title,
    required this.count,
    required this.subtitle,
    required this.icon,
    required this.buttonLabel,
    required this.onManage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 20, color: theme.colorScheme.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        count,
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onManage,
                child: Text(buttonLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardFeatureChip extends StatelessWidget {
  final String title;
  final bool isDone;

  const DashboardFeatureChip({
    super.key,
    required this.title,
    this.isDone = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isDone
            ? theme.colorScheme.primary.withValues(alpha: 0.1)
            : theme.colorScheme.onSurface.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isDone
              ? theme.colorScheme.primary.withValues(alpha: 0.3)
              : theme.colorScheme.onSurface.withValues(alpha: 0.08),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: isDone ? FontWeight.w600 : FontWeight.normal,
          color: isDone
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}
