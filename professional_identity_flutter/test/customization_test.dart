import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import 'package:professional_identity_flutter/client.dart';
import 'package:professional_identity_flutter/core/theme/app_theme.dart';
import 'package:professional_identity_flutter/feature/dashboard/view/screens/dashboard_screen.dart';
import 'package:professional_identity_flutter/feature/profile/logic/providers/profile_providers.dart';
import 'package:professional_identity_flutter/feature/profile_customization/logic/providers/profile_customization_providers.dart';
import 'package:professional_identity_flutter/feature/profile_customization/logic/repo/profile_customization_repository.dart';
import 'package:professional_identity_flutter/feature/profile_customization/view/screens/profile_customization_screen.dart';
import 'package:professional_identity_flutter/feature/profile_customization/view/widgets/customization_preview.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

class FakeCustomizationRepository implements ProfileCustomizationRepository {
  ProfileCustomization current;
  final List<ProfileCustomization> savedHistory = [];

  FakeCustomizationRepository(this.current);

  @override
  Future<ProfileCustomization?> getCustomization() async {
    return current;
  }

  @override
  Future<ProfileCustomization?> getPublicCustomization(String handle) async {
    return current;
  }

  @override
  Future<ProfileCustomization> updateCustomization({
    required String themePreset,
    required String? primaryColor,
    required String backgroundStyle,
    required String cardStyle,
    required String borderRadius,
    required String typographyStyle,
  }) async {
    current = current.copyWith(
      themePreset: themePreset,
      primaryColor: primaryColor,
      backgroundStyle: backgroundStyle,
      cardStyle: cardStyle,
      borderRadius: borderRadius,
      typographyStyle: typographyStyle,
      updatedAt: DateTime.now(),
    );
    savedHistory.add(current);
    return current;
  }
}

