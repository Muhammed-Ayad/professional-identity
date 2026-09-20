import 'package:professional_identity_server/src/generated/protocol.dart';
import 'package:professional_identity_server/src/web/routes/public_profile_seo_route.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Phase 8 Discovery, Sharing & SEO Suite', (
    sessionBuilder,
    endpoints,
  ) {
    const userId1 = '660e8400-e29b-41d4-a716-446655440001';
    const userId2 = '660e8400-e29b-41d4-a716-446655440002';

    late TestSessionBuilder authedSession1;

    late Profile publicProfile;

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

      // Seed Public Profile
      publicProfile = await Profile.db.insertRow(
        session,
        Profile(
          authUserId: UuidValue.fromString(userId1),
          handle: 'sarah-connor',
          fullName: 'Sarah Connor',
          headline: 'Lead Security Engineer & Architect',
          bio: 'Defending modern distributed systems.',
          avatarUrl: 'https://cdn.example.com/avatars/sarah.png',
          isPublic: true,
        ),
      );

      // Seed Private Profile
      await Profile.db.insertRow(
        session,
        Profile(
          authUserId: UuidValue.fromString(userId2),
          handle: 'john-reese',
          fullName: 'John Reese',
          headline: 'Stealth Consultant',
          isPublic: false,
        ),
      );
    });

    group('Phase 8 Sharing & Discovery Analytics Tracking', () {
      test(
        'records profile_link_copy, profile_qr_view, profile_qr_download events',
        () async {
          // Link copy
          final copyResult = await endpoints.analytics.recordPublicEvent(
            sessionBuilder,
            'sarah-connor',
            'profile_link_copy',
            null,
          );
          expect(copyResult, isTrue);

          // QR view (via profile_qr_view)
          final qrViewResult = await endpoints.analytics.recordPublicEvent(
            sessionBuilder,
            'sarah-connor',
            'profile_qr_view',
            null,
          );
          expect(qrViewResult, isTrue);

          // QR download
          final qrDownloadResult = await endpoints.analytics.recordPublicEvent(
            sessionBuilder,
            'sarah-connor',
            'profile_qr_download',
            null,
          );
          expect(qrDownloadResult, isTrue);

          // Profile share
          final shareResult = await endpoints.analytics.recordPublicEvent(
            sessionBuilder,
            'sarah-connor',
            'profile_share',
            null,
          );
          expect(shareResult, isTrue);

          // Dev-one retrieves summary
          final now = DateTime.now();
          final summary = await endpoints.analytics.getAnalyticsSummary(
            authedSession1,
            now.subtract(const Duration(days: 1)),
            now.add(const Duration(days: 1)),
          );

          expect(summary.totalProfileLinkCopies, 1);
          expect(summary.totalQrProfileViews, 1);
          expect(summary.totalQrDownloads, 1);
          expect(summary.totalProfileShares, 1);
          expect(summary.totalEvents, 4);
        },
      );

      test(
        'rejects recording analytics for private or non-existent profile',
        () async {
          // Private profile
          final r1 = await endpoints.analytics.recordPublicEvent(
            sessionBuilder,
            'john-reese',
            'profile_link_copy',
            null,
          );
          expect(r1, isFalse);

          // Non-existent profile
          final r2 = await endpoints.analytics.recordPublicEvent(
            sessionBuilder,
            'ghost-user',
            'profile_qr_view',
            null,
          );
          expect(r2, isFalse);
        },
      );
    });

    group('PublicProfileSeoRoute SEO & Metadata Unit Tests', () {
      test('buildSeoHtml generates valid Open Graph and Twitter Card tags', () {
        final html = PublicProfileSeoRoute.buildSeoHtml(
          publicProfile,
          host: 'app.professionalidentity.dev',
          scheme: 'https',
          isCrawler: true,
        );

        // Meta title & description
        expect(
          html,
          contains('<title>Sarah Connor | Professional Identity</title>'),
        );
        expect(
          html,
          contains(
            '<meta name="description" content="Lead Security Engineer &amp; Architect">',
          ),
        );
        expect(
          html,
          contains(
            '<link rel="canonical" href="https://app.professionalidentity.dev/u/sarah-connor">',
          ),
        );

        // Open Graph
        expect(html, contains('<meta property="og:type" content="profile">'));
        expect(
          html,
          contains(
            '<meta property="og:title" content="Sarah Connor | Professional Identity">',
          ),
        );
        expect(
          html,
          contains(
            '<meta property="og:description" content="Lead Security Engineer &amp; Architect">',
          ),
        );
        expect(
          html,
          contains(
            '<meta property="og:url" content="https://app.professionalidentity.dev/u/sarah-connor">',
          ),
        );
        expect(
          html,
          contains('<meta property="profile:username" content="sarah-connor">'),
        );
        expect(
          html,
          contains(
            '<meta property="og:image" content="https://cdn.example.com/avatars/sarah.png">',
          ),
        );

        // Twitter / X Cards
        expect(html, contains('<meta name="twitter:card" content="summary">'));
        expect(
          html,
          contains(
            '<meta name="twitter:title" content="Sarah Connor | Professional Identity">',
          ),
        );
        expect(
          html,
          contains(
            '<meta name="twitter:description" content="Lead Security Engineer &amp; Architect">',
          ),
        );
        expect(
          html,
          contains(
            '<meta name="twitter:image" content="https://cdn.example.com/avatars/sarah.png">',
          ),
        );

        // Does NOT leak private data
        expect(html, isNot(contains(userId1)));
        expect(html, isNot(contains('authUserId')));
      });

      test(
        'buildSeoHtml safely escapes HTML special characters to prevent XSS',
        () {
          final maliciousProfile = Profile(
            authUserId: UuidValue.fromString(userId1),
            handle: 'hacker<script>',
            fullName: 'Eve <script>alert("hack")</script>',
            headline: 'Security Tester & "Special" \'Chars\'',
            isPublic: true,
          );

          final html = PublicProfileSeoRoute.buildSeoHtml(
            maliciousProfile,
            host: 'app.professionalidentity.dev',
            scheme: 'https',
            isCrawler: true,
          );

          // Script tags must be escaped
          expect(html, isNot(contains('<script>alert')));
          expect(
            html,
            contains('&lt;script&gt;alert(&quot;hack&quot;)&lt;/script&gt;'),
          );
          expect(html, contains('&amp; &quot;Special&quot; &#39;Chars&#39;'));
        },
      );

      test(
        'buildSeoHtml uses fallback description when headline and bio are absent',
        () {
          final minimalProfile = Profile(
            authUserId: UuidValue.fromString(userId1),
            handle: 'minimal-dev',
            fullName: 'Minimal Developer',
            isPublic: true,
          );

          final html = PublicProfileSeoRoute.buildSeoHtml(
            minimalProfile,
            host: 'app.professionalidentity.dev',
            scheme: 'https',
            isCrawler: true,
          );

          expect(
            html,
            contains(
              'Verified digital professional identity and portfolio for Minimal Developer.',
            ),
          );
        },
      );

      test(
        'buildSeoHtml includes client-side redirection script when not a crawler',
        () {
          final html = PublicProfileSeoRoute.buildSeoHtml(
            publicProfile,
            host: 'app.professionalidentity.dev',
            scheme: 'https',
            isCrawler: false,
          );

          expect(
            html,
            contains(
              '<meta http-equiv="refresh" content="0; url=/#/u/sarah-connor">',
            ),
          );
          expect(
            html,
            contains(
              'window.location.replace("/#/u/" + encodeURIComponent("sarah-connor"));',
            ),
          );
        },
      );

      test('database query strictly enforces isPublic == true', () async {
        final session = sessionBuilder.build();

        // Querying private profile with isPublic == true returns null
        final queryResult = await Profile.db.findFirstRow(
          session,
          where: (t) => t.handle.equals('john-reese') & t.isPublic.equals(true),
        );

        expect(queryResult, isNull);
      });
    });
  });
}
