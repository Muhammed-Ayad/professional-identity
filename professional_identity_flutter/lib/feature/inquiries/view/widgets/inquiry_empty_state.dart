import 'package:flutter/material.dart';
import '../../logic/models/inquiry_filter.dart';

class InquiryEmptyState extends StatelessWidget {
  final InquiryFilter filter;

  const InquiryEmptyState({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String title;
    String subtitle;
    IconData icon;

    switch (filter) {
      case InquiryFilter.all:
        title = 'No inquiries yet';
        subtitle =
            'When recruiters and clients contact you from your public profile, their messages will appear here.';
        icon = Icons.mark_email_read_outlined;
        break;
      case InquiryFilter.unread:
        title = 'No unread inquiries';
        subtitle = 'You have read all received messages!';
        icon = Icons.done_all_rounded;
        break;
      case InquiryFilter.archived:
        title = 'No archived inquiries';
        subtitle = 'Inquiries that you archive will be stored here.';
        icon = Icons.archive_outlined;
        break;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 40, color: theme.colorScheme.primary),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 380),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
