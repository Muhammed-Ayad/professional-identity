import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import '../../logic/providers/social_link_providers.dart';

class EditSocialLinkDialog extends HookConsumerWidget {
  final SocialLink? initialLink;

  const EditSocialLinkDialog({super.key, this.initialLink});

  static Future<SocialLink?> show(
    BuildContext context, {
    SocialLink? initialLink,
  }) {
    return showDialog<SocialLink>(
      context: context,
      builder: (context) => EditSocialLinkDialog(initialLink: initialLink),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final platform = useState(initialLink?.platform ?? 'github');
    final urlController = useTextEditingController(
      text: initialLink?.url ?? '',
    );
    final labelController = useTextEditingController(
      text: initialLink?.label ?? '',
    );

    final isSubmitting = useState(false);
    final errorMessage = useState<String?>(null);
    final theme = Theme.of(context);

    final platforms = [
      {'id': 'github', 'name': 'GitHub', 'icon': Icons.code_rounded},
      {
        'id': 'linkedin',
        'name': 'LinkedIn',
        'icon': Icons.business_center_rounded,
      },
      {'id': 'x', 'name': 'X / Twitter', 'icon': Icons.alternate_email_rounded},
      {
        'id': 'stackoverflow',
        'name': 'Stack Overflow',
        'icon': Icons.help_outline_rounded,
      },
      {'id': 'portfolio', 'name': 'Portfolio', 'icon': Icons.web_rounded},
      {
        'id': 'website',
        'name': 'Personal Website',
        'icon': Icons.language_rounded,
      },
      {
        'id': 'youtube',
        'name': 'YouTube',
        'icon': Icons.play_circle_outline_rounded,
      },
      {'id': 'other', 'name': 'Other', 'icon': Icons.link_rounded},
    ];

    Future<void> submit() async {
      if (!formKey.currentState!.validate()) return;
      isSubmitting.value = true;
      errorMessage.value = null;

      try {
        final url = urlController.text.trim();
        final label = labelController.text.trim().isEmpty
            ? null
            : labelController.text.trim();

        SocialLink saved;
        if (initialLink == null) {
          saved = await ref
              .read(socialLinksNotifierProvider.notifier)
              .addSocialLink(platform.value, url, label: label);
        } else {
          saved = await ref
              .read(socialLinksNotifierProvider.notifier)
              .updateSocialLink(
                initialLink!.id!,
                platform.value,
                url,
                label: label,
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
                        Icons.share_rounded,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        initialLink == null
                            ? 'Add Social Link'
                            : 'Edit Social Link',
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

                DropdownButtonFormField<String>(
                  initialValue: platform.value,
                  decoration: const InputDecoration(
                    labelText: 'Platform *',
                  ),
                  items: platforms.map((p) {
                    return DropdownMenuItem<String>(
                      value: p['id'] as String,
                      child: Row(
                        children: [
                          Icon(p['icon'] as IconData, size: 18),
                          const SizedBox(width: 10),
                          Text(p['name'] as String),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) platform.value = val;
                  },
                ),
                const SizedBox(height: 14),

                TextFormField(
                  controller: urlController,
                  enabled: !isSubmitting.value,
                  keyboardType: TextInputType.url,
                  decoration: const InputDecoration(
                    labelText: 'Link URL *',
                    hintText: 'https://github.com/username',
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'URL is required';
                    }
                    final uri = Uri.tryParse(val.trim());
                    if (uri == null ||
                        (!uri.isScheme('http') && !uri.isScheme('https'))) {
                      return 'Must be a valid URL starting with http:// or https://';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),

                TextFormField(
                  controller: labelController,
                  enabled: !isSubmitting.value,
                  decoration: const InputDecoration(
                    labelText: 'Custom Display Label (Optional)',
                    hintText: 'e.g. Open Source Repositories',
                  ),
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
                          : Text(initialLink == null ? 'Add Link' : 'Save'),
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
