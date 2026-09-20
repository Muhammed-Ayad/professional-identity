import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import 'public_profile_header_meta.dart';

class PublicProfileHeaderCard extends StatelessWidget {
  final PublicProfileData profile;
  final String handle;
  final WidgetRef ref;

  const PublicProfileHeaderCard({
    super.key,
    required this.profile,
    required this.handle,
    required this.ref,
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
          final isCompact = constraints.maxWidth < 650;
          final itemMaxWidth = isCompact ? (constraints.maxWidth - 40) : 320.0;

          final availabilityBadge = (profile.availability != null)
              ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.green.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          profile.availability!,
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )
              : null;

          if (isCompact) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 34,
                        backgroundColor: theme.colorScheme.primary,
                        child: Text(
                          profile.fullName.isNotEmpty
                              ? profile.fullName[0].toUpperCase()
                              : '?',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile.fullName,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            if (profile.currentRole != null) ...[
                              const SizedBox(height: 2),
                              Text(
                                profile.currentRole!,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (availabilityBadge != null) ...[
                    availabilityBadge,
                    const SizedBox(height: 8),
                  ],
                  if (profile.headline != null) ...[
                    Text(
                      profile.headline!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.8,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  PublicProfileContactMeta(
                    profile: profile,
                    itemMaxWidth: itemMaxWidth,
                  ),
                  PublicProfileSocialCvBar(
                    profile: profile,
                    handle: handle,
                    ref: ref,
                  ),
                ],
              ),
            );
          }

          // Desktop & Tablet View
          return Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 44,
                      backgroundColor: theme.colorScheme.primary,
                      child: Text(
                        profile.fullName.isNotEmpty
                            ? profile.fullName[0].toUpperCase()
                            : '?',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 12,
                            runSpacing: 8,
                            children: [
                              Text(
                                profile.fullName,
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              ?availabilityBadge,
                            ],
                          ),
                          if (profile.currentRole != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              profile.currentRole!,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                          if (profile.headline != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              profile.headline!,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.8,
                                ),
                              ),
                            ),
                          ],
                          const SizedBox(height: 8),
                          PublicProfileContactMeta(
                            profile: profile,
                            itemMaxWidth: itemMaxWidth,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                PublicProfileSocialCvBar(
                  profile: profile,
                  handle: handle,
                  ref: ref,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
