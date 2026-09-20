import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import 'package:professional_identity_flutter/client.dart';
import 'package:professional_identity_flutter/core/theme/app_theme.dart';
import 'package:professional_identity_flutter/feature/analytics/logic/providers/analytics_providers.dart';
import 'package:professional_identity_flutter/feature/analytics/logic/repo/analytics_repository.dart';
import 'package:professional_identity_flutter/feature/analytics/view/screens/analytics_screen.dart';
import 'package:professional_identity_flutter/feature/analytics/view/widgets/profile_views_chart.dart';
import 'package:professional_identity_flutter/feature/dashboard/view/screens/dashboard_screen.dart';
import 'package:professional_identity_flutter/feature/profile/logic/providers/profile_providers.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

class FakeAnalyticsRepository implements AnalyticsRepository {
  final AnalyticsSummary mockSummary;
  final List<Map<String, dynamic>> recordedEvents = [];

  FakeAnalyticsRepository(this.mockSummary);

  @override
  Future<AnalyticsSummary> getAnalyticsSummary({
    required DateTime from,
    required DateTime to,
  }) async {
    return mockSummary;
  }

  @override
  Future<void> recordPublicEvent({
    required String handle,
    required String eventType,
    String? target,
  }) async {
    recordedEvents.add({
      'handle': handle,
      'eventType': eventType,
      'target': target,
    });
  }
}

class FakeErrorAnalyticsRepository implements AnalyticsRepository {
  @override
  Future<AnalyticsSummary> getAnalyticsSummary({
    required DateTime from,
    required DateTime to,
  }) async {
    throw Exception('Database connection timed out');
  }

