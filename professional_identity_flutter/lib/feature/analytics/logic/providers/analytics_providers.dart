import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import '../repo/analytics_repository.dart';

/// Supported date ranges for analytics dashboard.
enum AnalyticsDateRange {
  last7Days,
  last30Days,
  last90Days,
  last12Months,
}

extension AnalyticsDateRangeExtension on AnalyticsDateRange {
  String get label {
    switch (this) {
      case AnalyticsDateRange.last7Days:
        return 'Last 7 Days';
      case AnalyticsDateRange.last30Days:
        return 'Last 30 Days';
      case AnalyticsDateRange.last90Days:
        return 'Last 90 Days';
      case AnalyticsDateRange.last12Months:
        return 'Last 12 Months';
    }
  }

  DateTime calculateStartDate(DateTime now) {
    switch (this) {
      case AnalyticsDateRange.last7Days:
        return now.subtract(const Duration(days: 7));
      case AnalyticsDateRange.last30Days:
        return now.subtract(const Duration(days: 30));
      case AnalyticsDateRange.last90Days:
        return now.subtract(const Duration(days: 90));
      case AnalyticsDateRange.last12Months:
        return now.subtract(const Duration(days: 365));
    }
  }
}

/// Provider for the singleton analytics repository.
final analyticsRepositoryProvider = Provider<AnalyticsRepository>((ref) {
  return AnalyticsRepository();
});

/// Provider for the currently selected date range filter.
final analyticsDateRangeProvider = StateProvider<AnalyticsDateRange>((ref) {
  return AnalyticsDateRange.last30Days;
});

/// AsyncNotifier managing the authenticated user's analytics summary.
final analyticsSummaryNotifierProvider =
    AsyncNotifierProvider<AnalyticsSummaryNotifier, AnalyticsSummary>(() {
      return AnalyticsSummaryNotifier();
    });

class AnalyticsSummaryNotifier extends AsyncNotifier<AnalyticsSummary> {
  @override
  FutureOr<AnalyticsSummary> build() async {
    final range = ref.watch(analyticsDateRangeProvider);
    final repo = ref.read(analyticsRepositoryProvider);

    final now = DateTime.now();
    final from = range.calculateStartDate(now);

    return await repo.getAnalyticsSummary(from: from, to: now);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final range = ref.read(analyticsDateRangeProvider);
      final repo = ref.read(analyticsRepositoryProvider);
      final now = DateTime.now();
      final from = range.calculateStartDate(now);
      return await repo.getAnalyticsSummary(from: from, to: now);
    });
  }
}

/// Provider for a lightweight 30-day summary to be displayed on the dashboard card.
final dashboardAnalyticsSummaryProvider = FutureProvider<AnalyticsSummary?>((
  ref,
) async {
  try {
    final repo = ref.read(analyticsRepositoryProvider);
    final now = DateTime.now();
    final from = now.subtract(const Duration(days: 30));
    return await repo.getAnalyticsSummary(from: from, to: now);
  } catch (_) {
    // Graceful fallback for dashboard card if unauthenticated or network failure
    return null;
  }
});
