import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import 'package:professional_identity_flutter/core/utils/url_launcher_helper.dart';
import 'package:professional_identity_flutter/feature/analytics/logic/providers/analytics_providers.dart';
import 'public_profile_helpers.dart';

class PublicProfileSocialCvBar extends StatelessWidget {
  final PublicProfileData profile;
  final String handle;
  final WidgetRef ref;

  const PublicProfileSocialCvBar({
    super.key,
    required this.profile,
    required this.handle,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (profile.socialLinks.isEmpty && profile.cvUrl == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ...profile.socialLinks.map((link) {
              return ActionChip(
                avatar: getPublicSocialIcon(link.platform),
                label: Text(
                  link.label ?? link.platform.toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                onPressed: () {
                  ref
                      .read(analyticsRepositoryProvider)
                      .recordPublicEvent(
                        handle: handle,
                        eventType: 'social_link_click',
                        target: link.platform,
                      );
                  UrlLauncherHelper.openUrl(context, link.url);
                },
              );
            }),
            if (profile.cvUrl != null)
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.description_rounded, size: 18),
                label: const Text('View CV'),
                onPressed: () {
                  ref
                      .read(analyticsRepositoryProvider)
                      .recordPublicEvent(
                        handle: handle,
                        eventType: 'cv_view',
                      );
                  UrlLauncherHelper.openUrl(context, profile.cvUrl!);
                },
              ),
          ],
        ),
      ],
    );
  }
}

class PublicProfileContactMeta extends StatelessWidget {
  final PublicProfileData profile;
  final double itemMaxWidth;

  const PublicProfileContactMeta({
    super.key,
    required this.profile,
    required this.itemMaxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Wrap(
      spacing: 14,
      runSpacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        if (profile.location != null)
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: itemMaxWidth),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    profile.location!,
                    style: theme.textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        if (profile.websiteUrl != null)
          InkWell(
            onTap: () {
              UrlLauncherHelper.openUrl(context, profile.websiteUrl!);
            },
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: itemMaxWidth),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.language_rounded,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      profile.websiteUrl!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (profile.contactEmail != null)
          InkWell(
            onTap: () {
              UrlLauncherHelper.openUrl(context, profile.contactEmail!);
            },
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: itemMaxWidth),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.email_outlined,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      profile.contactEmail!,
                      style: theme.textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
