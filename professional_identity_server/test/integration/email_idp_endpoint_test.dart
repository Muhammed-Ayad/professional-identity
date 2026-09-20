import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given EmailIdp endpoint', (sessionBuilder, endpoints) {
    const userId1 = '550e8400-e29b-41d4-a716-446655440099';

    setUp(() async {
      final session = sessionBuilder.build();

      // Seed AuthUser
      await AuthUser.db.insert(session, [
        AuthUser(
          id: UuidValue.fromString(userId1),
          createdAt: DateTime.now(),
          scopeNames: {},
          blocked: false,
        ),
      ]);

      // Seed EmailAccount
      await EmailAccount.db.insertRow(
        session,
        EmailAccount(
          authUserId: UuidValue.fromString(userId1),
          email: 'existing@example.com',
          passwordHash: 'dummy-hash',
        ),
      );
    });

    test(
      'when registering with an already registered email then throws EmailAccountRequestException',
      () async {
        await expectLater(
          endpoints.emailIdp.startRegistration(
            sessionBuilder,
            email: 'existing@example.com',
          ),
          throwsA(isA<EmailAccountRequestException>()),
        );

        // Case insensitivity check
        await expectLater(
          endpoints.emailIdp.startRegistration(
            sessionBuilder,
            email: 'EXISTING@example.com',
          ),
          throwsA(isA<EmailAccountRequestException>()),
        );
      },
    );
  });
}
