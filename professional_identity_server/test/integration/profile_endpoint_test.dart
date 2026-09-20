import 'package:professional_identity_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Profile endpoint', (sessionBuilder, endpoints) {
    const userId1 = '550e8400-e29b-41d4-a716-446655440001';
    const userId2 = '550e8400-e29b-41d4-a716-446655440002';

    late TestSessionBuilder authedSession1;
    late TestSessionBuilder authedSession2;

    setUp(() async {
      final session = sessionBuilder.build();

      // Seed AuthUsers to satisfy foreign key constraint
      await AuthUser.db.insert(session, [
        AuthUser(
          id: UuidValue.fromString(userId1),
          createdAt: DateTime.now(),
          scopeNames: {},
          blocked: false,
        ),
        AuthUser(
          id: UuidValue.fromString(userId2),
          createdAt: DateTime.now(),
          scopeNames: {},
          blocked: false,
        ),
      ]);

      authedSession1 = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          userId1,
          {},
        ),
      );
      authedSession2 = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          userId2,
          {},
        ),
      );
    });

    test(
      'when unauthenticated calling getMyProfile then throws ProfileException',
      () async {
        await expectLater(
          endpoints.profile.getMyProfile(sessionBuilder),
          throwsA(isA<ProfileException>()),
        );
      },
    );

    test(
      'when newly authenticated user checks profile then returns null',
      () async {
        final profile = await endpoints.profile.getMyProfile(authedSession1);
        expect(profile, isNull);
      },
    );

    test('when checking available handle then returns true', () async {
      final isAvailable = await endpoints.profile.isHandleAvailable(
        sessionBuilder,
        'john-doe',
      );
      expect(isAvailable, isTrue);
    });

    test(
      'when creating a new profile then getMyProfile returns the profile',
      () async {
        final created = await endpoints.profile.saveMyProfile(
          authedSession1,
          'john-doe',
          'John Doe',
          headline: 'Senior Software Engineer',
          bio: 'Building awesome apps with Serverpod and Flutter',
          location: 'San Francisco, CA',
          currentRole: 'Lead Engineer',
          yearsOfExperience: 8,
          availability: 'Available for hire',
          contactEmail: 'john@example.com',
          websiteUrl: 'https://johndoe.dev',
        );

        expect(created.handle, 'john-doe');
        expect(created.fullName, 'John Doe');
        expect(created.headline, 'Senior Software Engineer');
        expect(created.yearsOfExperience, 8);

        final fetched = await endpoints.profile.getMyProfile(authedSession1);
        expect(fetched, isNotNull);
        expect(fetched?.fullName, 'John Doe');
        expect(fetched?.handle, 'john-doe');
      },
    );

    test('when handle is taken then another user cannot claim it', () async {
      await endpoints.profile.saveMyProfile(
        authedSession1,
        'unique-handle',
        'User One',
      );

      // Other user checking handle availability
      final isAvailable = await endpoints.profile.isHandleAvailable(
        authedSession2,
        'unique-handle',
      );
      expect(isAvailable, isFalse);

      // Same user checking their own handle
      final sameUserAvailable = await endpoints.profile.isHandleAvailable(
        authedSession1,
        'unique-handle',
      );
      expect(sameUserAvailable, isTrue);

      // Other user attempting to save with that handle
      await expectLater(
        endpoints.profile.saveMyProfile(
          authedSession2,
          'unique-handle',
          'User Two',
        ),
        throwsA(isA<ProfileException>()),
      );
    });

    test(
      'when public profile exists then getPublicProfile returns it unauthenticated',
      () async {
        await endpoints.profile.saveMyProfile(
          authedSession1,
          'public-coder',
          'Public Coder',
          headline: 'Open Source Advocate',
        );

        final publicProfile = await endpoints.profile.getPublicProfile(
          sessionBuilder,
          'public-coder',
        );
        expect(publicProfile, isNotNull);
        expect(publicProfile?.fullName, 'Public Coder');
        expect(publicProfile?.headline, 'Open Source Advocate');
      },
    );
  });
}
