import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import '../../../../core/utils/url_launcher_helper.dart';
import 'edit_social_link_dialog.dart';

IconData getPlatformIcon(String platform) {
  switch (platform.toLowerCase()) {
    case 'github':
      return Icons.code_rounded;
    case 'linkedin':
      return Icons.business_center_rounded;
    case 'x':
    case 'twitter':
      return Icons.alternate_email_rounded;
    case 'stackoverflow':
      return Icons.help_outline_rounded;
    case 'portfolio':
      return Icons.web_rounded;
    case 'website':
      return Icons.language_rounded;
    case 'youtube':
      return Icons.play_circle_outline_rounded;
    default:
      return Icons.link_rounded;
  }
}

String getPlatformDisplayName(String platform) {
  switch (platform.toLowerCase()) {
    case 'github':
      return 'GitHub';
    case 'linkedin':
      return 'LinkedIn';
    case 'x':
    case 'twitter':
      return 'X (Twitter)';
    case 'stackoverflow':
      return 'Stack Overflow';
    case 'portfolio':
      return 'Portfolio';
    case 'website':
      return 'Website';
    case 'youtube':
      return 'YouTube';
    default:
      return platform.isEmpty
          ? platform
          : platform[0].toUpperCase() + platform.substring(1);
  }
}

class SocialLinkItemCard extends StatelessWidget {
  final SocialLink link;
  final int index;
  final VoidCallback onDelete;

  const SocialLinkItemCard({
    super.key,
    required this.link,
    required this.index,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      key: ValueKey(link.id),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 2,
        ),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            getPlatformIcon(link.platform),
            size: 20,
            color: theme.colorScheme.primary,
          ),
        ),
        title: Row(
          children: [
            Flexible(
              child: Text(
                getPlatformDisplayName(link.platform),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            if (link.label != null && link.label!.isNotEmpty) ...[
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  '• ${link.label!}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ],
          ],
        ),
        subtitle: Text(
          link.url,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.secondary,
          ),
        ),
        onTap: () => UrlLauncherHelper.openUrl(context, link.url),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.all(3),
              constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
              icon: const Icon(Icons.open_in_new_rounded, size: 16),
              tooltip: 'Open Link',
              onPressed: () => UrlLauncherHelper.openUrl(context, link.url),
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.all(3),
              constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
              icon: const Icon(Icons.copy_rounded, size: 16),
              tooltip: 'Copy URL',
              onPressed: () {
                Clipboard.setData(ClipboardData(text: link.url));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('URL copied to clipboard'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.all(3),
              constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
              icon: const Icon(Icons.edit_outlined, size: 16),
              onPressed: () => EditSocialLinkDialog.show(
                context,
                initialLink: link,
              ),
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.all(3),
              constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
              icon: const Icon(Icons.delete_outline, size: 16),
              color: theme.colorScheme.error,
              onPressed: onDelete,
            ),
            ReorderableDragStartListener(
              index: index,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                child: Icon(Icons.drag_handle_rounded, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
