import 'package:professional_identity_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Project endpoint', (sessionBuilder, endpoints) {
    const user1 = '550e8400-e29b-41d4-a716-446655440007';
    const user2 = '550e8400-e29b-41d4-a716-446655440008';

    late TestSessionBuilder authed1;
    late TestSessionBuilder authed2;

    setUp(() async {
      final session = sessionBuilder.build();

      await AuthUser.db.insert(session, [
        AuthUser(
          id: UuidValue.fromString(user1),
          createdAt: DateTime.now(),
          scopeNames: {},
          blocked: false,
        ),
        AuthUser(
          id: UuidValue.fromString(user2),
          createdAt: DateTime.now(),
          scopeNames: {},
          blocked: false,
        ),
      ]);

      authed1 = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(user1, {}),
      );
      authed2 = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(user2, {}),
      );

      // Create profiles for both users
      await endpoints.profile.saveMyProfile(
        authed1,
        'proj-user-1',
        'User One',
      );
      await endpoints.profile.saveMyProfile(
        authed2,
        'proj-user-2',
        'User Two',
      );
    });

    test(
      'when unauthenticated calling getMyProjects then throws ProfileException',
      () async {
        expect(
          () => endpoints.project.getMyProjects(sessionBuilder),
          throwsA(isA<ProfileException>()),
        );
      },
    );

    test('when creating project with valid data then it is saved', () async {
      final project = await endpoints.project.createProject(
        authed1,
        title: 'Portfolio App',
        description: 'A full-stack portfolio platform.',
        role: 'Lead Architect',
        url: 'https://example.com/app',
        repositoryUrl: 'https://github.com/example/portfolio',
        technologies: ['Flutter', 'Serverpod', 'PostgreSQL'],
        startDate: DateTime.utc(2025, 1, 1),
        isOngoing: true,
      );

      expect(project.id, isNotNull);
      expect(project.title, equals('Portfolio App'));
      expect(project.role, equals('Lead Architect'));
      expect(
        project.technologies,
        containsAll(['Flutter', 'Serverpod', 'PostgreSQL']),
      );
      expect(project.isOngoing, isTrue);
      expect(project.endDate, isNull);

      final myProjects = await endpoints.project.getMyProjects(authed1);
      expect(myProjects.length, equals(1));
      expect(myProjects.first.title, equals('Portfolio App'));
    });

    test(
      'when creating project with empty title then throws ProfileException',
      () async {
        expect(
          () => endpoints.project.createProject(
            authed1,
            title: '   ',
            technologies: ['Dart'],
            isOngoing: false,
          ),
          throwsA(isA<ProfileException>()),
        );
      },
    );

    test(
      'when creating project with invalid URL then throws ProfileException',
      () async {
        expect(
          () => endpoints.project.createProject(
            authed1,
            title: 'Test Project',
            url: 'not-a-valid-url',
            technologies: ['Dart'],
            isOngoing: false,
          ),
          throwsA(isA<ProfileException>()),
        );
      },
    );

    test(
      'when ongoing project has end date then throws ProfileException',
      () async {
        expect(
          () => endpoints.project.createProject(
            authed1,
            title: 'Ongoing Project',
            startDate: DateTime.utc(2025, 1, 1),
            endDate: DateTime.utc(2025, 5, 1),
            technologies: ['Dart'],
            isOngoing: true,
          ),
          throwsA(isA<ProfileException>()),
        );
      },
    );

    test(
      'when end date is before start date then throws ProfileException',
      () async {
        expect(
          () => endpoints.project.createProject(
            authed1,
            title: 'Invalid Dates',
            startDate: DateTime.utc(2025, 5, 1),
            endDate: DateTime.utc(2025, 1, 1),
            technologies: ['Dart'],
            isOngoing: false,
          ),
          throwsA(isA<ProfileException>()),
        );
      },
    );

    test(
      'when technologies contain empty string then throws ProfileException',
      () async {
        expect(
          () => endpoints.project.createProject(
            authed1,
            title: 'Empty Tech',
            technologies: ['Flutter', '   ', 'PostgreSQL'],
            isOngoing: false,
          ),
          throwsA(isA<ProfileException>()),
        );
      },
    );

    test(
      'when user2 tries to update user1 project then throws ProfileException',
      () async {
        final project = await endpoints.project.createProject(
          authed1,
          title: 'User 1 Project',
          technologies: ['Flutter'],
          isOngoing: false,
        );

        expect(
          () => endpoints.project.updateProject(
            authed2,
            projectId: project.id!,
            title: 'Hacked Project',
            technologies: ['Python'],
            isOngoing: false,
          ),
          throwsA(isA<ProfileException>()),
        );
      },
    );

    test(
      'when user2 tries to delete user1 project then throws ProfileException',
      () async {
        final project = await endpoints.project.createProject(
          authed1,
          title: 'User 1 Project',
          technologies: ['Flutter'],
          isOngoing: false,
        );

        expect(
          () => endpoints.project.deleteProject(authed2, project.id!),
          throwsA(isA<ProfileException>()),
        );
      },
    );

    test('when updating and deleting own project then persists', () async {
      final created = await endpoints.project.createProject(
        authed1,
        title: 'Original Title',
        technologies: ['Flutter'],
        isOngoing: false,
      );

      final updated = await endpoints.project.updateProject(
        authed1,
        projectId: created.id!,
        title: 'Updated Title',
        role: 'Senior Tech Lead',
        technologies: ['Flutter', 'Serverpod'],
        isOngoing: false,
      );

      expect(updated.title, equals('Updated Title'));
      expect(updated.role, equals('Senior Tech Lead'));
      expect(updated.technologies, containsAll(['Flutter', 'Serverpod']));

      await endpoints.project.deleteProject(authed1, created.id!);
      final listAfterDelete = await endpoints.project.getMyProjects(authed1);
      expect(listAfterDelete, isEmpty);
    });

    test(
      'when reordering projects then sortOrder is updated and foreign IDs are rejected',
      () async {
        final p1 = await endpoints.project.createProject(
          authed1,
          title: 'Project 1',
          technologies: ['Dart'],
          isOngoing: false,
        );
        final p2 = await endpoints.project.createProject(
          authed1,
          title: 'Project 2',
          technologies: ['Flutter'],
          isOngoing: false,
        );

        // Reorder p2 before p1
        await endpoints.project.reorderProjects(authed1, [p2.id!, p1.id!]);

        final reordered = await endpoints.project.getMyProjects(authed1);
        expect(reordered.first.id, equals(p2.id));
        expect(reordered.last.id, equals(p1.id));
        expect(reordered.first.sortOrder, equals(0));
        expect(reordered.last.sortOrder, equals(1));

        // Attempt to include non-owned project ID from user2
        final pUser2 = await endpoints.project.createProject(
          authed2,
          title: 'User 2 Project',
          technologies: ['Go'],
          isOngoing: false,
        );

        expect(
          () =>
              endpoints.project.reorderProjects(authed1, [p2.id!, pUser2.id!]),
          throwsA(isA<ProfileException>()),
        );
      },
    );
  });
}
