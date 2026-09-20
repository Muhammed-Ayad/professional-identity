import 'dart:developer' as developer;
import 'package:professional_identity_client/professional_identity_client.dart';
import '../../../../client.dart';

/// Repository handling analytics data and event tracking with Serverpod.
class AnalyticsRepository {
  /// Records a public interaction event (profile_view, social_link_click, etc.)
  ///
  /// This call is fire-and-forget and safe. Any failure is silently caught and logged
  /// so that analytics issues never interrupt or break public visitor experience.
  Future<void> recordPublicEvent({
    required String handle,
    required String eventType,
    String? target,
  }) async {
    try {
      await client.analytics.recordPublicEvent(handle, eventType, target);
    } catch (e, stack) {
      developer.log(
        'Analytics event recording failed for $eventType ($target): $e',
        error: e,
        stackTrace: stack,
        name: 'AnalyticsRepository',
      );
    }
  }

  /// Fetches the aggregated analytics summary for the authenticated user's profile
  /// within the given date window [from] to [to].
  Future<AnalyticsSummary> getAnalyticsSummary({
    required DateTime from,
    required DateTime to,
  }) async {
    return await client.analytics.getAnalyticsSummary(from, to);
  }
}
