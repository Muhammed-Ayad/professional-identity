import 'package:flutter/material.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import '../../../inquiries/view/widgets/contact_inquiry_dialog.dart';

class PublicProfileContactCard extends StatelessWidget {
  final PublicProfileData profile;
  final String handle;

  const PublicProfileContactCard({
    super.key,
    required this.profile,
    required this.handle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: theme.cardTheme.elevation ?? 0,
      shape: theme.cardTheme.shape,
      color: theme.cardTheme.color,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 600;

          final content = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.mark_email_read_outlined,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      'Get In Touch',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Have an opportunity, project proposal, or question? Send a direct professional inquiry.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          );

          final contactButton = ElevatedButton.icon(
            icon: const Icon(Icons.send_rounded, size: 16),
            label: const Text('Send Message'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: isCompact ? 16 : 20,
                vertical: isCompact ? 12 : 14,
              ),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => ContactInquiryDialog(
                  handle: handle,
                  recipientName: profile.fullName,
                ),
              );
            },
          );

          return Padding(
            padding: EdgeInsets.all(isCompact ? 16 : 24),
            child: isCompact
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      content,
                      const SizedBox(height: 16),
                      contactButton,
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: content),
                      const SizedBox(width: 24),
                      contactButton,
                    ],
                  ),
          );
        },
      ),
    );
  }
}
