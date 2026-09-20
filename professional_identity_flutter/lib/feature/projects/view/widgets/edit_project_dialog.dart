import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import '../../logic/providers/project_providers.dart';
import 'project_basic_fields.dart';
import 'project_date_range_fields.dart';
import 'project_tech_chips_input.dart';

class EditProjectDialog extends HookConsumerWidget {
  final Project? initialProject;

  const EditProjectDialog({super.key, this.initialProject});

  static Future<Project?> show(
    BuildContext context, {
    Project? initialProject,
  }) {
    return showDialog<Project>(
      context: context,
      builder: (context) => EditProjectDialog(initialProject: initialProject),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final titleController = useTextEditingController(
      text: initialProject?.title ?? '',
    );
    final roleController = useTextEditingController(
      text: initialProject?.role ?? '',
    );
    final descriptionController = useTextEditingController(
      text: initialProject?.description ?? '',
    );
    final urlController = useTextEditingController(
      text: initialProject?.url ?? '',
    );
    final repoUrlController = useTextEditingController(
      text: initialProject?.repositoryUrl ?? '',
    );
    final techInputController = useTextEditingController();

    final technologies = useState<List<String>>(
      List<String>.from(initialProject?.technologies ?? []),
    );
    final isOngoing = useState(initialProject?.isOngoing ?? false);
    final startDate = useState<DateTime?>(initialProject?.startDate);
    final endDate = useState<DateTime?>(initialProject?.endDate);

    final isSubmitting = useState(false);
    final errorMessage = useState<String?>(null);
    final theme = Theme.of(context);

    Future<void> pickStartDate() async {
      final picked = await showDatePicker(
        context: context,
        initialDate: startDate.value ?? DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime(2100),
      );
      if (picked != null) {
        startDate.value = picked;
        if (endDate.value != null && endDate.value!.isBefore(picked)) {
          endDate.value = picked;
        }
      }
    }

    Future<void> pickEndDate() async {
      final picked = await showDatePicker(
        context: context,
        initialDate: endDate.value ?? (startDate.value ?? DateTime.now()),
        firstDate: startDate.value ?? DateTime(1980),
        lastDate: DateTime(2100),
      );
      if (picked != null) {
        endDate.value = picked;
      }
    }

    void addTech() {
      final tag = techInputController.text.trim();
      if (tag.isNotEmpty && !technologies.value.contains(tag)) {
        technologies.value = [...technologies.value, tag];
        techInputController.clear();
      }
    }

    void removeTech(String tag) {
      technologies.value = technologies.value.where((t) => t != tag).toList();
    }

    Future<void> onSubmit() async {
      if (!formKey.currentState!.validate()) return;
      if (technologies.value.isEmpty) {
        errorMessage.value = 'Please add at least one technology.';
        return;
      }

      errorMessage.value = null;
      isSubmitting.value = true;

      try {
        if (initialProject == null) {
          final created = await ref
              .read(projectsNotifierProvider.notifier)
              .addProject(
                title: titleController.text.trim(),
                role: roleController.text.trim().isEmpty
                    ? null
                    : roleController.text.trim(),
                description: descriptionController.text.trim().isEmpty
                    ? null
                    : descriptionController.text.trim(),
                url: urlController.text.trim().isEmpty
                    ? null
                    : urlController.text.trim(),
                repositoryUrl: repoUrlController.text.trim().isEmpty
                    ? null
                    : repoUrlController.text.trim(),
                technologies: technologies.value,
                startDate: startDate.value,
                endDate: isOngoing.value ? null : endDate.value,
                isOngoing: isOngoing.value,
              );
          if (context.mounted) {
            Navigator.of(context).pop(created);
          }
        } else {
          final updated = await ref
              .read(projectsNotifierProvider.notifier)
              .updateProject(
                projectId: initialProject!.id!,
                title: titleController.text.trim(),
                role: roleController.text.trim().isEmpty
                    ? null
                    : roleController.text.trim(),
                description: descriptionController.text.trim().isEmpty
                    ? null
                    : descriptionController.text.trim(),
                url: urlController.text.trim().isEmpty
                    ? null
                    : urlController.text.trim(),
                repositoryUrl: repoUrlController.text.trim().isEmpty
                    ? null
                    : repoUrlController.text.trim(),
                technologies: technologies.value,
                startDate: startDate.value,
                endDate: isOngoing.value ? null : endDate.value,
                isOngoing: isOngoing.value,
              );
          if (context.mounted) {
            Navigator.of(context).pop(updated);
          }
        }
      } catch (e) {
        errorMessage.value = e.toString().replaceAll('Exception: ', '');
      } finally {
        if (context.mounted) {
          isSubmitting.value = false;
        }
      }
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 580),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(
                          alpha: 0.08,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        initialProject == null
                            ? Icons.add_circle_outline_rounded
                            : Icons.edit_outlined,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        initialProject == null
                            ? 'Add Featured Project'
                            : 'Edit Project',
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (errorMessage.value != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.error.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: theme.colorScheme.error.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      errorMessage.value!,
                      style: TextStyle(color: theme.colorScheme.error),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                ProjectBasicFields(
                  titleController: titleController,
                  roleController: roleController,
                  descriptionController: descriptionController,
                  urlController: urlController,
                  repoUrlController: repoUrlController,
                ),
                const SizedBox(height: 16),
                ProjectTechChipsInput(
                  controller: techInputController,
                  technologies: technologies.value,
                  onAdd: addTech,
                  onRemove: removeTech,
                ),
                const SizedBox(height: 16),
                ProjectDateRangeFields(
                  isOngoing: isOngoing.value,
                  onOngoingChanged: (val) {
                    isOngoing.value = val;
                    if (val) endDate.value = null;
                  },
                  startDate: startDate.value,
                  endDate: endDate.value,
                  onPickStartDate: pickStartDate,
                  onPickEndDate: pickEndDate,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: isSubmitting.value
                          ? null
                          : () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: isSubmitting.value ? null : onSubmit,
                      child: isSubmitting.value
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(
                              initialProject == null
                                  ? 'Add Project'
                                  : 'Save Changes',
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
