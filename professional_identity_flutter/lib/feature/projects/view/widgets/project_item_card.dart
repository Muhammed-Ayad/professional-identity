import 'package:flutter/material.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import 'package:professional_identity_flutter/core/utils/url_launcher_helper.dart';
import 'edit_project_dialog.dart';

class ProjectItemCard extends StatelessWidget {
  final Project project;
  final VoidCallback onDelete;

  const ProjectItemCard({
    super.key,
    required this.project,
    required this.onDelete,
  });

  String _formatDate(DateTime? d) {
    if (d == null) return '';
    return '${d.year}-${d.month.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasDates =
        project.startDate != null ||
        project.isOngoing ||
        project.endDate != null;

    String dateText = '';
    if (project.startDate != null) {
      dateText = _formatDate(project.startDate);
      if (project.isOngoing) {
        dateText += ' — Present';
      } else if (project.endDate != null) {
        dateText += ' — ${_formatDate(project.endDate)}';
      }
    }

    return Card(
      key: ValueKey(project.id),
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
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.folder_outlined,
                    size: 20,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              project.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          if (project.isOngoing)
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: Colors.green.withValues(alpha: 0.3),
                                ),
                              ),
                              child: const Text(
                                'Ongoing',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      if (project.role != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          project.role!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                      ],
                      if (hasDates && dateText.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          dateText,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  tooltip: 'Edit Project',
                  onPressed: () => EditProjectDialog.show(
                    context,
                    initialProject: project,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline_rounded, size: 18),
                  tooltip: 'Delete Project',
                  onPressed: onDelete,
                ),
              ],
            ),
            if (project.description != null &&
                project.description!.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                project.description!,
                style: theme.textTheme.bodyMedium,
              ),
            ],
            if (project.technologies.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: project.technologies.map((tech) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: 0.06,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      tech,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
            if (project.url != null || project.repositoryUrl != null) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  if (project.url != null) ...[
                    ActionChip(
                      avatar: const Icon(
                        Icons.open_in_new_rounded,
                        size: 14,
                      ),
                      label: const Text('Live Demo'),
                      onPressed: () {
                        UrlLauncherHelper.openUrl(context, project.url!);
                      },
                    ),
                    const SizedBox(width: 8),
                  ],
                  if (project.repositoryUrl != null) ...[
                    ActionChip(
                      avatar: const Icon(
                        Icons.code_rounded,
                        size: 14,
                      ),
                      label: const Text('Repository'),
                      onPressed: () {
                        UrlLauncherHelper.openUrl(
                          context,
                          project.repositoryUrl!,
                        );
                      },
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
