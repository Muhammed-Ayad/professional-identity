import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import '../../logic/providers/experience_providers.dart';
import '../widgets/edit_experience_dialog.dart';
import '../widgets/experience_item_card.dart';

class ExperienceScreen extends HookConsumerWidget {
  const ExperienceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expAsync = ref.watch(experienceNotifierProvider);
    final theme = Theme.of(context);

    Future<void> confirmDelete(Experience exp) async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Experience'),
          content: Text(
            'Are you sure you want to remove your role as "${exp.jobTitle}" at "${exp.company}"?',
          ),
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
            .read(experienceNotifierProvider.notifier)
            .deleteExperience(exp.id!);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Removed ${exp.jobTitle} at ${exp.company}'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Work Experience'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            tooltip: 'Add Experience',
            onPressed: () => EditExperienceDialog.show(context),
          ),
        ],
      ),
      body: SafeArea(
        child: expAsync.when(
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
                Text('Failed to load experiences: $err'),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () =>
                      ref.read(experienceNotifierProvider.notifier).refresh(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
          data: (experiences) {
            if (experiences.isEmpty) {
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
                          Icons.work_outline_rounded,
                          size: 48,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No Work Experience Added Yet',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Document your career journey, leadership roles, and company milestones.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () => EditExperienceDialog.show(context),
                        icon: const Icon(Icons.add_rounded),
                        label: const Text('Add Experience'),
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
                            '${experiences.length} ${experiences.length == 1 ? 'position' : 'positions'}',
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
                        itemCount: experiences.length,
                        onReorderItem: (oldIndex, newIndex) {
                          ref
                              .read(experienceNotifierProvider.notifier)
                              .reorder(oldIndex, newIndex);
                        },
                        itemBuilder: (context, index) {
                          final exp = experiences[index];
                          return ExperienceItemCard(
                            key: ValueKey(exp.id),
                            experience: exp,
                            index: index,
                            onDelete: () => confirmDelete(exp),
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
