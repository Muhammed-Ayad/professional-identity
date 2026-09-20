import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import '../../logic/providers/inquiry_providers.dart';

class InquiryDetailsDialog extends ConsumerWidget {
  final ContactInquiry inquiry;

  const InquiryDetailsDialog({super.key, required this.inquiry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final formattedDate =
        '${inquiry.createdAt.year}-${inquiry.createdAt.month.toString().padLeft(2, '0')}-${inquiry.createdAt.day.toString().padLeft(2, '0')} ${inquiry.createdAt.hour.toString().padLeft(2, '0')}:${inquiry.createdAt.minute.toString().padLeft(2, '0')}';

    return AlertDialog(
      title: Row(
        children: [
          Expanded(
            child: Text(
              inquiry.subject,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      content: SizedBox(
        width: 550,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: theme.colorScheme.primary,
                    child: Text(
                      inquiry.senderName.isNotEmpty
                          ? inquiry.senderName[0].toUpperCase()
                          : '?',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          inquiry.senderName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(text: inquiry.senderEmail),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Copied ${inquiry.senderEmail}'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          child: Text(
                            inquiry.senderEmail,
                            style: TextStyle(
                              color: theme.colorScheme.secondary,
                              fontSize: 13,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Text(
                          formattedDate,
                          style: TextStyle(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.5,
                            ),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              SelectableText(
                inquiry.message,
                style: const TextStyle(fontSize: 14, height: 1.5),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          tooltip: inquiry.isArchived ? 'Unarchive' : 'Archive',
          icon: Icon(
            inquiry.isArchived
                ? Icons.unarchive_outlined
                : Icons.archive_outlined,
          ),
          onPressed: () {
            ref
                .read(inquiriesListProvider.notifier)
                .toggleArchive(inquiry.id!, !inquiry.isArchived);
            Navigator.of(context).pop();
          },
        ),
        IconButton(
          tooltip: 'Delete Inquiry',
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: () {
            ref.read(inquiriesListProvider.notifier).deleteInquiry(inquiry.id!);
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.reply_rounded, size: 16),
          label: const Text('Reply via Email'),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: inquiry.senderEmail));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Email address ${inquiry.senderEmail} copied to clipboard!',
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
      ],
    );
  }
}
