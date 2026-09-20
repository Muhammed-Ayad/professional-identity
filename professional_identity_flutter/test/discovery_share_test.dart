import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import 'package:professional_identity_flutter/client.dart';
import 'package:professional_identity_flutter/core/theme/app_theme.dart';
import 'package:professional_identity_flutter/core/utils/url_builder.dart';
import 'package:professional_identity_flutter/feature/analytics/logic/providers/analytics_providers.dart';
import 'package:professional_identity_flutter/feature/analytics/logic/repo/analytics_repository.dart';
import 'package:professional_identity_flutter/feature/profile/logic/providers/profile_providers.dart';
import 'package:professional_identity_flutter/feature/public_profile/logic/providers/public_profile_providers.dart';
import 'package:professional_identity_flutter/feature/public_profile/view/screens/public_profile_screen.dart';
import 'package:professional_identity_flutter/feature/share/view/screens/share_identity_screen.dart';
import 'package:professional_identity_flutter/feature/share/view/widgets/public_profile_qr.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

class FakeAnalyticsRepository extends AnalyticsRepository {
  final List<String> recordedEvents = [];

  @override
  Future<void> recordPublicEvent({
    required String handle,
    required String eventType,
    String? target,
  }) async {
    recordedEvents.add('$eventType:$handle${target != null ? ':$target' : ''}');
  }
}

class _MockProfileNotifier extends UserProfileNotifier {
  final Profile? _profile;
  _MockProfileNotifier([this._profile]);

