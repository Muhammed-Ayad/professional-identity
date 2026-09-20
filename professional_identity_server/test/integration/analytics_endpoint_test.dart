import 'package:professional_identity_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Analytics endpoint', (sessionBuilder, endpoints) {
    const userId1 = '550e8400-e29b-41d4-a716-446655440001';
    const userId2 = '550e8400-e29b-41d4-a716-446655440002';

    late TestSessionBuilder authedSession1;
    late TestSessionBuilder authedSession2;

    late Profile profile1;

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
          handle: 'dev-one',
          fullName: 'Developer One',
          isPublic: true,
        ),
      );

      await Profile.db.insertRow(
        session,
        Profile(
          authUserId: UuidValue.fromString(userId2),
          handle: 'dev-two',
          fullName: 'Developer Two',
          isPublic: false, // Private profile
        ),
      );
    });

    test(
      'when unauthenticated calling getAnalyticsSummary then throws ProfileException',
      () async {
        final now = DateTime.now();
        await expectLater(
          endpoints.analytics.getAnalyticsSummary(
            sessionBuilder,
            now.subtract(const Duration(days: 7)),
            now,
          ),
          throwsA(isA<ProfileException>()),
        );
      },
    );

    test(
      'when recording valid public events then events succeed and aggregate accurately',
      () async {
        // Record public events for dev-one
        final r1 = await endpoints.analytics.recordPublicEvent(
          sessionBuilder,
          'dev-one',
          'profile_view',
          null,
        );
        expect(r1, isTrue);

        final r2 = await endpoints.analytics.recordPublicEvent(
          sessionBuilder,
          'dev-one',
          'profile_view',
          null,
        );
        expect(r2, isTrue);

        final r3 = await endpoints.analytics.recordPublicEvent(
          sessionBuilder,
          'dev-one',
          'social_link_click',
          'github',
        );
        expect(r3, isTrue);

        final r4 = await endpoints.analytics.recordPublicEvent(
          sessionBuilder,
          'dev-one',
          'social_link_click',
          'linkedin',
        );
        expect(r4, isTrue);

        final r5 = await endpoints.analytics.recordPublicEvent(
          sessionBuilder,
          'dev-one',
          'project_click',
          'Serverpod Digital Hub',
        );
        expect(r5, isTrue);

        final r6 = await endpoints.analytics.recordPublicEvent(
          sessionBuilder,
          'dev-one',
          'cv_view',
          null,
        );
        expect(r6, isTrue);

        final r7 = await endpoints.analytics.recordPublicEvent(
          sessionBuilder,
          'dev-one',
          'profile_share',
          null,
        );
        expect(r7, isTrue);

        // Dev-one retrieves analytics summary
        final now = DateTime.now();
        final summary = await endpoints.analytics.getAnalyticsSummary(
          authedSession1,
          now.subtract(const Duration(days: 7)),
          now.add(const Duration(days: 1)),
        );

        expect(summary.totalProfileViews, 2);
        expect(summary.totalSocialLinkClicks, 2);
        expect(summary.totalProjectClicks, 1);
        expect(summary.totalCvViews, 1);
        expect(summary.totalProfileShares, 1);
        expect(summary.totalEvents, 7);

        expect(summary.socialLinkClicksByPlatform.length, 2);
        expect(
          summary.socialLinkClicksByPlatform.map((e) => e.name),
          containsAll(['github', 'linkedin']),
        );
        expect(summary.projectClicksByProject.length, 1);
        expect(
          summary.projectClicksByProject.first.name,
          'Serverpod Digital Hub',
        );
      },
    );

    test(
      'when recording public event for private or non-existent handle then returns false without error',
      () async {
        // Non-existent handle
        final r1 = await endpoints.analytics.recordPublicEvent(
          sessionBuilder,
          'non-existent-handle-xyz',
          'profile_view',
          null,
        );
        expect(r1, isFalse);

        // Private handle (dev-two isPrivate: true)
        final r2 = await endpoints.analytics.recordPublicEvent(
          sessionBuilder,
          'dev-two',
          'profile_view',
          null,
        );
        expect(r2, isFalse);
      },
    );

    test(
      'when recording invalid eventType or target too long then rejected',
      () async {
        final r1 = await endpoints.analytics.recordPublicEvent(
          sessionBuilder,
          'dev-one',
          'malicious_event_injection',
          null,
        );
        expect(r1, isFalse);

        final oversizedTarget = 'A' * 150;
        final r2 = await endpoints.analytics.recordPublicEvent(
          sessionBuilder,
          'dev-one',
          'project_click',
          oversizedTarget,
        );
        expect(r2, isFalse);
      },
    );

    test('User A cannot retrieve User B analytics', () async {
      // Record event for dev-one
      await endpoints.analytics.recordPublicEvent(
        sessionBuilder,
        'dev-one',
        'profile_view',
        null,
      );

      final now = DateTime.now();
      // dev-two queries summary -> should have 0 events for their own profile
      final summary2 = await endpoints.analytics.getAnalyticsSummary(
        authedSession2,
        now.subtract(const Duration(days: 7)),
        now.add(const Duration(days: 1)),
      );

      expect(summary2.totalProfileViews, 0);
      expect(summary2.totalEvents, 0);
    });

    test(
      'when date range invalid (from > to or duration > 365 days) then throws ProfileException',
      () async {
        final now = DateTime.now();

        // from > to
        await expectLater(
          endpoints.analytics.getAnalyticsSummary(
            authedSession1,
            now.add(const Duration(days: 1)),
            now,
          ),
          throwsA(isA<ProfileException>()),
        );

        // > 365 days
        await expectLater(
          endpoints.analytics.getAnalyticsSummary(
            authedSession1,
            now.subtract(const Duration(days: 400)),
            now,
          ),
          throwsA(isA<ProfileException>()),
        );
      },
    );

    test(
      'when profile is deleted then associated analytics events are cascade deleted',
      () async {
        final session = sessionBuilder.build();

        // Record event
        await endpoints.analytics.recordPublicEvent(
          sessionBuilder,
          'dev-one',
          'profile_view',
          null,
        );

        var eventCount = await ProfileAnalyticsEvent.db.count(
          session,
          where: (t) => t.profileId.equals(profile1.id!),
        );
        expect(eventCount, 1);

        // Delete profile1
        await Profile.db.deleteRow(session, profile1);

        eventCount = await ProfileAnalyticsEvent.db.count(
          session,
          where: (t) => t.profileId.equals(profile1.id!),
        );
        expect(eventCount, 0);
      },
    );
  });
}
