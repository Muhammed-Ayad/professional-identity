import 'package:flutter/material.dart';
import 'package:professional_identity_client/professional_identity_client.dart';

class PublicProfileAboutCard extends StatelessWidget {
  final PublicProfileData profile;

  const PublicProfileAboutCard({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: theme.cardTheme.elevation ?? 0,
      shape: theme.cardTheme.shape,
      color: theme.cardTheme.color,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.person_outline_rounded, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'About',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                if (profile.yearsOfExperience != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${profile.yearsOfExperience}+ Years Experience',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            if (profile.bio != null && profile.bio!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                profile.bio!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.85),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
