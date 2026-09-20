import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import 'package:professional_identity_flutter/client.dart';
import 'package:professional_identity_flutter/feature/auth/logic/providers/auth_providers.dart';
import 'package:professional_identity_flutter/feature/public_profile/logic/providers/public_profile_providers.dart';
import 'package:professional_identity_flutter/feature/public_profile/view/screens/public_profile_screen.dart';
import 'package:professional_identity_flutter/main.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

void main() {
  setUpAll(() {
    client = Client('http://localhost:8080/')
      ..connectivityMonitor = FlutterConnectivityMonitor()
      ..authSessionManager = FlutterAuthSessionManager();
  });
  final sampleSkills = [
    Skill(
      id: 1,
      profileId: 10,
      name: 'Flutter',
      category: 'Mobile',
      yearsOfExperience: 5,
      sortOrder: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Skill(
      id: 2,
      profileId: 10,
      name: 'Dart & Serverpod',
      category: 'Backend',
      yearsOfExperience: 3,
      sortOrder: 1,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  final sampleExperiences = [
    Experience(
      id: 1,
      profileId: 10,
      company: 'Antigravity Labs',
      jobTitle: 'Principal Engineer',
      startDate: DateTime(2022, 1, 1),
      isCurrent: true,
      description: 'Architecting cutting-edge developer platforms.',
      sortOrder: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  final sampleProjects = [
    Project(
      id: 1,
      profileId: 10,
      title: 'Professional Identity Engine',
      role: 'Lead Architect',
      description: 'A unified single-link professional identity ecosystem.',
      technologies: ['Flutter', 'Serverpod', 'PostgreSQL'],
      url: 'https://example.com/demo',
      repositoryUrl: 'https://github.com/example/demo',
      isOngoing: true,
      sortOrder: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  final sampleSocialLinks = [
    SocialLink(
      id: 1,
      profileId: 10,
      platform: 'GitHub',
      url: 'https://github.com/mohamed-ayad',
      sortOrder: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  final samplePublicProfile = PublicProfileData(
    handle: 'mohamed-ayad',
    fullName: 'Mohamed Ayad',
    headline: 'Full-Stack Software Architect & Cloud Engineer',
    bio:
        'Passionate about building scalable distributed systems and beautiful Flutter apps.',
    location: 'Dubai, UAE',
    currentRole: 'Principal Architect',
    yearsOfExperience: 8,
    availability: 'Open to consulting',
    contactEmail: 'mohamed@example.com',
    websiteUrl: 'https://mohamedayad.dev',
    cvUrl: 'https://storage.example.com/cv.pdf',
    isPublic: true,
    skills: sampleSkills,
    experiences: sampleExperiences,
    projects: sampleProjects,
    socialLinks: sampleSocialLinks,
  );

  testWidgets('PublicProfileScreen shows loading indicator while fetching', (
    tester,
  ) async {
    final completer = Completer<PublicProfileData?>();
    addTearDown(() {
      if (!completer.isCompleted) completer.complete(null);
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          publicProfileFamilyProvider('loading-user').overrideWith(
            (ref) => completer.future,
          ),
        ],
        child: const MaterialApp(
          home: PublicProfileScreen(handle: 'loading-user'),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('/u/loading-user'), findsOneWidget);
  });

  testWidgets(
    'PublicProfileScreen renders complete public profile with all sections',
    (tester) async {
      tester.view.physicalSize = const Size(1280, 1800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            publicProfileFamilyProvider('mohamed-ayad').overrideWith(
              (ref) => samplePublicProfile,
            ),
          ],
          child: const MaterialApp(
            home: PublicProfileScreen(handle: 'mohamed-ayad'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Header hero elements
      expect(find.text('Mohamed Ayad'), findsOneWidget);
      expect(
        find.text('Full-Stack Software Architect & Cloud Engineer'),
        findsOneWidget,
      );
      expect(find.text('/u/mohamed-ayad'), findsOneWidget);
      expect(find.text('Open to consulting'), findsOneWidget);
      expect(find.text('Dubai, UAE'), findsOneWidget);
      expect(find.text('mohamed@example.com'), findsOneWidget);
      expect(find.text('https://mohamedayad.dev'), findsOneWidget);
      expect(find.text('View CV'), findsOneWidget);

      // About section
      expect(find.text('About'), findsOneWidget);
      expect(
        find.text(
          'Passionate about building scalable distributed systems and beautiful Flutter apps.',
        ),
        findsOneWidget,
      );
      expect(find.text('8+ Years Experience'), findsOneWidget);

      // Skills section
      expect(find.text('Skills & Expertise'), findsOneWidget);
      expect(find.text('Flutter'), findsWidgets);
      expect(find.text('Dart & Serverpod'), findsOneWidget);

      // Experience timeline
      expect(find.text('Work Experience'), findsOneWidget);
      expect(find.text('Principal Engineer'), findsOneWidget);
      expect(find.text('Antigravity Labs'), findsOneWidget);
      expect(find.text('Current'), findsOneWidget);

      // Projects section
      expect(find.text('Featured Projects'), findsOneWidget);
      expect(find.text('Professional Identity Engine'), findsOneWidget);
      expect(find.text('Live Demo'), findsOneWidget);
      expect(find.text('Repository'), findsOneWidget);

      // Branding footer
      expect(
        find.text('Verified digital identity powered by Professional Identity'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'PublicProfileScreen renders "Profile not found" for missing or private handles',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            publicProfileFamilyProvider('private-or-missing').overrideWith(
              (ref) => null,
            ),
          ],
          child: const MaterialApp(
            home: PublicProfileScreen(handle: 'private-or-missing'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Profile not found'), findsOneWidget);
      expect(
        find.text(
          "The profile you're looking for doesn't exist or is not publicly available.",
        ),
        findsOneWidget,
      );
      expect(find.text('Mohamed Ayad'), findsNothing);
    },
  );

  testWidgets(
    'PublicProfileScreen gracefully hides empty sections when optional data is absent',
    (tester) async {
      tester.view.physicalSize = const Size(1280, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final minimalProfile = PublicProfileData(
        handle: 'minimal-user',
        fullName: 'Jane Minimalist',
        isPublic: true,
        skills: [],
        experiences: [],
        projects: [],
        socialLinks: [],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            publicProfileFamilyProvider('minimal-user').overrideWith(
              (ref) => minimalProfile,
            ),
          ],
          child: const MaterialApp(
            home: PublicProfileScreen(handle: 'minimal-user'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Jane Minimalist'), findsOneWidget);
      expect(find.text('/u/minimal-user'), findsOneWidget);

      // Absent sections should not appear
      expect(find.text('About'), findsNothing);
      expect(find.text('Skills & Expertise'), findsNothing);
      expect(find.text('Work Experience'), findsNothing);
      expect(find.text('Featured Projects'), findsNothing);
      expect(find.text('View CV'), findsNothing);
    },
  );

  testWidgets(
    'PublicProfileScreen renders cleanly on narrow mobile viewport without overflows',
    (tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final profileWithLongTexts = PublicProfileData(
        handle: 'very-long-handle-name-professional',
        fullName: 'Dr. Alexander Bartholomew Montgomery III',
        headline:
            'Senior Principal Cloud Architect & Distributed Infrastructure Lead at Tech Global Enterprises',
        bio:
            'Leading cross-functional engineering organizations across multiple continents.',
        location: 'San Francisco Bay Area, California, United States',
        currentRole:
            'Senior Principal Infrastructure & Cloud Solutions Architect',
        yearsOfExperience: 15,
        availability:
            'Open to advisory roles and selective consulting opportunities',
        contactEmail:
            'alexander.bartholomew.montgomery@enterprise-domain.example.com',
        websiteUrl:
            'https://www.linkedin.com/in/alexander-bartholomew-montgomery-phd-cloud-architect-123456789/',
        cvUrl:
            'https://storage.example.com/downloads/v1/resumes/alexander_montgomery_cv_comprehensive_2026.pdf',
        isPublic: true,
        skills: sampleSkills,
        experiences: sampleExperiences,
        projects: sampleProjects,
        socialLinks: [
          SocialLink(
            id: 1,
            profileId: 10,
            platform: 'LinkedIn',
            url: 'https://www.linkedin.com/in/alexander-montgomery-123456789/',
            sortOrder: 0,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          SocialLink(
            id: 2,
            profileId: 10,
            platform: 'GitHub',
            url:
                'https://github.com/alexander-montgomery-enterprise-cloud-systems',
            sortOrder: 1,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            publicProfileFamilyProvider(
              'very-long-handle-name-professional',
            ).overrideWith((ref) => profileWithLongTexts),
          ],
          child: const MaterialApp(
            home: PublicProfileScreen(
              handle: 'very-long-handle-name-professional',
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(
        find.text('Dr. Alexander Bartholomew Montgomery III'),
        findsOneWidget,
      );
      expect(find.text('About'), findsOneWidget);
      expect(find.text('Skills & Expertise'), findsOneWidget);
      expect(find.text('Work Experience'), findsOneWidget);
      expect(find.text('Featured Projects'), findsOneWidget);
    },
  );

  group('Responsive Viewport Simulation', () {
    final viewports = <String, Size>{
      'Standard Mobile (390x844)': const Size(390, 844),
      'Small Mobile (320x568)': const Size(320, 568),
      'Tablet (768x1024)': const Size(768, 1024),
      'Desktop (1440x900)': const Size(1440, 900),
    };

    for (final entry in viewports.entries) {
      testWidgets('renders cleanly on ${entry.key} without overflows', (
        tester,
      ) async {
        tester.view.physicalSize = entry.value;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              publicProfileFamilyProvider('mohamed-ayad').overrideWith(
                (ref) => samplePublicProfile,
              ),
            ],
            child: const MaterialApp(
              home: PublicProfileScreen(handle: 'mohamed-ayad'),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        expect(find.text('Mohamed Ayad'), findsOneWidget);
        expect(find.text('/u/mohamed-ayad'), findsOneWidget);
        expect(find.text('About'), findsOneWidget);
        expect(find.text('Skills & Expertise'), findsOneWidget);
        expect(find.text('Work Experience'), findsOneWidget);
        expect(find.text('Featured Projects'), findsOneWidget);
        expect(find.text('View CV'), findsOneWidget);
      });
    }
  });

  group('Route Verification and Auth Independence', () {
    testWidgets('navigates to /u/mohamed-ayad without authentication', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1280, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final originalOnError = FlutterError.onError;
      FlutterError.onError = (details) {
        if (details.exceptionAsString().contains('overflowed')) {
          return;
        }
        originalOnError?.call(details);
      };
      addTearDown(() => FlutterError.onError = originalOnError);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authStateProvider.overrideWith((ref) => Stream.value(false)),
            publicProfileFamilyProvider('mohamed-ayad').overrideWith(
              (ref) => samplePublicProfile,
            ),
          ],
          child: MaterialApp(
            onGenerateRoute: (settings) {
              final name = settings.name;
              if (name != null && name.startsWith('/u/')) {
                final handle = name.substring('/u/'.length).trim();
                return MaterialPageRoute<void>(
                  settings: settings,
                  builder: (_) => PublicProfileScreen(handle: handle),
                );
              }
              return MaterialPageRoute<void>(
                settings: settings,
                builder: (_) => const AuthGate(),
              );
            },
            initialRoute: '/u/mohamed-ayad',
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(PublicProfileScreen), findsOneWidget);
      expect(find.text('Mohamed Ayad'), findsOneWidget);
      expect(find.byType(AuthGate), findsNothing);
    });

    testWidgets('navigates to /u/test-user and /u/Mohamed-Ayad correctly', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1280, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final originalOnError = FlutterError.onError;
      FlutterError.onError = (details) {
        if (details.exceptionAsString().contains('overflowed')) {
          return;
        }
        originalOnError?.call(details);
      };
      addTearDown(() => FlutterError.onError = originalOnError);

      final testProfile = PublicProfileData(
        handle: 'test-user',
        fullName: 'Test User',
        isPublic: true,
        skills: [],
        experiences: [],
        projects: [],
        socialLinks: [],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authStateProvider.overrideWith((ref) => Stream.value(false)),
            publicProfileFamilyProvider('test-user').overrideWith(
              (ref) => testProfile,
            ),
          ],
          child: MaterialApp(
            onGenerateRoute: (settings) {
              final name = settings.name;
              if (name != null && name.startsWith('/u/')) {
                final handle = name.substring('/u/'.length).trim();
                return MaterialPageRoute<void>(
                  settings: settings,
                  builder: (_) => PublicProfileScreen(handle: handle),
                );
              }
              return MaterialPageRoute<void>(
                settings: settings,
                builder: (_) => const AuthGate(),
              );
            },
            initialRoute: '/u/test-user',
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(PublicProfileScreen), findsOneWidget);
      expect(find.text('Test User'), findsOneWidget);
      expect(find.text('/u/test-user'), findsOneWidget);
    });

    testWidgets('unrelated route falls through to AuthGate', (tester) async {
      tester.view.physicalSize = const Size(1280, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final originalOnError = FlutterError.onError;
      FlutterError.onError = (details) {
        if (details.exceptionAsString().contains('overflowed')) {
          return;
        }
        originalOnError?.call(details);
      };
      addTearDown(() => FlutterError.onError = originalOnError);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authStateProvider.overrideWith((ref) => Stream.value(false)),
          ],
          child: MaterialApp(
            onGenerateRoute: (settings) {
              final name = settings.name;
              if (name != null && name.startsWith('/u/')) {
                final handle = name.substring('/u/'.length).trim();
                return MaterialPageRoute<void>(
                  settings: settings,
                  builder: (_) => PublicProfileScreen(handle: handle),
                );
              }
              return MaterialPageRoute<void>(
                settings: settings,
                builder: (_) => const AuthGate(),
              );
            },
            initialRoute: '/unrelated-route',
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(AuthGate), findsOneWidget);
      expect(find.byType(PublicProfileScreen), findsNothing);
    });

    testWidgets(
      'ProfessionalIdentityApp opens /u/mohamed-ayad directly without auth gate for unauthenticated users',
      (tester) async {
        tester.view.physicalSize = const Size(1280, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final originalOnError = FlutterError.onError;
        FlutterError.onError = (details) {
          if (details.exceptionAsString().contains('overflowed')) {
            return;
          }
          originalOnError?.call(details);
        };
        addTearDown(() => FlutterError.onError = originalOnError);

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              authStateProvider.overrideWith((ref) => Stream.value(false)),
              publicProfileFamilyProvider('mohamed-ayad').overrideWith(
                (ref) => samplePublicProfile,
              ),
            ],
            child: const ProfessionalIdentityApp(
              initialRoute: '/u/mohamed-ayad',
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(PublicProfileScreen), findsOneWidget);
        expect(find.text('Mohamed Ayad'), findsOneWidget);
        expect(find.byType(AuthGate), findsNothing);
        expect(find.byTooltip('Dashboard / Sign In'), findsOneWidget);
      },
    );

    testWidgets(
      'ProfessionalIdentityApp opens /u/mohamed-ayad directly for authenticated users without redirecting to dashboard',
      (tester) async {
        tester.view.physicalSize = const Size(1280, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final originalOnError = FlutterError.onError;
        FlutterError.onError = (details) {
          if (details.exceptionAsString().contains('overflowed')) {
            return;
          }
          originalOnError?.call(details);
        };
        addTearDown(() => FlutterError.onError = originalOnError);

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              authStateProvider.overrideWith((ref) => Stream.value(true)),
              publicProfileFamilyProvider('mohamed-ayad').overrideWith(
                (ref) => samplePublicProfile,
              ),
            ],
            child: const ProfessionalIdentityApp(
              initialRoute: '/u/mohamed-ayad',
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(PublicProfileScreen), findsOneWidget);
        expect(find.text('Mohamed Ayad'), findsOneWidget);
        expect(find.byType(AuthGate), findsNothing);
        expect(find.byTooltip('Dashboard / Sign In'), findsOneWidget);
      },
    );
  });

  group('Links and Action Chips Variations', () {
    testWidgets(
      'profile with website only renders website without social or CV',
      (
        tester,
      ) async {
        final profile = PublicProfileData(
          handle: 'web-only',
          fullName: 'Web Only',
          websiteUrl: 'https://webonly.example.com',
          isPublic: true,
          skills: [],
          experiences: [],
          projects: [],
          socialLinks: [],
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              publicProfileFamilyProvider('web-only').overrideWith(
                (ref) => profile,
              ),
            ],
            child: const MaterialApp(
              home: PublicProfileScreen(handle: 'web-only'),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('https://webonly.example.com'), findsOneWidget);
        expect(find.text('View CV'), findsNothing);
        expect(find.byType(ActionChip), findsNothing);
      },
    );

    testWidgets(
      'profile with social links only renders social chips without website or CV',
      (
        tester,
      ) async {
        final profile = PublicProfileData(
          handle: 'social-only',
          fullName: 'Social Only',
          isPublic: true,
          skills: [],
          experiences: [],
          projects: [],
          socialLinks: [
            SocialLink(
              id: 1,
              profileId: 1,
              platform: 'Twitter',
              url: 'https://twitter.com/socialonly',
              sortOrder: 0,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          ],
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              publicProfileFamilyProvider('social-only').overrideWith(
                (ref) => profile,
              ),
            ],
            child: const MaterialApp(
              home: PublicProfileScreen(handle: 'social-only'),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('TWITTER'), findsOneWidget);
        expect(find.text('View CV'), findsNothing);
        expect(find.byIcon(Icons.language_rounded), findsNothing);
      },
    );

    testWidgets('profile with CV only renders View CV button', (tester) async {
      final profile = PublicProfileData(
        handle: 'cv-only',
        fullName: 'CV Only',
        cvUrl: 'https://storage.example.com/resumes/cv.pdf',
        isPublic: true,
        skills: [],
        experiences: [],
        projects: [],
        socialLinks: [],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            publicProfileFamilyProvider('cv-only').overrideWith(
              (ref) => profile,
            ),
          ],
          child: const MaterialApp(
            home: PublicProfileScreen(handle: 'cv-only'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('View CV'), findsOneWidget);
      expect(find.byIcon(Icons.language_rounded), findsNothing);
      expect(find.byType(ActionChip), findsNothing);
    });

    testWidgets('profile with no links has no broken action buttons', (
      tester,
    ) async {
      final profile = PublicProfileData(
        handle: 'no-links',
        fullName: 'No Links',
        isPublic: true,
        skills: [],
        experiences: [],
        projects: [],
        socialLinks: [],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            publicProfileFamilyProvider('no-links').overrideWith(
              (ref) => profile,
            ),
          ],
          child: const MaterialApp(
            home: PublicProfileScreen(handle: 'no-links'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('View CV'), findsNothing);
      expect(find.byIcon(Icons.language_rounded), findsNothing);
      expect(find.byIcon(Icons.email_outlined), findsNothing);
      expect(find.byType(ActionChip), findsNothing);
    });
  });

  group('Project URLs Variations', () {
    testWidgets('handles project URL combinations correctly', (tester) async {
      final profile = PublicProfileData(
        handle: 'project-urls-test',
        fullName: 'Project Tester',
        isPublic: true,
        skills: [],
        experiences: [],
        projects: [
          Project(
            id: 1,
            profileId: 1,
            title: 'Project With Both URLs',
            url: 'https://demo.example.com',
            repositoryUrl: 'https://github.com/example/repo',
            technologies: ['Dart'],
            sortOrder: 0,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          Project(
            id: 2,
            profileId: 1,
            title: 'Project With Only Demo',
            url: 'https://demo-only.example.com',
            technologies: ['Flutter'],
            sortOrder: 1,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          Project(
            id: 3,
            profileId: 1,
            title: 'Project With Only Repo',
            repositoryUrl: 'https://github.com/example/repo-only',
            technologies: ['Serverpod'],
            sortOrder: 2,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          Project(
            id: 4,
            profileId: 1,
            title: 'Project With No URLs',
            technologies: ['PostgreSQL'],
            sortOrder: 3,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ],
        socialLinks: [],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            publicProfileFamilyProvider('project-urls-test').overrideWith(
              (ref) => profile,
            ),
          ],
          child: const MaterialApp(
            home: PublicProfileScreen(handle: 'project-urls-test'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Project With Both URLs'), findsOneWidget);
      expect(find.text('Project With Only Demo'), findsOneWidget);
      expect(find.text('Project With Only Repo'), findsOneWidget);
      expect(find.text('Project With No URLs'), findsOneWidget);

      // 'Live Demo' appears twice (for project 1 and project 2)
      expect(find.text('Live Demo'), findsNWidgets(2));
      // 'Repository' appears twice (for project 1 and project 3)
      expect(find.text('Repository'), findsNWidgets(2));
    });
  });

  group('Error Handling and Retry Behavior', () {
    testWidgets('shows error state when network fails and retries on tap', (
      tester,
    ) async {
      int fetchCount = 0;

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            publicProfileFamilyProvider('error-user').overrideWith((ref) {
              fetchCount++;
              if (fetchCount == 1) {
                return Future.error('Connection timed out');
              }
              return Future.value(samplePublicProfile);
            }),
          ],
          child: const MaterialApp(
            home: PublicProfileScreen(handle: 'error-user'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Error UI elements
      expect(find.byIcon(Icons.wifi_off_rounded), findsOneWidget);
      expect(find.text('Unable to load profile'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
      expect(fetchCount, equals(1));

      // Tap Retry button
      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();

      // After retry, successful profile is rendered
      expect(fetchCount, equals(2));
      expect(find.text('Mohamed Ayad'), findsOneWidget);
      expect(find.text('Unable to load profile'), findsNothing);
    });
  });
}
