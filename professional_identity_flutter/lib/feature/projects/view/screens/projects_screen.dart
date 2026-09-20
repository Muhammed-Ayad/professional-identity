import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import '../../logic/providers/project_providers.dart';
import '../widgets/edit_project_dialog.dart';
import '../widgets/project_item_card.dart';

class ProjectsScreen extends HookConsumerWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectsAsync = ref.watch(projectsNotifierProvider);
    final theme = Theme.of(context);

    Future<void> confirmDelete(Project project) async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Project'),
          content: Text('Are you sure you want to delete "${project.title}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        await ref
            .read(projectsNotifierProvider.notifier)
            .deleteProject(project.id!);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Removed ${project.title}'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Featured Projects'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            tooltip: 'Add Project',
            onPressed: () => EditProjectDialog.show(context),
          ),
        ],
      ),
      body: SafeArea(
        child: projectsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  color: theme.colorScheme.error,
                  size: 44,
                ),
                const SizedBox(height: 12),
                Text('Failed to load projects: $err'),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () =>
                      ref.read(projectsNotifierProvider.notifier).refresh(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
          data: (projects) {
            if (projects.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.08,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.folder_special_outlined,
                          size: 48,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No projects yet',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Showcase your work by adding your first project.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () => EditProjectDialog.show(context),
                        icon: const Icon(Icons.add_rounded),
                        label: const Text('Add Project'),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                      child: Row(
                        children: [
                          Text(
                            '${projects.length} ${projects.length == 1 ? 'project' : 'projects'}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.drag_indicator_rounded,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Drag to reorder',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ReorderableListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        itemCount: projects.length,
                        onReorderItem: (oldIndex, newIndex) {
                          ref
                              .read(projectsNotifierProvider.notifier)
                              .reorder(oldIndex, newIndex);
                        },
                        itemBuilder: (context, index) {
                          final project = projects[index];
                          return ProjectItemCard(
                            key: ValueKey(project.id),
                            project: project,
                            onDelete: () => confirmDelete(project),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
