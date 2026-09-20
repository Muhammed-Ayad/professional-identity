import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import '../../logic/providers/social_link_providers.dart';
import '../widgets/edit_social_link_dialog.dart';
import '../widgets/social_link_item_card.dart';

class SocialLinksScreen extends HookConsumerWidget {
  const SocialLinksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final linksAsync = ref.watch(socialLinksNotifierProvider);
    final theme = Theme.of(context);

    Future<void> confirmDelete(SocialLink link) async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Link'),
          content: Text(
            'Are you sure you want to remove your ${getPlatformDisplayName(link.platform)} link?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        await ref
            .read(socialLinksNotifierProvider.notifier)
            .deleteSocialLink(link.id!);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Removed ${getPlatformDisplayName(link.platform)} link',
              ),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Social & Professional Links'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            tooltip: 'Add Link',
            onPressed: () => EditSocialLinkDialog.show(context),
          ),
        ],
      ),
      body: SafeArea(
        child: linksAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  color: theme.colorScheme.error,
                  size: 44,
                ),
                const SizedBox(height: 12),
                Text('Failed to load links: $err'),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () =>
                      ref.read(socialLinksNotifierProvider.notifier).refresh(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
          data: (links) {
            if (links.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.08,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.share_outlined,
                          size: 48,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No Social Links Added Yet',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Connect your GitHub, LinkedIn, Twitter/X, and personal websites so visitors can reach your work.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () => EditSocialLinkDialog.show(context),
                        icon: const Icon(Icons.add_rounded),
                        label: const Text('Add Social Link'),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                      child: Row(
                        children: [
                          Text(
                            '${links.length} ${links.length == 1 ? 'link' : 'links'}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.drag_indicator_rounded,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Drag to reorder',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ReorderableListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        itemCount: links.length,
                        onReorderItem: (oldIndex, newIndex) {
                          ref
                              .read(socialLinksNotifierProvider.notifier)
                              .reorder(oldIndex, newIndex);
                        },
                        itemBuilder: (context, index) {
                          final link = links[index];
                          return SocialLinkItemCard(
                            key: ValueKey(link.id),
                            link: link,
                            index: index,
                            onDelete: () => confirmDelete(link),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
