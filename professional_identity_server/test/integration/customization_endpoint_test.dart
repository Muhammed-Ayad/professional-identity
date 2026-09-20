import 'package:professional_identity_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Customization endpoint', (sessionBuilder, endpoints) {
    const userId1 = '660e8400-e29b-41d4-a716-446655440001';
    const userId2 = '660e8400-e29b-41d4-a716-446655440002';

    late TestSessionBuilder authedSession1;
    late TestSessionBuilder authedSession2;

    late Profile profile1;
    late Profile profile2;

    setUp(() async {
      final session = sessionBuilder.build();

      // Seed AuthUsers
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

      // Seed Profiles
      profile1 = await Profile.db.insertRow(
        session,
        Profile(
          authUserId: UuidValue.fromString(userId1),
          handle: 'custom-dev-one',
          fullName: 'Custom Developer One',
          isPublic: true,
        ),
      );

      profile2 = await Profile.db.insertRow(
        session,
        Profile(
          authUserId: UuidValue.fromString(userId2),
          handle: 'custom-dev-two',
          fullName: 'Custom Developer Two',
          isPublic: false, // Private profile
        ),
      );
      expect(profile2.id, isNotNull);
    });

    group('Authentication and Authorization', () {
      test(
        'when unauthenticated user calls updateCustomization then throws ProfileException',
        () async {
          await expectLater(
            endpoints.customization.updateCustomization(
              sessionBuilder,
              'minimal',
              '#2563EB',
              'solid',
              'outlined',
              'medium',
              'modern',
            ),
            throwsA(isA<ProfileException>()),
          );
        },
      );

      test(
        'when authenticated user calls updateCustomization then succeeds for their own profile',
        () async {
          final result = await endpoints.customization.updateCustomization(
            authedSession1,
            'modern',
            '#2563EB',
            'subtle_gradient',
            'elevated',
            'large',
            'modern',
          );

          expect(result.id, isNotNull);
          expect(result.profileId, equals(profile1.id));
          expect(result.themePreset, equals('modern'));
          expect(result.primaryColor, equals('#2563EB'));
          expect(result.backgroundStyle, equals('subtle_gradient'));
          expect(result.cardStyle, equals('elevated'));
          expect(result.borderRadius, equals('large'));
          expect(result.typographyStyle, equals('modern'));
        },
      );

      test(
        'ownership isolation: user1 customization is distinct from user2',
        () async {
          await endpoints.customization.updateCustomization(
            authedSession1,
            'modern',
            '#2563EB',
            'solid',
            'outlined',
            'medium',
            'modern',
          );

          await endpoints.customization.updateCustomization(
            authedSession2,
            'dark',
            '#0D9488',
            'subtle_gradient',
            'elevated',
            'small',
            'compact',
          );

          final c1 = await endpoints.customization.getCustomization(
            authedSession1,
          );
          final c2 = await endpoints.customization.getCustomization(
            authedSession2,
          );

          expect(c1?.themePreset, equals('modern'));
          expect(c1?.primaryColor, equals('#2563EB'));
          expect(c2?.themePreset, equals('dark'));
          expect(c2?.primaryColor, equals('#0D9488'));
          expect(c1?.profileId, isNot(equals(c2?.profileId)));
        },
      );
    });

    group('Validation', () {
      test('rejects invalid themePreset', () async {
        await expectLater(
          endpoints.customization.updateCustomization(
            authedSession1,
            'neon_cyberpunk',
            '#2563EB',
            'solid',
            'outlined',
            'medium',
            'modern',
          ),
          throwsA(isA<ProfileException>()),
        );
      });

      test('rejects invalid backgroundStyle', () async {
        await expectLater(
          endpoints.customization.updateCustomization(
            authedSession1,
            'minimal',
            '#2563EB',
            'animated_particles',
            'outlined',
            'medium',
            'modern',
          ),
          throwsA(isA<ProfileException>()),
        );
      });

      test('rejects invalid cardStyle', () async {
        await expectLater(
          endpoints.customization.updateCustomization(
            authedSession1,
            'minimal',
            '#2563EB',
            'solid',
            'glassmorphism_3d',
            'medium',
            'modern',
          ),
          throwsA(isA<ProfileException>()),
        );
      });

      test('rejects invalid borderRadius', () async {
        await expectLater(
          endpoints.customization.updateCustomization(
            authedSession1,
            'minimal',
            '#2563EB',
            'solid',
            'outlined',
            'extra_giant',
            'modern',
          ),
          throwsA(isA<ProfileException>()),
        );
      });

      test('rejects invalid typographyStyle', () async {
        await expectLater(
          endpoints.customization.updateCustomization(
            authedSession1,
            'minimal',
            '#2563EB',
            'solid',
            'outlined',
            'medium',
            'comic_sans',
          ),
          throwsA(isA<ProfileException>()),
        );
      });

      test(
        'rejects invalid primaryColor format and accepts valid hex colors',
        () async {
          // Invalid colors
          await expectLater(
            endpoints.customization.updateCustomization(
              authedSession1,
              'minimal',
              'rgb(255,0,0)',
              'solid',
              'outlined',
              'medium',
              'modern',
            ),
            throwsA(isA<ProfileException>()),
          );

          await expectLater(
            endpoints.customization.updateCustomization(
              authedSession1,
              'minimal',
              'blue',
              'solid',
              'outlined',
              'medium',
              'modern',
            ),
            throwsA(isA<ProfileException>()),
          );

          // Valid hex without # is automatically prefixed and normalized
          final res = await endpoints.customization.updateCustomization(
            authedSession1,
            'minimal',
            '3b82f6',
            'solid',
            'outlined',
            'medium',
            'modern',
          );
          expect(res.primaryColor, equals('#3B82F6'));

          // Null color is allowed (theme default)
          final resNull = await endpoints.customization.updateCustomization(
            authedSession1,
            'minimal',
            null,
            'solid',
            'outlined',
            'medium',
            'modern',
          );
          expect(resNull.primaryColor, isNull);
        },
      );
    });

    group('Upsert Behavior', () {
      test(
        'first save creates, second save updates without duplicate records',
        () async {
          final session = sessionBuilder.build();

          // Count before
          final countBefore = await ProfileCustomization.db.count(
            session,
            where: (t) => t.profileId.equals(profile1.id!),
          );
          expect(countBefore, equals(0));

          // First save
          final saved1 = await endpoints.customization.updateCustomization(
            authedSession1,
            'minimal',
            '#112233',
            'solid',
            'outlined',
            'medium',
            'modern',
          );

          final countMid = await ProfileCustomization.db.count(
            session,
            where: (t) => t.profileId.equals(profile1.id!),
          );
          expect(countMid, equals(1));

          // Second save (update)
          final saved2 = await endpoints.customization.updateCustomization(
            authedSession1,
            'professional',
            '#4F46E5',
            'subtle_gradient',
            'flat',
            'large',
            'classic',
          );

          expect(saved2.id, equals(saved1.id));
          expect(saved2.themePreset, equals('professional'));
          expect(saved2.primaryColor, equals('#4F46E5'));
          expect(saved2.cardStyle, equals('flat'));

          final countAfter = await ProfileCustomization.db.count(
            session,
            where: (t) => t.profileId.equals(profile1.id!),
          );
          expect(countAfter, equals(1));
        },
      );
    });

    group('Public Profile Access and Privacy', () {
      test('public profile can retrieve customization', () async {
        await endpoints.customization.updateCustomization(
          authedSession1,
          'modern',
          '#2563EB',
          'subtle_gradient',
          'elevated',
          'medium',
          'modern',
        );

        final pubCustom = await endpoints.customization.getPublicCustomization(
          sessionBuilder,
          'custom-dev-one',
        );
        expect(pubCustom, isNotNull);
        expect(pubCustom?.themePreset, equals('modern'));
        expect(pubCustom?.primaryColor, equals('#2563EB'));

        // Also check bundled getPublicProfile
        final pubProfile = await endpoints.publicProfile.getPublicProfile(
          sessionBuilder,
          'custom-dev-one',
        );
        expect(pubProfile, isNotNull);
        expect(pubProfile?.customization, isNotNull);
        expect(pubProfile?.customization?.themePreset, equals('modern'));
      });

      test(
        'private profile does not expose customization to public endpoint',
        () async {
          await endpoints.customization.updateCustomization(
            authedSession2,
            'dark',
            '#0D9488',
            'solid',
            'outlined',
            'small',
            'compact',
          );

          final pubCustom = await endpoints.customization
              .getPublicCustomization(
                sessionBuilder,
                'custom-dev-two',
              );
          expect(pubCustom, isNull);

          final pubProfile = await endpoints.publicProfile.getPublicProfile(
            sessionBuilder,
            'custom-dev-two',
          );
          expect(pubProfile, isNull);
        },
      );
    });

    group('Cascade Deletion', () {
      test('deleting profile cascades to delete its customization', () async {
        final session = sessionBuilder.build();

        await endpoints.customization.updateCustomization(
          authedSession1,
          'minimal',
          '#123456',
          'solid',
          'outlined',
          'medium',
          'modern',
        );

        // Ensure row exists
        var found = await ProfileCustomization.db.findFirstRow(
          session,
          where: (t) => t.profileId.equals(profile1.id!),
        );
        expect(found, isNotNull);

        // Delete profile
        await Profile.db.deleteRow(session, profile1);

        // Verify customization is deleted
        found = await ProfileCustomization.db.findFirstRow(
          session,
          where: (t) => t.profileId.equals(profile1.id!),
        );
        expect(found, isNull);
      });
    });
  });
}
