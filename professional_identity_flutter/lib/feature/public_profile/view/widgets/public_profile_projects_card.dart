import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import 'package:professional_identity_flutter/core/utils/url_launcher_helper.dart';
import 'package:professional_identity_flutter/feature/analytics/logic/providers/analytics_providers.dart';
import 'public_profile_helpers.dart';

class PublicProfileProjectsCard extends StatelessWidget {
  final List<Project> projects;
  final String handle;
  final WidgetRef ref;

  const PublicProfileProjectsCard({
    super.key,
    required this.projects,
    required this.handle,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: theme.cardTheme.elevation ?? 0,
      shape: theme.cardTheme.shape,
      color: theme.cardTheme.color,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.folder_special_outlined, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Featured Projects',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...projects.map((project) {
              String dateText = '';
              if (project.startDate != null) {
                dateText = formatPublicDate(project.startDate!);
                if (project.isOngoing) {
                  dateText += ' — Present';
                } else if (project.endDate != null) {
                  dateText += ' — ${formatPublicDate(project.endDate!)}';
                }
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.02),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.06),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        Text(
                          project.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        if (project.isOngoing)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
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
                        style: TextStyle(
                          color: theme.colorScheme.secondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                    if (dateText.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        dateText,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                    if (project.description != null &&
                        project.description!.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        project.description!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          height: 1.5,
                        ),
                      ),
                    ],
                    if (project.technologies.isNotEmpty) ...[
                      const SizedBox(height: 10),
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
                              color: theme.colorScheme.primary.withValues(
                                alpha: 0.08,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              tech,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                    if (project.url != null ||
                        project.repositoryUrl != null) ...[
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          if (project.url != null)
                            ActionChip(
                              avatar: const Icon(
                                Icons.open_in_new_rounded,
                                size: 14,
                              ),
                              label: const Text('Live Demo'),
                              onPressed: () {
                                ref
                                    .read(analyticsRepositoryProvider)
                                    .recordPublicEvent(
                                      handle: handle,
                                      eventType: 'project_click',
                                      target: project.title,
                                    );
                                UrlLauncherHelper.openUrl(
                                  context,
                                  project.url!,
                                );
                              },
                            ),
                          if (project.repositoryUrl != null)
                            ActionChip(
                              avatar: const Icon(
                                Icons.code_rounded,
                                size: 14,
                              ),
                              label: const Text('Repository'),
                              onPressed: () {
                                ref
                                    .read(analyticsRepositoryProvider)
                                    .recordPublicEvent(
                                      handle: handle,
                                      eventType: 'project_click',
                                      target: project.title,
                                    );
                                UrlLauncherHelper.openUrl(
                                  context,
                                  project.repositoryUrl!,
                                );
                              },
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
