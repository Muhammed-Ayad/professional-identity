import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import 'package:professional_identity_flutter/client.dart';
import 'package:professional_identity_flutter/feature/auth/logic/providers/auth_providers.dart';
import 'package:professional_identity_flutter/feature/cv/logic/providers/cv_providers.dart';
import 'package:professional_identity_flutter/feature/cv/view/screens/cv_screen.dart';
import 'package:professional_identity_flutter/feature/dashboard/view/screens/dashboard_screen.dart';
import 'package:professional_identity_flutter/feature/profile/logic/providers/profile_providers.dart';
import 'package:professional_identity_flutter/feature/projects/logic/providers/project_providers.dart';
import 'package:professional_identity_flutter/feature/projects/view/screens/projects_screen.dart';
import 'package:professional_identity_flutter/feature/projects/view/widgets/edit_project_dialog.dart';
import 'package:professional_identity_flutter/main.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

void main() {
  setUpAll(() {
    client = Client('http://localhost:8080/')
      ..connectivityMonitor = FlutterConnectivityMonitor()
      ..authSessionManager = FlutterAuthSessionManager();
  });

  testWidgets('AuthGate displays AuthScreen when unauthenticated', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // Suppress Ahem font overflow assertion from internal package form in test environment
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
        child: const ProfessionalIdentityApp(),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Professional Identity'), findsWidgets);
    expect(find.byType(SignInWidget), findsOneWidget);
    expect(
      find.text(
        'Your verified single-link professional profile, portfolio, and identity for the developer ecosystem.',
      ),
      findsOneWidget,
    );
  });

  testWidgets(
    'AuthGate displays DashboardScreen onboarding when authenticated with no profile',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authStateProvider.overrideWith((ref) => Stream.value(true)),
            userProfileNotifierProvider.overrideWith(
              () => _MockUserProfileNotifier(null),
            ),
          ],
          child: const ProfessionalIdentityApp(),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(DashboardScreen), findsOneWidget);
      expect(find.text('Professional Identity'), findsOneWidget);
      expect(find.text('Set Up Your Professional Identity'), findsOneWidget);
    },
  );

  testWidgets(
    'AuthGate displays DashboardScreen modules and completion when authenticated with profile',
    (tester) async {
      tester.view.physicalSize = const Size(1280, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final mockProfile = Profile(
        id: 1,
        authUserId: UuidValue.fromString(
          '00000000-0000-0000-0000-000000000001',
        ),
        handle: 'johndoe',
        fullName: 'John Doe',
        headline: 'Software Architect',
        bio: 'Building full-stack digital identity platforms.',
        isPublic: true,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authStateProvider.overrideWith((ref) => Stream.value(true)),
            userProfileNotifierProvider.overrideWith(
              () => _MockUserProfileNotifier(mockProfile),
            ),
            projectsNotifierProvider.overrideWith(
              () => _MockProjectsNotifier([]),
            ),
            cvNotifierProvider.overrideWith(
              () => _MockCvNotifier(null),
            ),
          ],
          child: const ProfessionalIdentityApp(),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(DashboardScreen), findsOneWidget);
      expect(find.text('Professional Identity'), findsOneWidget);
      expect(find.text('Profile Completion'), findsOneWidget);
      expect(find.text('15% Complete'), findsOneWidget); // Headline + Bio met
      expect(find.text('Projects'), findsOneWidget);
      expect(find.text('CV & Resume'), findsOneWidget);
      expect(find.text('Skills'), findsOneWidget);
      expect(find.text('Experience'), findsOneWidget);
      expect(find.text('Social Links'), findsOneWidget);
      expect(find.text('CV: Not uploaded'), findsOneWidget);
    },
  );

  testWidgets(
    'DashboardScreen renders properly on compact mobile width without overflows',
    (tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final mockProfile = Profile(
        id: 1,
        authUserId: UuidValue.fromString(
          '00000000-0000-0000-0000-000000000001',
        ),
        handle: 'mohamed-ayad',
        fullName: 'Mohamed Ayad',
        headline: 'Senior Flutter & Full-Stack Architect',
        bio: 'Building developer-first platforms.',
        availability: 'Available for work',
        location: 'Remote',
        isPublic: true,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authStateProvider.overrideWith((ref) => Stream.value(true)),
            userProfileNotifierProvider.overrideWith(
              () => _MockUserProfileNotifier(mockProfile),
            ),
            projectsNotifierProvider.overrideWith(
              () => _MockProjectsNotifier([]),
            ),
            cvNotifierProvider.overrideWith(
              () => _MockCvNotifier(null),
            ),
          ],
          child: const ProfessionalIdentityApp(),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(DashboardScreen), findsOneWidget);
      expect(find.text('Mohamed Ayad'), findsOneWidget);
      expect(
        find.text('Senior Flutter & Full-Stack Architect'),
        findsOneWidget,
      );
      expect(find.text('View Public'), findsOneWidget);
      expect(find.text('Edit Profile'), findsOneWidget);
    },
  );

  testWidgets('ProjectsScreen displays empty state when no projects exist', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          projectsNotifierProvider.overrideWith(
            () => _MockProjectsNotifier([]),
          ),
        ],
        child: const MaterialApp(home: ProjectsScreen()),
      ),
    );

    await tester.pump();

    expect(find.text('Featured Projects'), findsOneWidget);
    expect(find.text('No projects yet'), findsOneWidget);
    expect(
      find.text('Showcase your work by adding your first project.'),
      findsOneWidget,
    );
    expect(find.text('Add Project'), findsOneWidget);
  });

  testWidgets(
    'ProjectsScreen displays project cards with technologies and tags',
    (
      tester,
    ) async {
      final mockProject = Project(
        id: 10,
        profileId: 1,
        title: 'Serverpod Digital Hub',
        role: 'Backend Creator',
        description: 'Built with Dart and PostgreSQL.',
        technologies: ['Dart', 'Serverpod', 'PostgreSQL'],
        isOngoing: true,
        sortOrder: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            projectsNotifierProvider.overrideWith(
              () => _MockProjectsNotifier([mockProject]),
            ),
          ],
          child: const MaterialApp(home: ProjectsScreen()),
        ),
      );

      await tester.pump();

      expect(find.text('Serverpod Digital Hub'), findsOneWidget);
      expect(find.text('Backend Creator'), findsOneWidget);
      expect(find.text('Ongoing'), findsOneWidget);
      expect(find.text('Built with Dart and PostgreSQL.'), findsOneWidget);
      expect(find.text('Dart'), findsOneWidget);
      expect(find.text('Serverpod'), findsOneWidget);
      expect(find.text('PostgreSQL'), findsOneWidget);
    },
  );

  testWidgets(
    'EditProjectDialog validates required fields and technology chips',
    (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1280, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            projectsNotifierProvider.overrideWith(
              () => _MockProjectsNotifier([]),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(body: EditProjectDialog()),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('Add Featured Project'), findsOneWidget);

      // Tap submit button without filling fields
      final addButton = find.widgetWithText(ElevatedButton, 'Add Project');
      expect(addButton, findsOneWidget);
      await tester.ensureVisible(addButton);
      await tester.tap(addButton);
      await tester.pump();

      expect(find.text('Project title is required'), findsOneWidget);
    },
  );

  testWidgets('CvScreen displays empty state when no CV uploaded', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          cvNotifierProvider.overrideWith(() => _MockCvNotifier(null)),
        ],
        child: const MaterialApp(home: CvScreen()),
      ),
    );

    await tester.pump();

    expect(find.text('CV & Resume Management'), findsOneWidget);
    expect(find.text('No CV uploaded yet.'), findsOneWidget);
    expect(
      find.text('Upload your CV as a PDF (maximum 5 MB).'),
      findsOneWidget,
    );
    expect(find.widgetWithText(ElevatedButton, 'Upload CV'), findsOneWidget);
  });

  testWidgets('CvScreen displays uploaded state when CV is available', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          cvNotifierProvider.overrideWith(
            () => _MockCvNotifier('http://localhost:8082/cv/1/cv.pdf'),
          ),
        ],
        child: const MaterialApp(home: CvScreen()),
      ),
    );

    await tester.pump();

    expect(find.text('CV Available'), findsOneWidget);
    expect(find.text('http://localhost:8082/cv/1/cv.pdf'), findsOneWidget);
    expect(find.text('Replace CV'), findsOneWidget);
    expect(find.text('Open CV Link'), findsOneWidget);
    expect(find.text('Remove'), findsOneWidget);
  });
}

class _MockUserProfileNotifier extends UserProfileNotifier {
  final Profile? _profile;
  _MockUserProfileNotifier([this._profile]);

  @override
  Future<Profile?> build() async {
    return _profile;
  }
}

class _MockProjectsNotifier extends ProjectsNotifier {
  final List<Project> _projects;
  _MockProjectsNotifier([this._projects = const []]);

  @override
  FutureOr<List<Project>> build() async {
    return _projects;
  }
}

class _MockCvNotifier extends CvNotifier {
  final String? _cvUrl;
  _MockCvNotifier([this._cvUrl]);

  @override
  FutureOr<String?> build() async {
    return _cvUrl;
  }
}
