import 'package:professional_identity_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given SocialLink endpoint', (sessionBuilder, endpoints) {
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

      await endpoints.profile.saveMyProfile(
        authed1,
        'link-user-1',
        'Link User One',
      );
      await endpoints.profile.saveMyProfile(
        authed2,
        'link-user-2',
        'Link User Two',
      );
    });

    test('when creating valid social link then succeeds', () async {
      final link = await endpoints.socialLink.createSocialLink(
        authed1,
        'github',
        'https://github.com/my-profile',
        label: 'GitHub Profile',
      );

      expect(link.platform, 'github');
      expect(link.url, 'https://github.com/my-profile');
      expect(link.label, 'GitHub Profile');

      final myLinks = await endpoints.socialLink.getMySocialLinks(authed1);
      expect(myLinks, hasLength(1));
    });

    test(
      'when creating link with invalid url scheme then throws ProfileException',
      () async {
        await expectLater(
          endpoints.socialLink.createSocialLink(
            authed1,
            'linkedin',
            'ftp://linkedin.com/in/user',
          ),
          throwsA(isA<ProfileException>()),
        );
      },
    );

    test(
      'when user2 tries to delete user1 link then throws ProfileException',
      () async {
        final link = await endpoints.socialLink.createSocialLink(
          authed1,
          'x',
          'https://x.com/profile',
        );

        await expectLater(
          endpoints.socialLink.deleteSocialLink(authed2, link.id!),
          throwsA(isA<ProfileException>()),
        );

        final deleted = await endpoints.socialLink.deleteSocialLink(
          authed1,
          link.id!,
        );
        expect(deleted, isTrue);
      },
    );
  });
}
