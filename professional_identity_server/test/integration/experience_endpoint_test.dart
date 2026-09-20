import 'package:professional_identity_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Experience endpoint', (sessionBuilder, endpoints) {
    const user1 = '550e8400-e29b-41d4-a716-446655440005';
    const user2 = '550e8400-e29b-41d4-a716-446655440006';

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

      await endpoints.profile.saveMyProfile(
        authed1,
        'exp-user-1',
        'Exp User One',
      );
      await endpoints.profile.saveMyProfile(
        authed2,
        'exp-user-2',
        'Exp User Two',
      );
    });

    test(
      'when creating current experience without end date then succeeds',
      () async {
        final start = DateTime.utc(2022, 1, 1);
        final exp = await endpoints.experience.createExperience(
          authed1,
          'Tech Corp',
          'Staff Engineer',
          start,
          isCurrent: true,
          description: 'Leading architecture',
        );

        expect(exp.company, 'Tech Corp');
        expect(exp.jobTitle, 'Staff Engineer');
        expect(exp.isCurrent, isTrue);
        expect(exp.endDate, isNull);

        final myExp = await endpoints.experience.getMyExperience(authed1);
        expect(myExp, hasLength(1));
      },
    );

    test(
      'when current experience has end date then throws ProfileException',
      () async {
        await expectLater(
          endpoints.experience.createExperience(
            authed1,
            'Tech Corp',
            'Staff Engineer',
            DateTime.utc(2022, 1, 1),
            endDate: DateTime.utc(2023, 1, 1),
            isCurrent: true,
          ),
          throwsA(isA<ProfileException>()),
        );
      },
    );

    test(
      'when end date is before start date then throws ProfileException',
      () async {
        await expectLater(
          endpoints.experience.createExperience(
            authed1,
            'Tech Corp',
            'Staff Engineer',
            DateTime.utc(2023, 1, 1),
            endDate: DateTime.utc(2022, 1, 1),
            isCurrent: false,
          ),
          throwsA(isA<ProfileException>()),
        );
      },
    );

    test(
      'when user2 tries to mutate user1 experience then throws ProfileException',
      () async {
        final exp = await endpoints.experience.createExperience(
          authed1,
          'Original Corp',
          'Developer',
          DateTime.utc(2020, 1, 1),
          isCurrent: true,
        );

        await expectLater(
          endpoints.experience.updateExperience(
            authed2,
            exp.id!,
            'Hacked Corp',
            'Hacker',
            DateTime.utc(2020, 1, 1),
            isCurrent: true,
          ),
          throwsA(isA<ProfileException>()),
        );

        await expectLater(
          endpoints.experience.deleteExperience(authed2, exp.id!),
          throwsA(isA<ProfileException>()),
        );
      },
    );
  });
}
