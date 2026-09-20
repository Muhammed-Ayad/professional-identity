import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given PublicProfile endpoint', (sessionBuilder, endpoints) {
    const user1 = '550e8400-e29b-41d4-a716-446655440011';
    const user2 = '550e8400-e29b-41d4-a716-446655440012';

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

      // Create a public profile for User 1
      await endpoints.profile.saveMyProfile(
        authed1,
        'mohamed-ayad',
        'Mohamed Ayad',
        headline: 'Lead Software Architect',
        bio: 'Building world-class developer tools and platforms.',
        location: 'Cairo, Egypt',
        currentRole: 'Staff Engineer',
        yearsOfExperience: 8,
        availability: 'Open for consulting',
        websiteUrl: 'https://ayad.dev',
        contactEmail: 'contact@ayad.dev',
        isPublic: true,
      );

      // Add skills for User 1
      await endpoints.skill.createSkill(
        authed1,
        'Dart',
        category: 'Language',
        yearsOfExperience: 6,
      );
      await endpoints.skill.createSkill(
        authed1,
        'Flutter',
        category: 'Mobile',
        yearsOfExperience: 6,
      );

      // Add experience for User 1
      await endpoints.experience.createExperience(
        authed1,
        'Serverpod Tech',
        'Principal Engineer',
        DateTime.utc(2023, 1, 1),
        isCurrent: true,
        description: 'Architecting cloud backend systems.',
      );

      // Add project for User 1
      await endpoints.project.createProject(
        authed1,
        title: 'Professional Identity Platform',
        description: 'Unified single-link portfolio platform.',
        role: 'Creator & Architect',
        url: 'https://professional-identity.dev',
        repositoryUrl: 'https://github.com/ayad/professional-identity',
        technologies: ['Flutter', 'Serverpod', 'PostgreSQL'],
        startDate: DateTime.utc(2025, 1, 1),
        isOngoing: true,
      );

      // Add social link for User 1
      await endpoints.socialLink.createSocialLink(
        authed1,
        'github',
        'https://github.com/mohamed-ayad',
        label: 'GitHub Profile',
      );

      // Upload CV for User 1
      final mockPdf = Uint8List(100);
      mockPdf[0] = 0x25;
      mockPdf[1] = 0x50;
      mockPdf[2] = 0x44;
      mockPdf[3] = 0x46;
      mockPdf[4] = 0x2D;
      await endpoints.cv.uploadCv(
        authed1,
        'resume.pdf',
        ByteData.sublistView(mockPdf),
      );

      // Create a PRIVATE profile for User 2
      await endpoints.profile.saveMyProfile(
        authed2,
        'private-user',
        'Private User',
        headline: 'Stealth Mode',
        isPublic: false,
      );
    });

    test(
      'when fetching public profile with valid handle then returns aggregated data without authentication',
      () async {
        // sessionBuilder here is completely unauthenticated
        final publicData = await endpoints.publicProfile.getPublicProfile(
          sessionBuilder,
          'mohamed-ayad',
        );

        expect(publicData, isNotNull);
        expect(publicData!.handle, equals('mohamed-ayad'));
        expect(publicData.fullName, equals('Mohamed Ayad'));
        expect(publicData.headline, equals('Lead Software Architect'));
        expect(publicData.bio, contains('developer tools'));
        expect(publicData.location, equals('Cairo, Egypt'));
        expect(publicData.currentRole, equals('Staff Engineer'));
        expect(publicData.yearsOfExperience, equals(8));
        expect(publicData.availability, equals('Open for consulting'));
        expect(publicData.websiteUrl, equals('https://ayad.dev'));
        expect(publicData.contactEmail, equals('contact@ayad.dev'));
        expect(publicData.isPublic, isTrue);

        // Skills returned
        expect(publicData.skills.length, equals(2));
        expect(
          publicData.skills.map((s) => s.name),
          containsAll(['Dart', 'Flutter']),
        );

        // Experience returned
        expect(publicData.experiences.length, equals(1));
        expect(publicData.experiences.first.company, equals('Serverpod Tech'));
        expect(
          publicData.experiences.first.jobTitle,
          equals('Principal Engineer'),
        );

        // Projects returned
        expect(publicData.projects.length, equals(1));
        expect(
          publicData.projects.first.title,
          equals('Professional Identity Platform'),
        );
        expect(publicData.projects.first.technologies, contains('Flutter'));

        // Social Links returned
        expect(publicData.socialLinks.length, equals(1));
        expect(publicData.socialLinks.first.platform, equals('github'));

        // CV URL returned
        expect(publicData.cvUrl, isNotNull);
        expect(publicData.cvUrl, contains('cv.pdf'));
      },
    );

    test('when handle does not exist then returns null', () async {
      final notFound = await endpoints.publicProfile.getPublicProfile(
        sessionBuilder,
        'non-existent-handle',
      );
      expect(notFound, isNull);
    });

    test(
      'when profile is private then returns null without leaking existence',
      () async {
        final privateProfile = await endpoints.publicProfile.getPublicProfile(
          sessionBuilder,
          'private-user',
        );
        expect(privateProfile, isNull);
      },
    );

    test(
      'when handle contains uppercase characters then it is normalized and retrieved',
      () async {
        final publicData = await endpoints.publicProfile.getPublicProfile(
          sessionBuilder,
          'Mohamed-Ayad',
        );
        expect(publicData, isNotNull);
        expect(publicData!.handle, equals('mohamed-ayad'));
      },
    );

    test(
      'when handle contains leading and trailing whitespace then it is trimmed and retrieved',
      () async {
        final publicData = await endpoints.publicProfile.getPublicProfile(
          sessionBuilder,
          '   mohamed-ayad   \n',
        );
        expect(publicData, isNotNull);
        expect(publicData!.handle, equals('mohamed-ayad'));
      },
    );

    test('when handle is blank or whitespace then returns null', () async {
      final blankResult = await endpoints.publicProfile.getPublicProfile(
        sessionBuilder,
        '    ',
      );
      expect(blankResult, isNull);
    });

    test(
      'when public profile has no CV then cvUrl is null and no error occurs',
      () async {
        const user3 = '550e8400-e29b-41d4-a716-446655440013';
        final session = sessionBuilder.build();
        await AuthUser.db.insert(session, [
          AuthUser(
            id: UuidValue.fromString(user3),
            createdAt: DateTime.now(),
            scopeNames: {},
            blocked: false,
          ),
        ]);
        final authed3 = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(user3, {}),
        );
        await endpoints.profile.saveMyProfile(
          authed3,
          'no-cv-user',
          'No CV User',
          headline: 'Developer without uploaded CV',
          isPublic: true,
        );

        final publicData = await endpoints.publicProfile.getPublicProfile(
          sessionBuilder,
          'no-cv-user',
        );

        expect(publicData, isNotNull);
        expect(publicData!.handle, equals('no-cv-user'));
        expect(publicData.cvUrl, isNull);
        expect(publicData.skills, isEmpty);
        expect(publicData.experiences, isEmpty);
        expect(publicData.projects, isEmpty);
        expect(publicData.socialLinks, isEmpty);
      },
    );
  });
}
