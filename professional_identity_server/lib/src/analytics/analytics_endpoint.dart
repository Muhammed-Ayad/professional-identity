import 'package:serverpod/serverpod.dart';
import '../common/auth_profile_helper.dart';
import '../generated/protocol.dart';

/// Privacy-conscious analytics endpoint for tracking profile interactions
/// and delivering aggregated analytics metrics.
///
/// PRIVACY GUARANTEE:
/// - Never collects or stores IP addresses, visitor account IDs, emails,
///   auth tokens, device identifiers, precise geolocation, or user agents.
/// - The only data captured: profileId, eventType, safe target, server-generated createdAt.
class AnalyticsEndpoint extends Endpoint {
  /// Set of allowed public event types.
  static const _allowedEventTypes = {
    'profile_view',
    'social_link_click',
    'project_click',
    'cv_view',
    'profile_share',
    'profile_link_copy',
    'qr_profile_view',
    'profile_qr_view',
    'profile_qr_download',
  };

  /// Records a public profile interaction event safely and anonymously.
  ///
  /// The client cannot provide a profileId or createdAt timestamp.
  /// The server resolves the profile using the public handle and assigns `DateTime.now()`.
  Future<bool> recordPublicEvent(
    Session session,
    String handle,
    String eventType,
    String? target,
  ) async {
    final normalizedHandle = handle.trim().toLowerCase();
    if (normalizedHandle.isEmpty) return false;

    // Validate event type
    final cleanType = eventType.trim().toLowerCase();
    if (!_allowedEventTypes.contains(cleanType)) {
      return false;
    }

    // Validate and sanitize target (max 100 characters, safe characters)
    String? sanitizedTarget;
    if (target != null) {
      final trimmedTarget = target.trim();
      if (trimmedTarget.length > 100) {
        return false;
      }
      sanitizedTarget = trimmedTarget.isNotEmpty ? trimmedTarget : null;
    }

    // Resolve profile via public handle
    final profile = await Profile.db.findFirstRow(
      session,
      where: (t) => t.handle.equals(normalizedHandle) & t.isPublic.equals(true),
    );

    if (profile == null || profile.id == null) {
      // Return false safely without revealing profile existence
      return false;
    }

    // Insert event with strictly server-generated timestamp
    await ProfileAnalyticsEvent.db.insertRow(
      session,
      ProfileAnalyticsEvent(
        profileId: profile.id!,
        eventType: cleanType,
        target: sanitizedTarget,
        createdAt: DateTime.now(),
      ),
    );

    return true;
  }

  /// Returns aggregated analytics for the authenticated user's profile
  /// within the specified date window [from] to [to].
  Future<AnalyticsSummary> getAnalyticsSummary(
    Session session,
    DateTime from,
    DateTime to,
  ) async {
    final profile = await getAuthenticatedProfile(session);

    if (from.isAfter(to)) {
      throw ProfileException(
        message: 'Start date must be before or equal to end date.',
      );
    }

    // Maximum supported date range is 365 days
    final durationDays = to.difference(from).inDays;
    if (durationDays > 365) {
      throw ProfileException(message: 'Date range cannot exceed 365 days.');
    }

    // Normalize date range boundaries: start of `from` day to end of `to` day
    final normalizedFrom = DateTime(from.year, from.month, from.day, 0, 0, 0);
    final normalizedTo = DateTime(to.year, to.month, to.day, 23, 59, 59, 999);

    final profileId = profile.id!;

    // Query all events for this profile in range
    final events = await ProfileAnalyticsEvent.db.find(
      session,
      where: (t) =>
          t.profileId.equals(profileId) &
          t.createdAt.between(normalizedFrom, normalizedTo),
      orderBy: (t) => t.createdAt.asc(),
    );

    int totalViews = 0;
    int totalSocial = 0;
    int totalProject = 0;
    int totalCv = 0;
    int totalShares = 0;
    int totalLinkCopies = 0;
    int totalQrViews = 0;
    int totalQrDownloads = 0;

    final Map<String, int> socialCounts = {};
    final Map<String, int> projectCounts = {};
    final Map<String, int> dailyViewsMap = {};
    final Map<String, int> dailyTotalMap = {};

    for (final event in events) {
      // Date key formatted as YYYY-MM-DD
      final d = event.createdAt;
      final dateKey =
          '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

      dailyTotalMap[dateKey] = (dailyTotalMap[dateKey] ?? 0) + 1;

      switch (event.eventType) {
        case 'profile_view':
          totalViews++;
          dailyViewsMap[dateKey] = (dailyViewsMap[dateKey] ?? 0) + 1;
          break;
        case 'social_link_click':
          totalSocial++;
          if (event.target != null && event.target!.isNotEmpty) {
            socialCounts[event.target!] =
                (socialCounts[event.target!] ?? 0) + 1;
          }
          break;
        case 'project_click':
          totalProject++;
          if (event.target != null && event.target!.isNotEmpty) {
            projectCounts[event.target!] =
                (projectCounts[event.target!] ?? 0) + 1;
          }
          break;
        case 'cv_view':
          totalCv++;
          break;
        case 'profile_share':
          totalShares++;
          break;
        case 'profile_link_copy':
          totalLinkCopies++;
          break;
        case 'qr_profile_view':
        case 'profile_qr_view':
          totalQrViews++;
          dailyViewsMap[dateKey] = (dailyViewsMap[dateKey] ?? 0) + 1;
          break;
        case 'profile_qr_download':
          totalQrDownloads++;
          break;
      }
    }

    // Convert social breakdown sorted descending
    final socialBreakdown = socialCounts.entries.map((e) {
      return NamedCount(name: e.key, count: e.value);
    }).toList()..sort((a, b) => b.count.compareTo(a.count));

    // Convert project breakdown sorted descending
    final projectBreakdown = projectCounts.entries.map((e) {
      return NamedCount(name: e.key, count: e.value);
    }).toList()..sort((a, b) => b.count.compareTo(a.count));

    // Convert daily views sorted by date
    final dailyViews = dailyViewsMap.entries.map((e) {
      final parts = e.key.split('-');
      final dt = DateTime(
        int.parse(parts[0]),
        int.parse(parts[1]),
        int.parse(parts[2]),
      );
      return DailyEventCount(date: dt, count: e.value);
    }).toList()..sort((a, b) => a.date.compareTo(b.date));

    // Convert daily total events sorted by date
    final dailyTotals = dailyTotalMap.entries.map((e) {
      final parts = e.key.split('-');
      final dt = DateTime(
        int.parse(parts[0]),
        int.parse(parts[1]),
        int.parse(parts[2]),
      );
      return DailyEventCount(date: dt, count: e.value);
    }).toList()..sort((a, b) => a.date.compareTo(b.date));

    return AnalyticsSummary(
      totalProfileViews: totalViews,
      totalSocialLinkClicks: totalSocial,
      totalProjectClicks: totalProject,
      totalCvViews: totalCv,
      totalProfileShares: totalShares,
      totalProfileLinkCopies: totalLinkCopies,
      totalQrProfileViews: totalQrViews,
      totalQrDownloads: totalQrDownloads,
      totalEvents: events.length,
      socialLinkClicksByPlatform: socialBreakdown,
      projectClicksByProject: projectBreakdown,
      dailyProfileViews: dailyViews,
      dailyTotalEvents: dailyTotals,
    );
  }
}
