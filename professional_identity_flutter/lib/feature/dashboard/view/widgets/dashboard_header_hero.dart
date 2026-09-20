import 'package:flutter/material.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import '../../../profile/view/widgets/edit_profile_dialog.dart';
import '../../../share/view/screens/share_identity_screen.dart';
import 'dashboard_hero_details.dart';

class DashboardHeaderHero extends StatelessWidget {
  final Profile profile;

  const DashboardHeaderHero({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final publicUrl = '/u/${profile.handle}';

    final actionButtons = Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        FilledButton.icon(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ShareIdentityScreen(
                initialProfile: profile,
              ),
            ),
          ),
          icon: const Icon(Icons.qr_code_2_rounded, size: 16),
          label: const Text('Share Identity'),
        ),
        OutlinedButton.icon(
          onPressed: () => Navigator.of(context).pushNamed(publicUrl),
          icon: const Icon(Icons.visibility_outlined, size: 16),
          label: const Text('View Public'),
        ),
        OutlinedButton.icon(
          onPressed: () => EditProfileDialog.show(
            context,
            initialProfile: profile,
          ),
          icon: const Icon(Icons.edit_outlined, size: 16),
          label: const Text('Edit Profile'),
        ),
      ],
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isCompact = constraints.maxWidth < 780;

            if (isCompact) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: theme.colorScheme.primary,
                        child: Text(
                          profile.fullName.isNotEmpty
                              ? profile.fullName[0].toUpperCase()
                              : '?',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          profile.fullName,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  DashboardHeroDetails(profile: profile, includeName: false),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  actionButtons,
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: theme.colorScheme.primary,
                  child: Text(
                    profile.fullName.isNotEmpty
                        ? profile.fullName[0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: DashboardHeroDetails(
                    profile: profile,
                    includeName: true,
                  ),
                ),
                const SizedBox(width: 16),
                actionButtons,
              ],
            );
          },
        ),
      ),
    );
  }
}
