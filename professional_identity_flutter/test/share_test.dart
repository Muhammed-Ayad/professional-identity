import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import 'package:professional_identity_flutter/client.dart';
import 'package:professional_identity_flutter/core/theme/app_theme.dart';
import 'package:professional_identity_flutter/core/utils/url_builder.dart';
import 'package:professional_identity_flutter/feature/dashboard/view/screens/dashboard_screen.dart';
import 'package:professional_identity_flutter/feature/profile/logic/providers/profile_providers.dart';
import 'package:professional_identity_flutter/feature/share/view/screens/share_identity_screen.dart';
import 'package:professional_identity_flutter/feature/share/view/widgets/public_profile_qr.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

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

  group('PublicProfileUrlBuilder Unit Tests', () {
    test('Default base URL is used when unconfigured', () {
      PublicProfileUrlBuilder.setBaseUrl(null);
      final url = PublicProfileUrlBuilder.buildUrl('johndoe');
      expect(url, 'https://professional-identity.serverpod.space/u/johndoe');
    });

    test('Custom base URL with trailing slash is properly formatted', () {
      PublicProfileUrlBuilder.setBaseUrl('https://mycustomdomain.com/');
      final url = PublicProfileUrlBuilder.buildUrl('alex-smith');
      expect(url, 'https://mycustomdomain.com/u/alex-smith');
    });

    test('Clean handles with /u/ prefix and spaces', () {
      PublicProfileUrlBuilder.setBaseUrl('https://identity.dev');
      expect(
        PublicProfileUrlBuilder.buildUrl('  /u/mohamed-ayad  '),
        'https://identity.dev/u/mohamed-ayad',
      );
      expect(
        PublicProfileUrlBuilder.buildUrl('u/jane'),
        'https://identity.dev/u/jane',
      );
    });
  });

  group('PublicProfileQr Widget Tests', () {
    testWidgets('Renders QR code with proper payload and subtitle', (
      tester,
    ) async {
      const testUrl = 'https://app.professionalidentity.dev/u/developer';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: PublicProfileQr(
                url: testUrl,
                size: 200,
                showUrlSubtitle: true,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(QrImageView), findsOneWidget);
      expect(find.text(testUrl), findsOneWidget);
    });

    testWidgets('Scales cleanly without overflow on very small constraints', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(320, 568);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: PublicProfileQr(
                url:
                    'https://app.professionalidentity.dev/u/developer-with-a-very-long-handle-name',
                size: 250,
              ),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      expect(find.byType(QrImageView), findsOneWidget);
    });
  });

  group('ShareIdentityScreen Widget Tests', () {
    final mockPublicProfile = Profile(
      id: 1,
      authUserId: UuidValue.fromString('00000000-0000-0000-0000-000000000001'),
      handle: 'johndoe',
      fullName: 'John Doe',
      headline: 'Senior Full Stack Engineer',
      isPublic: true,
    );

    final mockPrivateProfile = Profile(
      id: 2,
      authUserId: UuidValue.fromString('00000000-0000-0000-0000-000000000002'),
      handle: 'secretdev',
      fullName: 'Secret Developer',
      headline: 'Stealth Startup Founder',
      isPublic: false,
    );

    testWidgets(
      'Displays profile info, QR code and buttons for public profile',
      (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              userProfileNotifierProvider.overrideWith(
                () => MockProfileNotifier(mockPublicProfile),
              ),
            ],
            child: MaterialApp(
              theme: AppTheme.light(),
              home: ShareIdentityScreen(initialProfile: mockPublicProfile),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('Share Identity'), findsOneWidget);
        expect(find.text('John Doe'), findsOneWidget);
        expect(find.text('Senior Full Stack Engineer'), findsOneWidget);
        expect(find.byType(PublicProfileQr), findsOneWidget);
        expect(find.text('Copy Link'), findsOneWidget);
        expect(find.text('Share Profile'), findsOneWidget);
        expect(find.text('Open Public Profile View'), findsOneWidget);

        // Verify privacy banner is NOT shown for public profile
        expect(find.byIcon(Icons.warning_amber_rounded), findsNothing);
      },
    );

    testWidgets('Shows privacy warning banner when profile is private', (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userProfileNotifierProvider.overrideWith(
              () => MockProfileNotifier(mockPrivateProfile),
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: ShareIdentityScreen(initialProfile: mockPrivateProfile),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.warning_amber_rounded), findsOneWidget);
      expect(
        find.textContaining('Your profile is currently Private'),
        findsOneWidget,
      );
    });

    testWidgets(
      'Copy Link button puts complete URL in clipboard and shows snackbar',
      (tester) async {
        String? copiedString;
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(SystemChannels.platform, (
              methodCall,
            ) async {
              if (methodCall.method == 'Clipboard.setData') {
                copiedString = (methodCall.arguments as Map)['text'] as String?;
              }
              return null;
            });

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              userProfileNotifierProvider.overrideWith(
                () => MockProfileNotifier(mockPublicProfile),
              ),
            ],
            child: MaterialApp(
              theme: AppTheme.light(),
              home: ShareIdentityScreen(initialProfile: mockPublicProfile),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Tap Copy Link
        await tester.tap(find.text('Copy Link'));
        await tester.pump(); // trigger snackbar

        final expectedUrl = PublicProfileUrlBuilder.buildUrl('johndoe');
        expect(copiedString, expectedUrl);
        expect(find.byType(SnackBar), findsOneWidget);
        expect(
          find.textContaining('Copied link $expectedUrl to clipboard'),
          findsOneWidget,
        );
      },
    );

    testWidgets('Handles no profile state gracefully', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userProfileNotifierProvider.overrideWith(
              () => MockProfileNotifier(null),
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const ShareIdentityScreen(initialProfile: null),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(
        find.text('No profile found. Please create your profile first.'),
        findsOneWidget,
      );
    });
  });

  group('Dashboard Integration Tests', () {
    final mockProfile = Profile(
      id: 1,
      authUserId: UuidValue.fromString('00000000-0000-0000-0000-000000000001'),
      handle: 'sarah-dev',
      fullName: 'Sarah Connor',
      headline: 'Cyber Security Engineer',
      isPublic: true,
    );

    testWidgets('Dashboard renders Share Identity button and Module card', (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userProfileNotifierProvider.overrideWith(
              () => MockProfileNotifier(mockProfile),
            ),
          ],
          child: const MaterialApp(
            home: DashboardScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Hero Share Identity button exists
      expect(find.text('Share Identity'), findsWidgets);
      // Both View Public and Share Identity exist
      expect(find.text('View Public'), findsOneWidget);
      // Share Profile action button on module card exists
      expect(find.text('Share Profile'), findsOneWidget);
    });
  });

  group('Multi-Device Responsive Stress Tests for ShareIdentityScreen', () {
    final mockProfile = Profile(
      id: 1,
      authUserId: UuidValue.fromString('00000000-0000-0000-0000-000000000001'),
      handle: 'responsive-tester',
      fullName: 'Responsive Developer',
      headline: 'Cross-Platform Engineer & UI/UX Specialist',
      isPublic: true,
    );

    final viewports = [
      {'name': 'Compact Mobile (320x568)', 'size': const Size(320, 568)},
      {'name': 'Standard Phone (390x844)', 'size': const Size(390, 844)},
      {'name': 'Tablet Portrait (768x1024)', 'size': const Size(768, 1024)},
      {'name': 'Desktop Browser (1440x900)', 'size': const Size(1440, 900)},
    ];

    for (final vp in viewports) {
      testWidgets('Renders cleanly on ${vp['name']} with 0 overflows', (
        tester,
      ) async {
        final size = vp['size'] as Size;
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              userProfileNotifierProvider.overrideWith(
                () => MockProfileNotifier(mockProfile),
              ),
            ],
            child: MaterialApp(
              theme: AppTheme.light(),
              home: ShareIdentityScreen(initialProfile: mockProfile),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        expect(find.text('Responsive Developer'), findsOneWidget);
        expect(find.byType(PublicProfileQr), findsOneWidget);
        expect(find.text('Copy Link'), findsOneWidget);
        expect(find.text('Share Profile'), findsOneWidget);
      });
    }
  });
}

class MockProfileNotifier extends UserProfileNotifier {
  final Profile? initialData;
  MockProfileNotifier(this.initialData);

  @override
  Future<Profile?> build() async {
    return initialData;
  }
}
