import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';

import '../../../analytics/logic/providers/analytics_providers.dart';
import '../../../auth/logic/providers/auth_providers.dart';
import '../../../cv/logic/providers/cv_providers.dart';
import '../../../experience/logic/providers/experience_providers.dart';
import '../../../profile/logic/providers/profile_providers.dart';
import '../../../projects/logic/providers/project_providers.dart';
import '../../../skills/logic/providers/skill_providers.dart';
import '../../../social_links/logic/providers/social_link_providers.dart';
import '../widgets/dashboard_completion_card.dart';
import '../widgets/dashboard_header_hero.dart';
import '../widgets/dashboard_modules_grid.dart';
import '../widgets/dashboard_onboarding_card.dart';

class DashboardScreen extends HookConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(userProfileNotifierProvider);
    final theme = Theme.of(context);

    Future<void> confirmSignOut() async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Sign out'),
          content: const Text(
            'Are you sure you want to sign out of Professional Identity?',
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
              child: const Text('Sign out'),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        await ref.read(authRepositoryProvider).signOut();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.fingerprint_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
            const Flexible(
              child: Text(
                'Professional Identity',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Refresh All',
            onPressed: () {
              ref.read(userProfileNotifierProvider.notifier).refresh();
              ref.read(skillsNotifierProvider.notifier).refresh();
              ref.read(experienceNotifierProvider.notifier).refresh();
              ref.read(socialLinksNotifierProvider.notifier).refresh();
              ref.read(projectsNotifierProvider.notifier).refresh();
              ref.read(cvNotifierProvider.notifier).refresh();
              ref.invalidate(dashboardAnalyticsSummaryProvider);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Sign Out',
            onPressed: confirmSignOut,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: profileAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (err, stack) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    color: theme.colorScheme.error,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading profile',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    err.toString(),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => ref
                        .read(userProfileNotifierProvider.notifier)
                        .refresh(),
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            ),
          ),
          data: (profile) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 960),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (profile == null)
                        const DashboardOnboardingCard()
                      else
                        _buildProfileDashboard(context, ref, profile, theme),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileDashboard(
    BuildContext context,
    WidgetRef ref,
    Profile profile,
    ThemeData theme,
  ) {
    final skills = ref.watch(skillsNotifierProvider).valueOrNull ?? [];
    final experiences = ref.watch(experienceNotifierProvider).valueOrNull ?? [];
    final socialLinks =
        ref.watch(socialLinksNotifierProvider).valueOrNull ?? [];
    final projects = ref.watch(projectsNotifierProvider).valueOrNull ?? [];
    final cvUrl = ref.watch(cvNotifierProvider).valueOrNull ?? profile.cvUrl;
    final analyticsAsync = ref.watch(dashboardAnalyticsSummaryProvider);

    // Profile completion calculation: exact 6 criteria requested
    final hasHeadlineAndBio =
        (profile.headline != null && profile.headline!.trim().isNotEmpty) &&
        (profile.bio != null && profile.bio!.trim().isNotEmpty);
    final hasSkills = skills.length >= 3;
    final hasExperience = experiences.isNotEmpty;
    final hasProject = projects.isNotEmpty;
    final hasSocialLink = socialLinks.isNotEmpty;
    final hasCv = cvUrl != null && cvUrl.isNotEmpty;

    int completionScore = 0;
    if (hasHeadlineAndBio) completionScore += 15;
    if (hasSkills) completionScore += 20;
    if (hasExperience) completionScore += 20;
    if (hasProject) completionScore += 20;
    if (hasSocialLink) completionScore += 15;
    if (hasCv) completionScore += 10;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Top Hero Card
        DashboardHeaderHero(profile: profile),
        const SizedBox(height: 20),

        // Profile Completion Card
        DashboardCompletionCard(
          completionScore: completionScore,
          hasHeadlineAndBio: hasHeadlineAndBio,
          hasSkills: hasSkills,
          hasExperience: hasExperience,
          hasProject: hasProject,
          hasSocialLink: hasSocialLink,
          hasCv: hasCv,
        ),
        const SizedBox(height: 20),

        // Modules Management Grid
        DashboardModulesGrid(
          profile: profile,
          skills: skills,
          experiences: experiences,
          socialLinks: socialLinks,
          projects: projects,
          cvUrl: cvUrl,
          analyticsAsync: analyticsAsync,
        ),
        const SizedBox(height: 20),

        // Bio Card
        if (profile.bio != null && profile.bio!.isNotEmpty) ...[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    profile.bio!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ],
    );
  }
}
