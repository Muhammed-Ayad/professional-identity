import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:professional_identity_flutter/core/utils/url_builder.dart';
import 'package:professional_identity_flutter/feature/analytics/logic/providers/analytics_providers.dart';
import 'package:professional_identity_flutter/feature/profile_customization/logic/models/profile_customization_theme.dart';
import '../../logic/providers/public_profile_providers.dart';
import '../widgets/public_profile_about_card.dart';
import '../widgets/public_profile_contact_card.dart';
import '../widgets/public_profile_experience_card.dart';
import '../widgets/public_profile_header_card.dart';
import '../widgets/public_profile_projects_card.dart';
import '../widgets/public_profile_qr_dialog.dart';
import '../widgets/public_profile_skills_card.dart';
import '../widgets/public_profile_states.dart';
import '../widgets/public_profile_theme_builder.dart';

class PublicProfileScreen extends HookConsumerWidget {
  final String handle;

  const PublicProfileScreen({super.key, required this.handle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(publicProfileFamilyProvider(handle));
    final theme = Theme.of(context);

    final hasTrackedView = useRef(false);
    useEffect(() {
      if (profileAsync.hasValue &&
          profileAsync.value != null &&
          !hasTrackedView.value) {
        hasTrackedView.value = true;
        ref
            .read(analyticsRepositoryProvider)
            .recordPublicEvent(
              handle: handle,
              eventType: 'profile_view',
            );
      }
      return null;
    }, [profileAsync.hasValue]);

    final pageTitle = profileAsync.valueOrNull != null
        ? '${profileAsync.valueOrNull!.fullName} | Professional Identity'
        : '/u/$handle | Professional Identity';

    return Title(
      title: pageTitle,
      color: theme.colorScheme.primary,
      child: Scaffold(
        appBar: AppBar(
          leading: Navigator.of(context).canPop()
              ? null
              : IconButton(
                  icon: const Icon(Icons.home_outlined),
                  tooltip: 'Dashboard / Sign In',
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                ),
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
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  '/u/$handle',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh_rounded),
              tooltip: 'Refresh Profile',
              onPressed: () => ref.refresh(publicProfileFamilyProvider(handle)),
            ),
            IconButton(
              icon: const Icon(Icons.qr_code_rounded),
              tooltip: 'View QR Code',
              onPressed: () => showPublicProfileQrDialog(context, ref, handle),
            ),
            IconButton(
              icon: const Icon(Icons.share_outlined),
              tooltip: 'Share Profile',
              onPressed: () {
                ref
                    .read(analyticsRepositoryProvider)
                    .recordPublicEvent(
                      handle: handle,
                      eventType: 'profile_share',
                    );
                final fullUrl = PublicProfileUrlBuilder.buildUrl(handle);
                SharePlus.instance.share(
                  ShareParams(
                    text:
                        'Check out my verified professional identity: $fullUrl',
                    subject: 'Professional Profile /u/$handle',
                  ),
                );
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: SafeArea(
          child: profileAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => PublicProfileErrorView(
              onRetry: () => ref.refresh(publicProfileFamilyProvider(handle)),
            ),
            data: (profile) {
              if (profile == null) {
                return const PublicProfileNotFoundView();
              }

              final customization =
                  profile.customization ??
                  ProfileCustomizationTheme.defaultCustomization;
              final isDark = customization.themePreset == 'dark';
              final customTheme = buildPublicProfileTheme(
                customization: profile.customization,
                fallbackTheme: theme,
              );

              return Theme(
                data: customTheme,
                child: Builder(
                  builder: (context) {
                    final activeTheme = Theme.of(context);

                    return Container(
                      decoration:
                          ProfileCustomizationTheme.getBackgroundDecoration(
                            customization: customization,
                            isDark: isDark,
                          ),
                      child: RefreshIndicator(
                        onRefresh: () async {
                          ref.invalidate(publicProfileFamilyProvider(handle));
                          await ref.read(
                            publicProfileFamilyProvider(handle).future,
                          );
                        },
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 24,
                          ),
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 860),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  PublicProfileHeaderCard(
                                    profile: profile,
                                    handle: handle,
                                    ref: ref,
                                  ),
                                  const SizedBox(height: 24),
                                  if ((profile.bio != null &&
                                          profile.bio!.isNotEmpty) ||
                                      profile.yearsOfExperience != null) ...[
                                    PublicProfileAboutCard(profile: profile),
                                    const SizedBox(height: 24),
                                  ],
                                  if (profile.skills.isNotEmpty) ...[
                                    PublicProfileSkillsCard(
                                      skills: profile.skills,
                                    ),
                                    const SizedBox(height: 24),
                                  ],
                                  if (profile.experiences.isNotEmpty) ...[
                                    PublicProfileExperienceCard(
                                      experiences: profile.experiences,
                                    ),
                                    const SizedBox(height: 24),
                                  ],
                                  if (profile.projects.isNotEmpty) ...[
                                    PublicProfileProjectsCard(
                                      projects: profile.projects,
                                      handle: handle,
                                      ref: ref,
                                    ),
                                    const SizedBox(height: 24),
                                  ],
                                  PublicProfileContactCard(
                                    profile: profile,
                                    handle: handle,
                                  ),
                                  const SizedBox(height: 24),
                                  Center(
                                    child: Text(
                                      'Verified digital identity powered by Professional Identity',
                                      style: activeTheme.textTheme.bodySmall
                                          ?.copyWith(
                                            color: activeTheme
                                                .colorScheme
                                                .onSurface
                                                .withValues(alpha: 0.4),
                                          ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
