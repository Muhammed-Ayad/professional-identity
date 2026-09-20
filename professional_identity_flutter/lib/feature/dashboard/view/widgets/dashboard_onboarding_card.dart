import 'package:flutter/material.dart';
import '../../../profile/view/widgets/edit_profile_dialog.dart';

class DashboardOnboardingCard extends StatelessWidget {
  const DashboardOnboardingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.badge_outlined,
                size: 48,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Set Up Your Professional Identity',
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Text(
                'Claim your custom public handle (e.g. /u/your-name), add your title, summary, and contact information to create your unified profile.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => EditProfileDialog.show(context),
              icon: const Icon(Icons.add_rounded),
              label: const Text('Create Profile Now'),
            ),
          ],
        ),
      ),
    );
  }
}
