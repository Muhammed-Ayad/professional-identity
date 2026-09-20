import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../logic/providers/inquiry_providers.dart';
import 'contact_inquiry_form_fields.dart';

class ContactInquiryDialog extends HookConsumerWidget {
  final String handle;
  final String recipientName;

  const ContactInquiryDialog({
    super.key,
    required this.handle,
    required this.recipientName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final subjectController = useTextEditingController();
    final messageController = useTextEditingController();
    final honeypotController = useTextEditingController();
    final selectedType = useState('job_offer');
    final isSubmitting = useState(false);
    final errorMessage = useState<String?>(null);

    Future<void> submit() async {
      if (!formKey.currentState!.validate()) return;

      isSubmitting.value = true;
      errorMessage.value = null;

      try {
        final repo = ref.read(inquiryRepositoryProvider);
        await repo.submitPublicInquiry(
          handle: handle,
          senderName: nameController.text.trim(),
          senderEmail: emailController.text.trim(),
          subject: subjectController.text.trim(),
          message: messageController.text.trim(),
          inquiryType: selectedType.value,
          honeypot: honeypotController.text,
        );

        if (context.mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Inquiry sent successfully to $recipientName!',
              ),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } catch (e) {
        errorMessage.value = e.toString().replaceFirst('Exception: ', '');
      } finally {
        isSubmitting.value = false;
      }
    }

    return AlertDialog(
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.send_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Contact $recipientName',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 520,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (errorMessage.value != null) ...[
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.red.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      errorMessage.value!,
                      style: const TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: 14),
                ],
                ContactInquiryFormFields(
                  nameController: nameController,
                  emailController: emailController,
                  subjectController: subjectController,
                  messageController: messageController,
                  honeypotController: honeypotController,
                  selectedType: selectedType.value,
                  onTypeChanged: (val) => selectedType.value = val,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: isSubmitting.value
              ? null
              : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton.icon(
          onPressed: isSubmitting.value ? null : submit,
          icon: isSubmitting.value
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.send_rounded, size: 16),
          label: Text(isSubmitting.value ? 'Sending...' : 'Send Inquiry'),
        ),
      ],
    );
  }
}