class FakeErrorCustomizationRepository
    implements ProfileCustomizationRepository {
  @override
  Future<ProfileCustomization?> getCustomization() async {
    throw Exception('Server unreachable');
  }

  @override
  Future<ProfileCustomization?> getPublicCustomization(String handle) async {
    throw Exception('Server unreachable');
  }

  @override
  Future<ProfileCustomization> updateCustomization({
    required String themePreset,
    required String? primaryColor,
    required String backgroundStyle,
    required String cardStyle,
    required String borderRadius,
    required String typographyStyle,
  }) async {
    throw Exception('Failed to save customization');
  }
}

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    client = Client('http://localhost:8080/')
      ..connectivityMonitor = FlutterConnectivityMonitor()
      ..authSessionManager = FlutterAuthSessionManager();
  });

  final testCustomization = ProfileCustomization(
    id: 1,
    profileId: 10,
    themePreset: 'minimal',
    primaryColor: '#2563EB',
    backgroundStyle: 'solid',
    cardStyle: 'outlined',
    borderRadius: 'medium',
    typographyStyle: 'modern',
    updatedAt: DateTime.now(),
  );

  final testProfile = Profile(
    id: 10,
    authUserId: UuidValue.fromString('00000000-0000-0000-0000-000000000010'),
    handle: 'alex-morgan',
    fullName: 'Alex Morgan',
    headline: 'Staff Cloud Architect',
    isPublic: true,
  );

  group('ProfileCustomizationScreen Widget & Control Tests', () {
    testWidgets('renders all customization controls and initial preview', (
      tester,
    ) async {
      final fakeRepo = FakeCustomizationRepository(testCustomization);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            profileCustomizationRepositoryProvider.overrideWithValue(fakeRepo),
            userProfileNotifierProvider.overrideWith(
              () => _MockProfileNotifier(testProfile),
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const ProfileCustomizationScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Screen Header
      expect(find.text('Profile Appearance'), findsOneWidget);

      // Theme Presets
      expect(find.text('Theme Presets'), findsOneWidget);
      expect(find.text('Minimal'), findsOneWidget);
      expect(find.text('Modern'), findsOneWidget);
      expect(find.text('Professional'), findsOneWidget);
      expect(find.text('Dark'), findsOneWidget);

      // Primary Color Palette
      expect(find.text('Primary Accent Color'), findsOneWidget);
      expect(find.text('Royal Blue'), findsOneWidget);
      expect(find.text('Indigo'), findsOneWidget);
      expect(find.text('Emerald'), findsOneWidget);

      // Visual Controls
      expect(find.text('Background Style'), findsOneWidget);
      expect(find.text('Card Style'), findsOneWidget);
      expect(find.text('Border Radius'), findsOneWidget);
      expect(find.text('Typography Style'), findsOneWidget);

      // Live Preview Component
      expect(find.byType(CustomizationPreview), findsOneWidget);
      expect(find.text('Alex Morgan'), findsOneWidget);
      expect(find.text('Staff Cloud Architect'), findsOneWidget);

      // Save Button
      expect(find.text('Save Appearance Changes'), findsOneWidget);
    });

    testWidgets('Live preview updates immediately when changing theme preset', (
      tester,
    ) async {
      final fakeRepo = FakeCustomizationRepository(testCustomization);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            profileCustomizationRepositoryProvider.overrideWithValue(fakeRepo),
            userProfileNotifierProvider.overrideWith(
              () => _MockProfileNotifier(testProfile),
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const ProfileCustomizationScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Tap 'Dark' preset
      await tester.tap(find.text('Dark'));
      await tester.pumpAndSettle();

      final preview = tester.widget<CustomizationPreview>(
        find.byType(CustomizationPreview),
      );
      expect(preview.customization.themePreset, equals('dark'));
      expect(preview.customization.primaryColor, equals('#0D9488'));
      expect(preview.customization.cardStyle, equals('elevated'));
    });

    testWidgets('Live preview updates immediately when picking color', (
      tester,
    ) async {
      final fakeRepo = FakeCustomizationRepository(testCustomization);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            profileCustomizationRepositoryProvider.overrideWithValue(fakeRepo),
            userProfileNotifierProvider.overrideWith(
              () => _MockProfileNotifier(testProfile),
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const ProfileCustomizationScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Tap 'Emerald' color
      await tester.tap(find.text('Emerald'));
      await tester.pumpAndSettle();

      final preview = tester.widget<CustomizationPreview>(
        find.byType(CustomizationPreview),
      );
      expect(preview.customization.primaryColor, equals('#059669'));
    });

    testWidgets(
      'Saving customization calls repository and shows success feedback',
      (tester) async {
        final fakeRepo = FakeCustomizationRepository(testCustomization);

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              profileCustomizationRepositoryProvider.overrideWithValue(
                fakeRepo,
              ),
              userProfileNotifierProvider.overrideWith(
                () => _MockProfileNotifier(testProfile),
              ),
            ],
            child: MaterialApp(
              theme: AppTheme.light(),
              home: const ProfileCustomizationScreen(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Tap 'Professional' preset
        await tester.tap(find.text('Professional'));
        await tester.pumpAndSettle();

        // Tap Save button
        await tester.scrollUntilVisible(
          find.text('Save Appearance Changes'),
          200,
          scrollable: find.byType(Scrollable).first,
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text('Save Appearance Changes'));
        await tester.pumpAndSettle();

        expect(fakeRepo.savedHistory, hasLength(1));
        expect(fakeRepo.savedHistory.first.themePreset, equals('professional'));
        expect(find.byType(SnackBar), findsOneWidget);
        expect(
          find.text('Profile appearance saved successfully!'),
          findsOneWidget,
        );
      },
    );

    testWidgets('renders error card on repository failure and allows retry', (
      tester,
    ) async {
      final errorRepo = FakeErrorCustomizationRepository();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            profileCustomizationRepositoryProvider.overrideWithValue(errorRepo),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const ProfileCustomizationScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Failed to load customization'), findsOneWidget);
      expect(find.text('Try Again'), findsOneWidget);
    });
  });

  group('Dashboard Customization Integration Tests', () {
    testWidgets(
      'Dashboard renders Customize Profile module card and navigates to screen',
      (tester) async {
        final fakeRepo = FakeCustomizationRepository(testCustomization);

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              userProfileNotifierProvider.overrideWith(
                () => _MockProfileNotifier(testProfile),
              ),
              profileCustomizationRepositoryProvider.overrideWithValue(
                fakeRepo,
              ),
            ],
            child: MaterialApp(
              theme: AppTheme.light(),
              home: const DashboardScreen(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Module card verified
        expect(find.text('Customize Profile'), findsOneWidget);
        expect(find.text('Customize'), findsOneWidget);

        // Scroll to Customize button and tap it
        await tester.scrollUntilVisible(find.text('Customize'), 300);
        await tester.pumpAndSettle();
        await tester.tap(find.text('Customize'));
        await tester.pumpAndSettle();

        // Verified navigation to ProfileCustomizationScreen
        expect(find.byType(ProfileCustomizationScreen), findsOneWidget);
      },
    );
  });

  group(
    'Responsive Multi-Viewport Stress Tests for ProfileCustomizationScreen',
    () {
      final fakeRepo = FakeCustomizationRepository(testCustomization);

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
                profileCustomizationRepositoryProvider.overrideWithValue(
                  fakeRepo,
                ),
                userProfileNotifierProvider.overrideWith(
                  () => _MockProfileNotifier(testProfile),
                ),
              ],
              child: MaterialApp(
                theme: AppTheme.light(),
                home: const ProfileCustomizationScreen(),
              ),
            ),
          );

          await tester.pumpAndSettle();

          expect(tester.takeException(), isNull);
          expect(find.text('Profile Appearance'), findsOneWidget);
          expect(find.byType(CustomizationPreview), findsOneWidget);
        });
      }
    },
  );
}

class _MockProfileNotifier extends UserProfileNotifier {
  final Profile? _profile;
  _MockProfileNotifier([this._profile]);

  @override
  Future<Profile?> build() async {
    return _profile;
  }
}
