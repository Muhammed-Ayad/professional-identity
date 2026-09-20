import 'package:professional_identity_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Skill endpoint', (sessionBuilder, endpoints) {
    const user1 = '550e8400-e29b-41d4-a716-446655440003';
    const user2 = '550e8400-e29b-41d4-a716-446655440004';

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
        'skill-user-1',
        'User One',
      );
      await endpoints.profile.saveMyProfile(
        authed2,
        'skill-user-2',
        'User Two',
      );
    });

    test('when creating skill with valid data then it is saved', () async {
      final skill = await endpoints.skill.createSkill(
        authed1,
        'Flutter',
        category: 'Mobile',
        yearsOfExperience: 5,
      );

      expect(skill.name, 'Flutter');
      expect(skill.category, 'Mobile');
      expect(skill.yearsOfExperience, 5);

      final mySkills = await endpoints.skill.getMySkills(authed1);
      expect(mySkills, hasLength(1));
      expect(mySkills.first.name, 'Flutter');
    });

    test(
      'when creating skill with empty name then throws ProfileException',
      () async {
        await expectLater(
          endpoints.skill.createSkill(authed1, '   '),
          throwsA(isA<ProfileException>()),
        );
      },
    );

    test(
      'when creating skill with negative experience then throws ProfileException',
      () async {
        await expectLater(
          endpoints.skill.createSkill(authed1, 'Dart', yearsOfExperience: -2),
          throwsA(isA<ProfileException>()),
        );
      },
    );

    test('when updating and deleting skill then changes persist', () async {
      final created = await endpoints.skill.createSkill(
        authed1,
        'Serverpod',
        category: 'Backend',
        yearsOfExperience: 2,
      );

      final updated = await endpoints.skill.updateSkill(
        authed1,
        created.id!,
        'Serverpod 4',
        category: 'Cloud Backend',
        yearsOfExperience: 3,
      );

      expect(updated.name, 'Serverpod 4');
      expect(updated.yearsOfExperience, 3);

      // User2 cannot delete User1's skill
      await expectLater(
        endpoints.skill.deleteSkill(authed2, created.id!),
        throwsA(isA<ProfileException>()),
      );

      final deleted = await endpoints.skill.deleteSkill(authed1, created.id!);
      expect(deleted, isTrue);

      final remaining = await endpoints.skill.getMySkills(authed1);
      expect(remaining, isEmpty);
    });

    test('when reordering skills then sortOrder is updated', () async {
      final s1 = await endpoints.skill.createSkill(authed1, 'Skill A');
      final s2 = await endpoints.skill.createSkill(authed1, 'Skill B');
      final s3 = await endpoints.skill.createSkill(authed1, 'Skill C');

      await endpoints.skill.reorderSkills(authed1, [s3.id!, s1.id!, s2.id!]);

      final reordered = await endpoints.skill.getMySkills(authed1);
      expect(reordered.map((s) => s.name).toList(), [
        'Skill C',
        'Skill A',
        'Skill B',
      ]);
    });
  });
}
