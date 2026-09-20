import 'package:flutter/material.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import 'edit_experience_dialog.dart';

class ExperienceItemCard extends StatelessWidget {
  final Experience experience;
  final int index;
  final VoidCallback onDelete;

  const ExperienceItemCard({
    super.key,
    required this.experience,
    required this.index,
    required this.onDelete,
  });

  String _formatDate(DateTime d) {
    return '${d.year}-${d.month.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final exp = experience;
    final dateRange = exp.isCurrent
        ? '${_formatDate(exp.startDate)} — Present'
        : '${_formatDate(exp.startDate)} — ${exp.endDate != null ? _formatDate(exp.endDate!) : 'N/A'}';

    return Card(
      key: ValueKey(exp.id),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.business_rounded,
                    size: 22,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exp.jobTitle,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        exp.company,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(
                            dateRange,
                            style: theme.textTheme.bodySmall,
                          ),
                          if (exp.isCurrent) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF10B981,
                                ).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'CURRENT',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF065F46),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, size: 18),
                      onPressed: () => EditExperienceDialog.show(
                        context,
                        initialExperience: exp,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, size: 18),
                      color: theme.colorScheme.error,
                      onPressed: onDelete,
                    ),
                    ReorderableDragStartListener(
                      index: index,
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.drag_handle_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (exp.description != null && exp.description!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                exp.description!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.4,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
