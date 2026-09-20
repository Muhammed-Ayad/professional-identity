import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import '../../../analytics/view/screens/analytics_screen.dart';
import '../../../cv/view/screens/cv_screen.dart';
import '../../../experience/view/screens/experience_screen.dart';
import '../../../inquiries/logic/providers/inquiry_providers.dart';
import '../../../inquiries/view/screens/inquiries_screen.dart';
import '../../../profile_customization/view/screens/profile_customization_screen.dart';
import '../../../projects/view/screens/projects_screen.dart';
import '../../../share/view/screens/share_identity_screen.dart';
import '../../../skills/view/screens/skills_screen.dart';
import '../../../social_links/view/screens/social_links_screen.dart';
import 'dashboard_module_card.dart';

class DashboardModulesGrid extends ConsumerWidget {
  final Profile profile;
  final List<Skill> skills;
  final List<Experience> experiences;
  final List<SocialLink> socialLinks;
  final List<Project> projects;
  final String? cvUrl;
  final AsyncValue<AnalyticsSummary?> analyticsAsync;

  const DashboardModulesGrid({
    super.key,
    required this.profile,
    required this.skills,
    required this.experiences,
    required this.socialLinks,
    required this.projects,
    required this.cvUrl,
    required this.analyticsAsync,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadInquiries = ref.watch(unreadInquiriesCountProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 850;
        final isMedium = constraints.maxWidth > 560;
        final cardWidth = isWide
            ? (constraints.maxWidth - 32) / 3
            : isMedium
            ? (constraints.maxWidth - 16) / 2
            : double.infinity;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            // Projects Module Card
            SizedBox(
              width: cardWidth,
              child: DashboardModuleCard(
                title: 'Projects',
                count:
                    '${projects.length} ${projects.length == 1 ? 'project' : 'projects'}',
                subtitle: projects.isEmpty
                    ? 'No projects added yet'
                    : projects.take(2).map((p) => p.title).join(', '),
                icon: Icons.folder_special_outlined,
                buttonLabel: 'Manage Projects',
                onManage: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ProjectsScreen()),
                ),
              ),
            ),

            // CV & Resume Module Card
            SizedBox(
              width: cardWidth,
              child: DashboardModuleCard(
                title: 'CV & Resume',
                count: (cvUrl != null && cvUrl!.isNotEmpty)
                    ? 'CV: Uploaded'
                    : 'CV: Not uploaded',
                subtitle: (cvUrl != null && cvUrl!.isNotEmpty)
                    ? 'PDF document verified'
                    : 'Upload PDF (max 5 MB)',
                icon: Icons.description_outlined,
                buttonLabel: (cvUrl != null && cvUrl!.isNotEmpty)
                    ? 'Manage CV'
                    : 'Upload CV',
                onManage: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CvScreen()),
                ),
              ),
            ),

            // Skills Module Card
            SizedBox(
              width: cardWidth,
              child: DashboardModuleCard(
                title: 'Skills',
                count:
                    '${skills.length} ${skills.length == 1 ? 'skill' : 'skills'}',
                subtitle: skills.isEmpty
                    ? 'No skills added yet'
                    : skills.take(3).map((s) => s.name).join(', '),
                icon: Icons.bolt_rounded,
                buttonLabel: 'Manage Skills',
                onManage: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SkillsScreen()),
                ),
              ),
            ),

            // Experience Module Card
            SizedBox(
              width: cardWidth,
              child: DashboardModuleCard(
                title: 'Experience',
                count:
                    '${experiences.length} ${experiences.length == 1 ? 'role' : 'roles'}',
                subtitle: experiences.isEmpty
                    ? 'No positions added yet'
                    : '${experiences.first.jobTitle} at ${experiences.first.company}',
                icon: Icons.work_outline_rounded,
                buttonLabel: 'Manage Experience',
                onManage: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ExperienceScreen(),
                  ),
                ),
              ),
            ),

            // Social Links Module Card
            SizedBox(
              width: cardWidth,
              child: DashboardModuleCard(
                title: 'Social Links',
                count:
                    '${socialLinks.length} ${socialLinks.length == 1 ? 'link' : 'links'}',
                subtitle: socialLinks.isEmpty
                    ? 'No links added yet'
                    : socialLinks
                          .take(3)
                          .map((l) => l.platform.toUpperCase())
                          .join(', '),
                icon: Icons.share_rounded,
                buttonLabel: 'Manage Links',
                onManage: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const SocialLinksScreen(),
                  ),
                ),
              ),
            ),

            // Share & QR Identity Module Card
            SizedBox(
              width: cardWidth,
              child: DashboardModuleCard(
                title: 'Share Identity',
                count: 'QR & Link',
                subtitle: 'Share your unified professional profile',
                icon: Icons.qr_code_2_rounded,
                buttonLabel: 'Share Profile',
                onManage: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ShareIdentityScreen(
                      initialProfile: profile,
                    ),
                  ),
                ),
              ),
            ),

            // Analytics Module Card
            SizedBox(
              width: cardWidth,
              child: DashboardModuleCard(
                title: 'Analytics',
                count: analyticsAsync.when(
                  data: (data) => data != null
                      ? '${data.totalProfileViews} views'
                      : 'Overview',
                  loading: () => 'Loading...',
                  error: (_, _) => 'Analytics ready',
                ),
                subtitle: analyticsAsync.when(
                  data: (data) => data != null
                      ? '${data.totalSocialLinkClicks} social • ${data.totalProjectClicks} project'
                      : 'Privacy-first traffic insights',
                  loading: () => 'Fetching stats...',
                  error: (_, _) => 'Tap to open dashboard',
                ),
                icon: Icons.insights_rounded,
                buttonLabel: 'View Analytics',
                onManage: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const AnalyticsScreen(),
                  ),
                ),
              ),
            ),

            // Customize Profile Module Card
            SizedBox(
              width: cardWidth,
              child: DashboardModuleCard(
                title: 'Customize Profile',
                count: 'Theme & Branding',
                subtitle: 'Colors, card styles, and visual appearance',
                icon: Icons.palette_rounded,
                buttonLabel: 'Customize',
                onManage: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ProfileCustomizationScreen(),
                  ),
                ),
              ),
            ),

            // Inquiries Module Card
            SizedBox(
              width: cardWidth,
              child: DashboardModuleCard(
                title: 'Contact Inquiries',
                count: unreadInquiries > 0
                    ? '$unreadInquiries unread'
                    : 'All caught up',
                subtitle: 'Recruiter and client messages from public profile',
                icon: Icons.mail_outline_rounded,
                buttonLabel: 'View Inquiries',
                onManage: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const InquiriesScreen(),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
