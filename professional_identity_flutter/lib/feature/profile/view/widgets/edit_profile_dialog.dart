import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import '../../logic/providers/profile_providers.dart';
import 'profile_dialog_header.dart';
import 'profile_form_fields.dart';

class EditProfileDialog extends HookConsumerWidget {
  final Profile? initialProfile;

  const EditProfileDialog({super.key, this.initialProfile});

  static Future<Profile?> show(
    BuildContext context, {
    Profile? initialProfile,
  }) {
    return showDialog<Profile>(
      context: context,
      barrierDismissible: false,
      builder: (context) => EditProfileDialog(initialProfile: initialProfile),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final handleController = useTextEditingController(
      text: initialProfile?.handle ?? '',
    );
    final fullNameController = useTextEditingController(
      text: initialProfile?.fullName ?? '',
    );
    final headlineController = useTextEditingController(
      text: initialProfile?.headline ?? '',
    );
    final bioController = useTextEditingController(
      text: initialProfile?.bio ?? '',
    );
    final locationController = useTextEditingController(
      text: initialProfile?.location ?? '',
    );
    final currentRoleController = useTextEditingController(
      text: initialProfile?.currentRole ?? '',
    );
    final yearsController = useTextEditingController(
      text: initialProfile?.yearsOfExperience?.toString() ?? '',
    );
    final availabilityController = useTextEditingController(
      text: initialProfile?.availability ?? 'Available for opportunities',
    );
    final contactEmailController = useTextEditingController(
      text: initialProfile?.contactEmail ?? '',
    );
    final websiteUrlController = useTextEditingController(
      text: initialProfile?.websiteUrl ?? '',
    );
    final isPublic = useState(initialProfile?.isPublic ?? true);

    final isSubmitting = useState(false);
    final errorMessage = useState<String?>(null);
    final theme = Theme.of(context);

    Future<void> submit() async {
      if (!formKey.currentState!.validate()) return;

      isSubmitting.value = true;
      errorMessage.value = null;

      try {
        final years = int.tryParse(yearsController.text.trim());
        final saved = await ref
            .read(userProfileNotifierProvider.notifier)
            .saveProfile(
              handle: handleController.text.trim().toLowerCase(),
              fullName: fullNameController.text.trim(),
              headline: headlineController.text.trim().isEmpty
                  ? null
                  : headlineController.text.trim(),
              bio: bioController.text.trim().isEmpty
                  ? null
                  : bioController.text.trim(),
              location: locationController.text.trim().isEmpty
                  ? null
                  : locationController.text.trim(),
              currentRole: currentRoleController.text.trim().isEmpty
                  ? null
                  : currentRoleController.text.trim(),
              yearsOfExperience: years,
              availability: availabilityController.text.trim().isEmpty
                  ? null
                  : availabilityController.text.trim(),
              contactEmail: contactEmailController.text.trim().isEmpty
                  ? null
                  : contactEmailController.text.trim(),
              websiteUrl: websiteUrlController.text.trim().isEmpty
                  ? null
                  : websiteUrlController.text.trim(),
              isPublic: isPublic.value,
            );

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
        constraints: const BoxConstraints(maxWidth: 580, maxHeight: 720),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProfileDialogHeader(
                  isEdit: initialProfile != null,
                  isSubmitting: isSubmitting.value,
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
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: theme.colorScheme.error,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            errorMessage.value!,
                            style: TextStyle(
                              color: theme.colorScheme.error,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                Expanded(
                  child: SingleChildScrollView(
                    clipBehavior: Clip.none,
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ProfileBasicFields(
                          handleController: handleController,
                          fullNameController: fullNameController,
                          headlineController: headlineController,
                          currentRoleController: currentRoleController,
                          yearsController: yearsController,
                          enabled: !isSubmitting.value,
                        ),
                        const SizedBox(height: 14),
                        ProfileContactFields(
                          locationController: locationController,
                          availabilityController: availabilityController,
                          contactEmailController: contactEmailController,
                          websiteUrlController: websiteUrlController,
                          enabled: !isSubmitting.value,
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: bioController,
                          enabled: !isSubmitting.value,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: 'Bio / Summary',
                            hintText:
                                'Brief overview of your background, passions, and expertise...',
                          ),
                        ),
                        const SizedBox(height: 14),
                        SwitchListTile(
                          value: isPublic.value,
                          onChanged: isSubmitting.value
                              ? null
                              : (val) => isPublic.value = val,
                          title: const Text(
                            'Public Profile Visibility',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            isPublic.value
                                ? 'Your profile is publicly viewable at /u/${handleController.text.trim()}'
                                : 'Profile is private and hidden from the public',
                            style: theme.textTheme.bodySmall,
                          ),
                          contentPadding: EdgeInsets.zero,
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
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              initialProfile == null
                                  ? 'Create Profile'
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
