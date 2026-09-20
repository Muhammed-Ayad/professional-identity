import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import '../../logic/providers/experience_providers.dart';
import 'experience_date_range_fields.dart';
import 'experience_dialog_header.dart';

class EditExperienceDialog extends HookConsumerWidget {
  final Experience? initialExperience;

  const EditExperienceDialog({super.key, this.initialExperience});

  static Future<Experience?> show(
    BuildContext context, {
    Experience? initialExperience,
  }) {
    return showDialog<Experience>(
      context: context,
      builder: (context) =>
          EditExperienceDialog(initialExperience: initialExperience),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final companyController = useTextEditingController(
      text: initialExperience?.company ?? '',
    );
    final jobTitleController = useTextEditingController(
      text: initialExperience?.jobTitle ?? '',
    );
    final descriptionController = useTextEditingController(
      text: initialExperience?.description ?? '',
    );

    final isCurrent = useState(initialExperience?.isCurrent ?? false);
    final startDate = useState<DateTime?>(
      initialExperience?.startDate ??
          DateTime.now().subtract(const Duration(days: 365)),
    );
    final endDate = useState<DateTime?>(initialExperience?.endDate);

    final isSubmitting = useState(false);
    final errorMessage = useState<String?>(null);
    final theme = Theme.of(context);

    Future<void> pickStartDate() async {
      final picked = await showDatePicker(
        context: context,
        initialDate: startDate.value ?? DateTime.now(),
        firstDate: DateTime(1970),
        lastDate: DateTime.now(),
      );
      if (picked != null) {
        startDate.value = picked;
      }
    }

    Future<void> pickEndDate() async {
      final picked = await showDatePicker(
        context: context,
        initialDate: endDate.value ?? DateTime.now(),
        firstDate: startDate.value ?? DateTime(1970),
        lastDate: DateTime(2035),
      );
      if (picked != null) {
        endDate.value = picked;
      }
    }

    Future<void> submit() async {
      if (!formKey.currentState!.validate()) return;
      if (startDate.value == null) {
        errorMessage.value = 'Start date is required.';
        return;
      }
      if (!isCurrent.value &&
          endDate.value != null &&
          endDate.value!.isBefore(startDate.value!)) {
        errorMessage.value = 'End date cannot be before start date.';
        return;
      }

      isSubmitting.value = true;
      errorMessage.value = null;

      try {
        final company = companyController.text.trim();
        final jobTitle = jobTitleController.text.trim();
        final desc = descriptionController.text.trim().isEmpty
            ? null
            : descriptionController.text.trim();

        Experience saved;
        if (initialExperience == null) {
          saved = await ref
              .read(experienceNotifierProvider.notifier)
              .addExperience(
                company: company,
                jobTitle: jobTitle,
                startDate: startDate.value!,
                endDate: isCurrent.value ? null : endDate.value,
                isCurrent: isCurrent.value,
                description: desc,
              );
        } else {
          saved = await ref
              .read(experienceNotifierProvider.notifier)
              .updateExperience(
                experienceId: initialExperience!.id!,
                company: company,
                jobTitle: jobTitle,
                startDate: startDate.value!,
                endDate: isCurrent.value ? null : endDate.value,
                isCurrent: isCurrent.value,
                description: desc,
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
        constraints: const BoxConstraints(maxWidth: 540, maxHeight: 680),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ExperienceDialogHeader(
                  isEdit: initialExperience != null,
                  onClose: () => Navigator.of(context).pop(),
                ),
                const SizedBox(height: 16),
                const Divider(),
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: companyController,
                          enabled: !isSubmitting.value,
                          decoration: const InputDecoration(
                            labelText: 'Company / Organization *',
                            hintText: 'e.g. Google, Stripe, Freelance',
                          ),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Company is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: jobTitleController,
                          enabled: !isSubmitting.value,
                          decoration: const InputDecoration(
                            labelText: 'Job Title *',
                            hintText: 'e.g. Senior Mobile Engineer',
                          ),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Job title is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        ExperienceDateRangeFields(
                          isCurrent: isCurrent.value,
                          onCurrentChanged: (val) {
                            isCurrent.value = val;
                            if (val) {
                              endDate.value = null;
                            }
                          },
                          startDate: startDate.value,
                          endDate: endDate.value,
                          onPickStartDate: pickStartDate,
                          onPickEndDate: pickEndDate,
                          enabled: !isSubmitting.value,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: descriptionController,
                          enabled: !isSubmitting.value,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            labelText: 'Description / Achievements',
                            hintText:
                                'Led cross-functional team, built core Serverpod architecture, reduced latency by 40%...',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
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
                          : Text(initialExperience == null ? 'Add' : 'Save'),
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
