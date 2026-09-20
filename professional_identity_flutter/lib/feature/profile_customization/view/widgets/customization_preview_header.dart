import 'package:flutter/material.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import '../../logic/models/profile_customization_theme.dart';

class CustomizationPreviewHeaderCard extends StatelessWidget {
  final Profile? profile;
  final ProfileCustomization customization;
  final Color cardBgColor;
  final double cardElevation;
  final ShapeBorder cardShape;
  final Color primary;
  final Color textColor;
  final Color textSubColor;
  final TextTheme textTheme;

  const CustomizationPreviewHeaderCard({
    super.key,
    required this.profile,
    required this.customization,
    required this.cardBgColor,
    required this.cardElevation,
    required this.cardShape,
    required this.primary,
    required this.textColor,
    required this.textSubColor,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayName = profile?.fullName ?? 'Alex Morgan';
    final displayHeadline =
        profile?.headline ?? 'Senior Full-Stack & Cloud Engineer';
    final displayRole = profile?.currentRole ?? 'Lead Architect';
    final displayLocation = profile?.location ?? 'San Francisco, CA';

    final btnRadius = BorderRadius.circular(
      ProfileCustomizationTheme.getBorderRadius(
            customization.borderRadius,
          ) /
          2,
    );

    return Material(
      color: cardBgColor,
      elevation: cardElevation,
      shape: cardShape,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: primary,
                  child: Text(
                    displayName.isNotEmpty ? displayName[0].toUpperCase() : '?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        displayHeadline,
                        style: textTheme.bodyMedium?.copyWith(
                          color: textSubColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              displayRole,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: primary,
                              ),
                            ),
                          ),
                          if (displayLocation.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.06,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 10,
                                    color: textSubColor,
                                  ),
                                  const SizedBox(width: 3),
                                  Flexible(
                                    child: Text(
                                      displayLocation,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: textSubColor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Available',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Divider(height: 1),
            const SizedBox(height: 12),
            // Action buttons & links
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: btnRadius),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.description_rounded, size: 14),
                  label: const Text('View CV', style: TextStyle(fontSize: 12)),
                ),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primary,
                    side: BorderSide(color: primary.withValues(alpha: 0.5)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: btnRadius),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.share_rounded, size: 14),
                  label: const Text('Share', style: TextStyle(fontSize: 12)),
                ),
                ActionChip(
                  avatar: Icon(Icons.code_rounded, size: 14, color: primary),
                  label: const Text('GitHub', style: TextStyle(fontSize: 11)),
                  onPressed: () {},
                ),
                ActionChip(
                  avatar: Icon(Icons.link_rounded, size: 14, color: primary),
                  label: const Text('LinkedIn', style: TextStyle(fontSize: 11)),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
