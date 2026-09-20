import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import '../../logic/providers/skill_providers.dart';

class EditSkillDialog extends HookConsumerWidget {
  final Skill? initialSkill;

  const EditSkillDialog({super.key, this.initialSkill});

  static Future<Skill?> show(BuildContext context, {Skill? initialSkill}) {
    return showDialog<Skill>(
      context: context,
      builder: (context) => EditSkillDialog(initialSkill: initialSkill),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final nameController = useTextEditingController(
      text: initialSkill?.name ?? '',
    );
    final categoryController = useTextEditingController(
      text: initialSkill?.category ?? '',
    );
    final yearsController = useTextEditingController(
      text: initialSkill?.yearsOfExperience?.toString() ?? '',
    );
    final isSubmitting = useState(false);
    final errorMessage = useState<String?>(null);
    final theme = Theme.of(context);

    final suggestedCategories = [
      'Frontend',
      'Backend',
      'Mobile',
      'Cloud / DevOps',
      'Database',
      'AI / ML',
      'UI/UX Design',
      'Testing',
    ];

    Future<void> submit() async {
      if (!formKey.currentState!.validate()) return;
      isSubmitting.value = true;
      errorMessage.value = null;

      try {
        final years = int.tryParse(yearsController.text.trim());
        final name = nameController.text.trim();
        final category = categoryController.text.trim().isEmpty
            ? null
            : categoryController.text.trim();

        Skill saved;
        if (initialSkill == null) {
          saved = await ref
              .read(skillsNotifierProvider.notifier)
              .addSkill(name, category: category, yearsOfExperience: years);
        } else {
          saved = await ref
              .read(skillsNotifierProvider.notifier)
              .updateSkill(
                initialSkill!.id!,
                name,
                category: category,
                yearsOfExperience: years,
              );
        }

        if (context.mounted) {
          Navigator.of(context).pop(saved);
        }
      } catch (e) {
        errorMessage.value = e.toString().replaceAll('Exception: ', '');
      } finally {
        isSubmitting.value = false;
      }
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Padding(
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
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.bolt_rounded,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        initialSkill == null ? 'Add Skill' : 'Edit Skill',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

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
                      style: TextStyle(
                        color: theme.colorScheme.error,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                TextFormField(
                  controller: nameController,
                  enabled: !isSubmitting.value,
                  decoration: const InputDecoration(
                    labelText: 'Skill Name *',
                    hintText: 'e.g. Flutter, PostgreSQL, Docker',
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Skill name is required';
                    }
                    if (val.trim().length > 50) {
                      return 'Maximum 50 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),

                TextFormField(
                  controller: categoryController,
                  enabled: !isSubmitting.value,
                  decoration: const InputDecoration(
                    labelText: 'Category (Optional)',
                    hintText: 'e.g. Mobile, Backend, DevOps',
                  ),
                ),
                const SizedBox(height: 8),

                // Category suggestions
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: suggestedCategories.map((cat) {
                    return InkWell(
                      onTap: () {
                        categoryController.text = cat;
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest
                              .withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          cat,
                          style: TextStyle(
                            fontSize: 11,
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.7,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 14),

                TextFormField(
                  controller: yearsController,
                  enabled: !isSubmitting.value,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Years of Experience (Optional)',
                    hintText: 'e.g. 3',
                  ),
                  validator: (val) {
                    if (val != null && val.trim().isNotEmpty) {
                      final n = int.tryParse(val.trim());
                      if (n == null || n < 0) {
                        return 'Enter a non-negative number';
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: isSubmitting.value
                          ? null
                          : () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: isSubmitting.value ? null : submit,
                      child: isSubmitting.value
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(initialSkill == null ? 'Add Skill' : 'Save'),
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