  @override
  Future<Profile?> build() async {
    return _profile;
  }
}

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    client = Client('http://localhost:8080/')
      ..connectivityMonitor = FlutterConnectivityMonitor()
      ..authSessionManager = FlutterAuthSessionManager();
  });

  tearDown(() {
    PublicProfileUrlBuilder.setBaseUrl(null);
  });

  final testPublicProfile = PublicProfileData(
    handle: 'diana-prince',
    fullName: 'Diana Prince',
    headline: 'Principal Solutions Architect',
    bio: 'Designing global distributed cloud platforms.',
    currentRole: 'Principal Architect',
    location: 'Seattle, WA',
    websiteUrl: 'https://dianaprince.dev',
    isPublic: true,
    socialLinks: [
      SocialLink(
        profileId: 1,
        platform: 'github',
        url: 'https://github.com/dianaprince',
        label: 'GitHub',
        sortOrder: 0,
      ),
    ],
    skills: [
      Skill(
        profileId: 1,
        name: 'Flutter',
        category: 'Mobile',
        yearsOfExperience: 6,
        sortOrder: 0,
      ),
    ],
    experiences: [],
    projects: [],
  );

  final testProfile = Profile(
    id: 1,
    authUserId: UuidValue.fromString('00000000-0000-0000-0000-000000000001'),
    handle: 'diana-prince',
    fullName: 'Diana Prince',
    headline: 'Principal Solutions Architect',
    bio: 'Designing global distributed cloud platforms.',
    isPublic: true,
  );

  group('Public Profile Discovery, SEO & Title Verification', () {
    testWidgets(
      'renders Title widget with dynamic fullName | Professional Identity',
      (tester) async {
        tester.view.physicalSize = const Size(1280, 1800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final fakeAnalytics = FakeAnalyticsRepository();

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              analyticsRepositoryProvider.overrideWithValue(fakeAnalytics),
              publicProfileFamilyProvider('diana-prince').overrideWith(
                (ref) => Future.value(testPublicProfile),
              ),
            ],
            child: MaterialApp(
              theme: AppTheme.light(),
              home: const PublicProfileScreen(handle: 'diana-prince'),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Verify Title widget with specific dynamic title
        final titleFinder = find.byWidgetPredicate(
          (w) =>
              w is Title && w.title == 'Diana Prince | Professional Identity',
        );
        expect(titleFinder, findsOneWidget);

        // Verify handle in AppBar
        expect(find.text('/u/diana-prince'), findsOneWidget);
        expect(find.text('Diana Prince'), findsWidgets);
      },
    );
  });

  group('Public Profile Sharing, QR & Link Copy Actions', () {
    testWidgets(
      'QR button opens dialog, shows QR and records profile_qr_view',
      (tester) async {
        tester.view.physicalSize = const Size(1280, 1800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final fakeAnalytics = FakeAnalyticsRepository();

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              analyticsRepositoryProvider.overrideWithValue(fakeAnalytics),
              publicProfileFamilyProvider('diana-prince').overrideWith(
                (ref) => Future.value(testPublicProfile),
              ),
            ],
            child: MaterialApp(
              theme: AppTheme.light(),
              home: const PublicProfileScreen(handle: 'diana-prince'),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Tap QR button in AppBar
        await tester.tap(find.byIcon(Icons.qr_code_rounded));
        await tester.pumpAndSettle();

        // Dialog is open with PublicProfileQr
        expect(find.text('Profile QR Code'), findsOneWidget);
        expect(find.byType(PublicProfileQr), findsOneWidget);
        expect(find.text('Save QR'), findsOneWidget);
        expect(find.text('Copy Link'), findsOneWidget);

        // Verify profile_qr_view was recorded
        expect(
          fakeAnalytics.recordedEvents,
          contains('profile_qr_view:diana-prince'),
        );
      },
    );

    testWidgets(
      'Copy Link in QR dialog copies canonical URL and records profile_link_copy',
      (tester) async {
        tester.view.physicalSize = const Size(1280, 1800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final fakeAnalytics = FakeAnalyticsRepository();
        String? clipboardContent;

        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(SystemChannels.platform, (call) async {
              if (call.method == 'Clipboard.setData') {
                clipboardContent = (call.arguments as Map)['text'] as String?;
              }
              return null;
            });

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              analyticsRepositoryProvider.overrideWithValue(fakeAnalytics),
              publicProfileFamilyProvider('diana-prince').overrideWith(
                (ref) => Future.value(testPublicProfile),
              ),
            ],
            child: MaterialApp(
              theme: AppTheme.light(),
              home: const PublicProfileScreen(handle: 'diana-prince'),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Open QR Dialog
        await tester.tap(find.byIcon(Icons.qr_code_rounded));
        await tester.pumpAndSettle();

        // Tap Copy Link in dialog
        await tester.tap(find.text('Copy Link'));
        await tester.pumpAndSettle();

        final expectedUrl = PublicProfileUrlBuilder.buildUrl('diana-prince');
        expect(clipboardContent, expectedUrl);
        expect(
          fakeAnalytics.recordedEvents,
          contains('profile_link_copy:diana-prince'),
        );
        expect(
          find.text('Copied link $expectedUrl to clipboard'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'Save QR in dialog records profile_qr_download and shows feedback snackbar',
      (tester) async {
        tester.view.physicalSize = const Size(1280, 1800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final fakeAnalytics = FakeAnalyticsRepository();

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              analyticsRepositoryProvider.overrideWithValue(fakeAnalytics),
              publicProfileFamilyProvider('diana-prince').overrideWith(
                (ref) => Future.value(testPublicProfile),
              ),
            ],
            child: MaterialApp(
              theme: AppTheme.light(),
              home: const PublicProfileScreen(handle: 'diana-prince'),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Open QR Dialog
        await tester.tap(find.byIcon(Icons.qr_code_rounded));
        await tester.pumpAndSettle();

        // Tap Save QR in dialog
        await tester.tap(find.text('Save QR'));
        await tester.pumpAndSettle();

        expect(
          fakeAnalytics.recordedEvents,
          contains('profile_qr_download:diana-prince'),
        );
        expect(find.text('QR code saved for /u/diana-prince'), findsOneWidget);
      },
    );

    testWidgets(
      'Share button records profile_share event',
      (tester) async {
        tester.view.physicalSize = const Size(1280, 1800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final fakeAnalytics = FakeAnalyticsRepository();

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              analyticsRepositoryProvider.overrideWithValue(fakeAnalytics),
              publicProfileFamilyProvider('diana-prince').overrideWith(
                (ref) => Future.value(testPublicProfile),
              ),
            ],
            child: MaterialApp(
              theme: AppTheme.light(),
              home: const PublicProfileScreen(handle: 'diana-prince'),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Tap Share button in AppBar
        await tester.tap(find.byIcon(Icons.share_outlined));
        await tester.pump();

        expect(
          fakeAnalytics.recordedEvents,
          contains('profile_share:diana-prince'),
        );
      },
    );
  });

  group('ShareIdentityScreen Phase 8 Save QR & Tracking Verification', () {
    testWidgets(
      'Save QR Code button in ShareIdentityScreen records profile_qr_download',
      (tester) async {
        tester.view.physicalSize = const Size(1280, 1800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final fakeAnalytics = FakeAnalyticsRepository();

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              analyticsRepositoryProvider.overrideWithValue(fakeAnalytics),
              userProfileNotifierProvider.overrideWith(
                () => _MockProfileNotifier(testProfile),
              ),
            ],
            child: MaterialApp(
              theme: AppTheme.light(),
              home: ShareIdentityScreen(initialProfile: testProfile),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('Save QR Code'), findsOneWidget);

        // Tap Save QR Code
        await tester.tap(find.text('Save QR Code'));
        await tester.pump();

        expect(
          fakeAnalytics.recordedEvents,
          contains('profile_qr_download:diana-prince'),
        );
        expect(find.text('QR code saved for /u/diana-prince'), findsOneWidget);
      },
    );
  });

  group('Multi-Viewport Responsive Verification for Discovery & Sharing', () {
    final viewports = <String, Size>{
      'Compact Mobile': const Size(320, 568),
      'Standard Phone': const Size(390, 844),
      'Tablet Portrait': const Size(768, 1024),
      'Desktop Browser': const Size(1440, 900),
    };

    for (final entry in viewports.entries) {
      testWidgets(
        'PublicProfileScreen renders cleanly on ${entry.key} (${entry.value.width.toInt()}x${entry.value.height.toInt()}) with 0 overflows',
        (tester) async {
          tester.view.physicalSize = entry.value;
          tester.view.devicePixelRatio = 1.0;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);

          final fakeAnalytics = FakeAnalyticsRepository();

          await tester.pumpWidget(
            ProviderScope(
              overrides: [
                analyticsRepositoryProvider.overrideWithValue(fakeAnalytics),
                publicProfileFamilyProvider('diana-prince').overrideWith(
                  (ref) => Future.value(testPublicProfile),
                ),
              ],
              child: MaterialApp(
                theme: AppTheme.light(),
                home: const PublicProfileScreen(handle: 'diana-prince'),
              ),
            ),
          );

          await tester.pumpAndSettle();

          expect(tester.takeException(), isNull);
          expect(find.text('/u/diana-prince'), findsOneWidget);
          expect(find.text('Diana Prince'), findsWidgets);
        },
      );
    }
  });
}