  @override
  Future<void> recordPublicEvent({
    required String handle,
    required String eventType,
    String? target,
  }) async {}
}

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    client = Client('http://localhost:8080/')
      ..connectivityMonitor = FlutterConnectivityMonitor()
      ..authSessionManager = FlutterAuthSessionManager();
  });

  final testSummary = AnalyticsSummary(
    totalProfileViews: 42,
    totalSocialLinkClicks: 18,
    totalProjectClicks: 12,
    totalCvViews: 7,
    totalProfileShares: 5,
    totalQrProfileViews: 3,
    totalEvents: 84,
    socialLinkClicksByPlatform: [
      NamedCount(name: 'github', count: 10),
      NamedCount(name: 'linkedin', count: 8),
    ],
    projectClicksByProject: [
      NamedCount(name: 'Serverpod Digital Hub', count: 8),
      NamedCount(name: 'Flutter Portfolio', count: 4),
    ],
    dailyProfileViews: [
      DailyEventCount(date: DateTime(2026, 9, 1), count: 5),
      DailyEventCount(date: DateTime(2026, 9, 2), count: 12),
      DailyEventCount(date: DateTime(2026, 9, 3), count: 25),
    ],
    dailyTotalEvents: [
      DailyEventCount(date: DateTime(2026, 9, 1), count: 10),
      DailyEventCount(date: DateTime(2026, 9, 2), count: 24),
      DailyEventCount(date: DateTime(2026, 9, 3), count: 50),
    ],
  );

  final emptySummary = AnalyticsSummary(
    totalProfileViews: 0,
    totalSocialLinkClicks: 0,
    totalProjectClicks: 0,
    totalCvViews: 0,
    totalProfileShares: 0,
    totalQrProfileViews: 0,
    totalEvents: 0,
    socialLinkClicksByPlatform: [],
    projectClicksByProject: [],
    dailyProfileViews: [],
    dailyTotalEvents: [],
  );

  group('AnalyticsScreen Widget Tests', () {
    testWidgets(
      'renders all metric cards, chart, and top lists when data is loaded',
      (tester) async {
        final fakeRepo = FakeAnalyticsRepository(testSummary);

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              analyticsRepositoryProvider.overrideWithValue(fakeRepo),
            ],
            child: MaterialApp(
              theme: AppTheme.light(),
              home: const AnalyticsScreen(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('Profile Analytics'), findsWidgets);
        expect(find.text('Last 30 Days'), findsWidgets);

        // Check metric cards
        expect(find.text('42'), findsOneWidget); // Profile Views
        expect(find.text('Profile Views'), findsWidgets);
        expect(find.text('18'), findsOneWidget); // Social Clicks
        expect(find.text('Social Clicks'), findsOneWidget);
        expect(find.text('12'), findsOneWidget); // Project Clicks
        expect(find.text('Project Clicks'), findsOneWidget);
        expect(find.text('7'), findsOneWidget); // CV Views
        expect(find.text('CV Views'), findsOneWidget);
        expect(find.text('5'), findsOneWidget); // Shares
        expect(find.text('Shares'), findsOneWidget);

        // Total events
        expect(find.text('84'), findsOneWidget);

        // Chart
        expect(find.byType(ProfileViewsChart), findsOneWidget);

        // Top lists
        expect(find.text('Top Social Links'), findsOneWidget);
        expect(find.text('GITHUB'), findsOneWidget);
        expect(find.text('10'), findsOneWidget);
        expect(find.text('Top Projects'), findsOneWidget);
        expect(find.text('SERVERPOD DIGITAL HUB'), findsOneWidget);
      },
    );

    testWidgets('renders empty state gracefully when 0 events exist', (
      tester,
    ) async {
      final fakeRepo = FakeAnalyticsRepository(emptySummary);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            analyticsRepositoryProvider.overrideWithValue(fakeRepo),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const AnalyticsScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('No activity recorded in this period'), findsOneWidget);
      expect(find.text('No social link clicks yet'), findsOneWidget);
      expect(find.text('No project clicks yet'), findsOneWidget);
    });

    testWidgets('renders error card on repository failure and allows retry', (
      tester,
    ) async {
      final errorRepo = FakeErrorAnalyticsRepository();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            analyticsRepositoryProvider.overrideWithValue(errorRepo),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const AnalyticsScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Failed to load analytics'), findsOneWidget);
      expect(find.text('Try Again'), findsOneWidget);
    });

    testWidgets('allows changing date range filter', (tester) async {
      final fakeRepo = FakeAnalyticsRepository(testSummary);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            analyticsRepositoryProvider.overrideWithValue(fakeRepo),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const AnalyticsScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Tap 'Last 7 Days'
      await tester.tap(find.text('Last 7 Days'));
      await tester.pumpAndSettle();

      expect(find.text('Profile Analytics'), findsWidgets);
    });
  });

  group('Dashboard Analytics Integration Tests', () {
    final mockProfile = Profile(
      id: 1,
      authUserId: UuidValue.fromString('00000000-0000-0000-0000-000000000001'),
      handle: 'johndoe',
      fullName: 'John Doe',
      isPublic: true,
    );

    testWidgets(
      'Dashboard renders Analytics module card and navigates to AnalyticsScreen',
      (tester) async {
        final fakeRepo = FakeAnalyticsRepository(testSummary);

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              userProfileNotifierProvider.overrideWith(
                () => _MockUserProfileNotifier(mockProfile),
              ),
              analyticsRepositoryProvider.overrideWithValue(fakeRepo),
              dashboardAnalyticsSummaryProvider.overrideWith(
                (ref) async => testSummary,
              ),
            ],
            child: MaterialApp(
              theme: AppTheme.light(),
              home: const DashboardScreen(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.text('Analytics'), findsOneWidget);
        expect(find.text('42 views'), findsOneWidget);
        expect(find.text('View Analytics'), findsOneWidget);

        // Ensure View Analytics is scrolled into view before tapping
        await tester.scrollUntilVisible(find.text('View Analytics'), 300);
        await tester.pumpAndSettle();

        // Tap View Analytics button
        await tester.tap(find.text('View Analytics'));
        await tester.pumpAndSettle();

        // Verified navigation to AnalyticsScreen
        expect(find.byType(AnalyticsScreen), findsOneWidget);
      },
    );
  });

  group('Responsive Multi-Viewport Stress Tests for AnalyticsScreen', () {
    final fakeRepo = FakeAnalyticsRepository(testSummary);

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
              analyticsRepositoryProvider.overrideWithValue(fakeRepo),
            ],
            child: MaterialApp(
              theme: AppTheme.light(),
              home: const AnalyticsScreen(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        expect(find.text('Profile Analytics'), findsWidgets);
        expect(find.text('42'), findsOneWidget);
      });
    }
  });
}

class _MockUserProfileNotifier extends UserProfileNotifier {
  final Profile? _profile;
  _MockUserProfileNotifier([this._profile]);

  @override
  Future<Profile?> build() async {
    return _profile;
  }
}
