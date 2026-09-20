import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import '../../logic/providers/inquiry_providers.dart';
import 'inquiry_details_dialog.dart';

class InquiryItemCard extends ConsumerWidget {
  final ContactInquiry inquiry;

  const InquiryItemCard({super.key, required this.inquiry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isUnread = !inquiry.isRead;

    Color badgeColor;
    String typeLabel;
    switch (inquiry.inquiryType) {
      case 'job_offer':
        badgeColor = Colors.green;
        typeLabel = 'Job Offer';
        break;
      case 'freelance':
        badgeColor = Colors.purple;
        typeLabel = 'Freelance';
        break;
      case 'collaboration':
        badgeColor = Colors.blue;
        typeLabel = 'Collaboration';
        break;
      case 'speaking':
        badgeColor = Colors.orange;
        typeLabel = 'Speaking';
        break;
      default:
        badgeColor = Colors.grey;
        typeLabel = 'General';
    }

    final formattedDate = '${inquiry.createdAt.month}/${inquiry.createdAt.day}';

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: isUnread
              ? theme.colorScheme.primary.withValues(alpha: 0.5)
              : theme.colorScheme.outline.withValues(alpha: 0.2),
          width: isUnread ? 1.5 : 1.0,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          if (isUnread) {
            ref
                .read(inquiriesListProvider.notifier)
                .toggleRead(inquiry.id!, true);
          }
          showDialog(
            context: context,
            builder: (_) => InquiryDetailsDialog(inquiry: inquiry),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 6, right: 12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isUnread
                      ? theme.colorScheme.primary
                      : Colors.transparent,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: badgeColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            typeLabel,
                            style: TextStyle(
                              color: badgeColor,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            inquiry.senderName,
                            style: TextStyle(
                              fontWeight: isUnread
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
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
                    const SizedBox(height: 6),
                    Text(
                      inquiry.subject,
                      style: TextStyle(
                        fontWeight: isUnread
                            ? FontWeight.w700
                            : FontWeight.w600,
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      inquiry.message,
                      style: TextStyle(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.7,
                        ),
                        fontSize: 13,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, size: 18),
                onSelected: (action) {
                  final notifier = ref.read(inquiriesListProvider.notifier);
                  switch (action) {
                    case 'toggle_read':
                      notifier.toggleRead(inquiry.id!, !inquiry.isRead);
                      break;
                    case 'toggle_archive':
                      notifier.toggleArchive(inquiry.id!, !inquiry.isArchived);
                      break;
                    case 'delete':
                      notifier.deleteInquiry(inquiry.id!);
                      break;
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'toggle_read',
                    child: Text(
                      inquiry.isRead ? 'Mark as Unread' : 'Mark as Read',
                    ),
                  ),
                  PopupMenuItem(
                    value: 'toggle_archive',
                    child: Text(inquiry.isArchived ? 'Unarchive' : 'Archive'),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
