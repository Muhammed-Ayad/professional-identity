/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:professional_identity_server/src/generated/protocol.dart'
    as _idwwx28q;
import 'package:serverpod/serverpod.dart' as _is;
import '../../analytics/models/daily_event_count.dart' as _i9xdz41h;
import '../../analytics/models/named_count.dart' as _irqil8bx;

abstract class AnalyticsSummary
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AnalyticsSummary._({
    required this.totalProfileViews,
    required this.totalSocialLinkClicks,
    required this.totalProjectClicks,
    required this.totalCvViews,
    required this.totalProfileShares,
    this.totalProfileLinkCopies,
    required this.totalQrProfileViews,
    this.totalQrDownloads,
    required this.totalEvents,
    required this.socialLinkClicksByPlatform,
    required this.projectClicksByProject,
    required this.dailyProfileViews,
    required this.dailyTotalEvents,
  });

  factory AnalyticsSummary({
    required int totalProfileViews,
    required int totalSocialLinkClicks,
    required int totalProjectClicks,
    required int totalCvViews,
    required int totalProfileShares,
    int? totalProfileLinkCopies,
    required int totalQrProfileViews,
    int? totalQrDownloads,
    required int totalEvents,
    required List<_irqil8bx.NamedCount> socialLinkClicksByPlatform,
    required List<_irqil8bx.NamedCount> projectClicksByProject,
    required List<_i9xdz41h.DailyEventCount> dailyProfileViews,
    required List<_i9xdz41h.DailyEventCount> dailyTotalEvents,
  }) = _AnalyticsSummaryImpl;

  factory AnalyticsSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return AnalyticsSummary(
      totalProfileViews: jsonSerialization['totalProfileViews'] as int,
      totalSocialLinkClicks: jsonSerialization['totalSocialLinkClicks'] as int,
      totalProjectClicks: jsonSerialization['totalProjectClicks'] as int,
      totalCvViews: jsonSerialization['totalCvViews'] as int,
      totalProfileShares: jsonSerialization['totalProfileShares'] as int,
      totalProfileLinkCopies:
          jsonSerialization['totalProfileLinkCopies'] as int?,
      totalQrProfileViews: jsonSerialization['totalQrProfileViews'] as int,
      totalQrDownloads: jsonSerialization['totalQrDownloads'] as int?,
      totalEvents: jsonSerialization['totalEvents'] as int,
      socialLinkClicksByPlatform: _idwwx28q.Protocol()
          .deserialize<List<_irqil8bx.NamedCount>>(
            jsonSerialization['socialLinkClicksByPlatform'],
          ),
      projectClicksByProject: _idwwx28q.Protocol()
          .deserialize<List<_irqil8bx.NamedCount>>(
            jsonSerialization['projectClicksByProject'],
          ),
      dailyProfileViews: _idwwx28q.Protocol()
          .deserialize<List<_i9xdz41h.DailyEventCount>>(
            jsonSerialization['dailyProfileViews'],
          ),
      dailyTotalEvents: _idwwx28q.Protocol()
          .deserialize<List<_i9xdz41h.DailyEventCount>>(
            jsonSerialization['dailyTotalEvents'],
          ),
    );
  }

  int totalProfileViews;

  int totalSocialLinkClicks;

  int totalProjectClicks;

  int totalCvViews;

  int totalProfileShares;

  int? totalProfileLinkCopies;

  int totalQrProfileViews;

  int? totalQrDownloads;

  int totalEvents;

  List<_irqil8bx.NamedCount> socialLinkClicksByPlatform;

  List<_irqil8bx.NamedCount> projectClicksByProject;

  List<_i9xdz41h.DailyEventCount> dailyProfileViews;

  List<_i9xdz41h.DailyEventCount> dailyTotalEvents;

  /// Returns a shallow copy of this [AnalyticsSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AnalyticsSummary copyWith({
    int? totalProfileViews,
    int? totalSocialLinkClicks,
    int? totalProjectClicks,
    int? totalCvViews,
    int? totalProfileShares,
    int? totalProfileLinkCopies,
    int? totalQrProfileViews,
    int? totalQrDownloads,
    int? totalEvents,
    List<_irqil8bx.NamedCount>? socialLinkClicksByPlatform,
    List<_irqil8bx.NamedCount>? projectClicksByProject,
    List<_i9xdz41h.DailyEventCount>? dailyProfileViews,
    List<_i9xdz41h.DailyEventCount>? dailyTotalEvents,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AnalyticsSummary',
      'totalProfileViews': totalProfileViews,
      'totalSocialLinkClicks': totalSocialLinkClicks,
      'totalProjectClicks': totalProjectClicks,
      'totalCvViews': totalCvViews,
      'totalProfileShares': totalProfileShares,
      if (totalProfileLinkCopies != null)
        'totalProfileLinkCopies': totalProfileLinkCopies,
      'totalQrProfileViews': totalQrProfileViews,
      if (totalQrDownloads != null) 'totalQrDownloads': totalQrDownloads,
      'totalEvents': totalEvents,
      'socialLinkClicksByPlatform': socialLinkClicksByPlatform.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      'projectClicksByProject': projectClicksByProject.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      'dailyProfileViews': dailyProfileViews.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      'dailyTotalEvents': dailyTotalEvents.toJson(
        valueToJson: (v) => v.toJson(),
      ),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AnalyticsSummary',
      'totalProfileViews': totalProfileViews,
      'totalSocialLinkClicks': totalSocialLinkClicks,
      'totalProjectClicks': totalProjectClicks,
      'totalCvViews': totalCvViews,
      'totalProfileShares': totalProfileShares,
      if (totalProfileLinkCopies != null)
        'totalProfileLinkCopies': totalProfileLinkCopies,
      'totalQrProfileViews': totalQrProfileViews,
      if (totalQrDownloads != null) 'totalQrDownloads': totalQrDownloads,
      'totalEvents': totalEvents,
      'socialLinkClicksByPlatform': socialLinkClicksByPlatform.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'projectClicksByProject': projectClicksByProject.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'dailyProfileViews': dailyProfileViews.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'dailyTotalEvents': dailyTotalEvents.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AnalyticsSummaryImpl extends AnalyticsSummary {
  _AnalyticsSummaryImpl({
    required int totalProfileViews,
    required int totalSocialLinkClicks,
    required int totalProjectClicks,
    required int totalCvViews,
    required int totalProfileShares,
    int? totalProfileLinkCopies,
    required int totalQrProfileViews,
    int? totalQrDownloads,
    required int totalEvents,
    required List<_irqil8bx.NamedCount> socialLinkClicksByPlatform,
    required List<_irqil8bx.NamedCount> projectClicksByProject,
    required List<_i9xdz41h.DailyEventCount> dailyProfileViews,
    required List<_i9xdz41h.DailyEventCount> dailyTotalEvents,
  }) : super._(
         totalProfileViews: totalProfileViews,
         totalSocialLinkClicks: totalSocialLinkClicks,
         totalProjectClicks: totalProjectClicks,
         totalCvViews: totalCvViews,
         totalProfileShares: totalProfileShares,
         totalProfileLinkCopies: totalProfileLinkCopies,
         totalQrProfileViews: totalQrProfileViews,
         totalQrDownloads: totalQrDownloads,
         totalEvents: totalEvents,
         socialLinkClicksByPlatform: socialLinkClicksByPlatform,
         projectClicksByProject: projectClicksByProject,
         dailyProfileViews: dailyProfileViews,
         dailyTotalEvents: dailyTotalEvents,
       );

  /// Returns a shallow copy of this [AnalyticsSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AnalyticsSummary copyWith({
    int? totalProfileViews,
    int? totalSocialLinkClicks,
    int? totalProjectClicks,
    int? totalCvViews,
    int? totalProfileShares,
    Object? totalProfileLinkCopies = _Undefined,
    int? totalQrProfileViews,
    Object? totalQrDownloads = _Undefined,
    int? totalEvents,
    List<_irqil8bx.NamedCount>? socialLinkClicksByPlatform,
    List<_irqil8bx.NamedCount>? projectClicksByProject,
    List<_i9xdz41h.DailyEventCount>? dailyProfileViews,
    List<_i9xdz41h.DailyEventCount>? dailyTotalEvents,
  }) {
    return AnalyticsSummary(
      totalProfileViews: totalProfileViews ?? this.totalProfileViews,
      totalSocialLinkClicks:
          totalSocialLinkClicks ?? this.totalSocialLinkClicks,
      totalProjectClicks: totalProjectClicks ?? this.totalProjectClicks,
      totalCvViews: totalCvViews ?? this.totalCvViews,
      totalProfileShares: totalProfileShares ?? this.totalProfileShares,
      totalProfileLinkCopies: totalProfileLinkCopies is int?
          ? totalProfileLinkCopies
          : this.totalProfileLinkCopies,
      totalQrProfileViews: totalQrProfileViews ?? this.totalQrProfileViews,
      totalQrDownloads: totalQrDownloads is int?
          ? totalQrDownloads
          : this.totalQrDownloads,
      totalEvents: totalEvents ?? this.totalEvents,
      socialLinkClicksByPlatform:
          socialLinkClicksByPlatform ??
          this.socialLinkClicksByPlatform.map((e0) => e0.copyWith()).toList(),
      projectClicksByProject:
          projectClicksByProject ??
          this.projectClicksByProject.map((e0) => e0.copyWith()).toList(),
      dailyProfileViews:
          dailyProfileViews ??
          this.dailyProfileViews.map((e0) => e0.copyWith()).toList(),
      dailyTotalEvents:
          dailyTotalEvents ??
          this.dailyTotalEvents.map((e0) => e0.copyWith()).toList(),
    );
  }
}
