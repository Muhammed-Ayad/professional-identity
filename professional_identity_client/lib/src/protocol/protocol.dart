/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:professional_identity_client/src/protocol/experience/experience.dart'
    as _i0rtawz4;
import 'package:professional_identity_client/src/protocol/inquiries/contact_inquiry.dart'
    as _iad825pn;
import 'package:professional_identity_client/src/protocol/projects/project.dart'
    as _ic408x76;
import 'package:professional_identity_client/src/protocol/skills/skill.dart'
    as _ipfnldx6;
import 'package:professional_identity_client/src/protocol/social_links/social_link.dart'
    as _isssluk7;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'analytics/models/analytics_summary.dart' as _ihm7rcgc;
import 'analytics/models/daily_event_count.dart' as _i2vw0ih0;
import 'analytics/models/named_count.dart' as _ipp20j8q;
import 'analytics/profile_analytics_event.dart' as _ibjn8qpg;
import 'experience/experience.dart' as _i661566d;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'inquiries/contact_inquiry.dart' as _ituin5sw;
import 'profile/profile.dart' as _ia5j8fch;
import 'profile/profile_exception.dart' as _ie17qpis;
import 'profile/public_profile_data.dart' as _ipjvis7p;
import 'profile_customization/profile_customization.dart' as _ix5rnw4z;
import 'projects/project.dart' as _il77500d;
import 'skills/skill.dart' as _i0n1ukfr;
import 'social_links/social_link.dart' as _incvimk7;
export 'analytics/models/analytics_summary.dart';
export 'analytics/models/daily_event_count.dart';
export 'analytics/models/named_count.dart';
export 'analytics/profile_analytics_event.dart';
export 'experience/experience.dart';
export 'greetings/greeting.dart';
export 'inquiries/contact_inquiry.dart';
export 'profile/profile.dart';
export 'profile/profile_exception.dart';
export 'profile/public_profile_data.dart';
export 'profile_customization/profile_customization.dart';
export 'projects/project.dart';
export 'skills/skill.dart';
export 'social_links/social_link.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _ihm7rcgc.AnalyticsSummary) {
      return _ihm7rcgc.AnalyticsSummary.fromJson(data) as T;
    }
    if (t == _i2vw0ih0.DailyEventCount) {
      return _i2vw0ih0.DailyEventCount.fromJson(data) as T;
    }
    if (t == _ipp20j8q.NamedCount) {
      return _ipp20j8q.NamedCount.fromJson(data) as T;
    }
    if (t == _ibjn8qpg.ProfileAnalyticsEvent) {
      return _ibjn8qpg.ProfileAnalyticsEvent.fromJson(data) as T;
    }
    if (t == _i661566d.Experience) {
      return _i661566d.Experience.fromJson(data) as T;
    }
    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _ituin5sw.ContactInquiry) {
      return _ituin5sw.ContactInquiry.fromJson(data) as T;
    }
    if (t == _ia5j8fch.Profile) {
      return _ia5j8fch.Profile.fromJson(data) as T;
    }
    if (t == _ie17qpis.ProfileException) {
      return _ie17qpis.ProfileException.fromJson(data) as T;
    }
    if (t == _ipjvis7p.PublicProfileData) {
      return _ipjvis7p.PublicProfileData.fromJson(data) as T;
    }
    if (t == _ix5rnw4z.ProfileCustomization) {
      return _ix5rnw4z.ProfileCustomization.fromJson(data) as T;
    }
    if (t == _il77500d.Project) {
      return _il77500d.Project.fromJson(data) as T;
    }
    if (t == _i0n1ukfr.Skill) {
      return _i0n1ukfr.Skill.fromJson(data) as T;
    }
    if (t == _incvimk7.SocialLink) {
      return _incvimk7.SocialLink.fromJson(data) as T;
    }
    if (t == _isc.getType<_ihm7rcgc.AnalyticsSummary?>()) {
      return (data != null ? _ihm7rcgc.AnalyticsSummary.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i2vw0ih0.DailyEventCount?>()) {
      return (data != null ? _i2vw0ih0.DailyEventCount.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ipp20j8q.NamedCount?>()) {
      return (data != null ? _ipp20j8q.NamedCount.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ibjn8qpg.ProfileAnalyticsEvent?>()) {
      return (data != null
              ? _ibjn8qpg.ProfileAnalyticsEvent.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i661566d.Experience?>()) {
      return (data != null ? _i661566d.Experience.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ituin5sw.ContactInquiry?>()) {
      return (data != null ? _ituin5sw.ContactInquiry.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ia5j8fch.Profile?>()) {
      return (data != null ? _ia5j8fch.Profile.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ie17qpis.ProfileException?>()) {
      return (data != null ? _ie17qpis.ProfileException.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ipjvis7p.PublicProfileData?>()) {
      return (data != null ? _ipjvis7p.PublicProfileData.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ix5rnw4z.ProfileCustomization?>()) {
      return (data != null
              ? _ix5rnw4z.ProfileCustomization.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_il77500d.Project?>()) {
      return (data != null ? _il77500d.Project.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i0n1ukfr.Skill?>()) {
      return (data != null ? _i0n1ukfr.Skill.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_incvimk7.SocialLink?>()) {
      return (data != null ? _incvimk7.SocialLink.fromJson(data) : null) as T;
    }
    if (t == List<_ipp20j8q.NamedCount>) {
      return (data as List)
              .map((e) => deserialize<_ipp20j8q.NamedCount>(e))
              .toList()
          as T;
    }
    if (t == List<_i2vw0ih0.DailyEventCount>) {
      return (data as List)
              .map((e) => deserialize<_i2vw0ih0.DailyEventCount>(e))
              .toList()
          as T;
    }
    if (t == List<_i0n1ukfr.Skill>) {
      return (data as List).map((e) => deserialize<_i0n1ukfr.Skill>(e)).toList()
          as T;
    }
    if (t == List<_i661566d.Experience>) {
      return (data as List)
              .map((e) => deserialize<_i661566d.Experience>(e))
              .toList()
          as T;
    }
    if (t == List<_il77500d.Project>) {
      return (data as List)
              .map((e) => deserialize<_il77500d.Project>(e))
              .toList()
          as T;
    }
    if (t == List<_incvimk7.SocialLink>) {
      return (data as List)
              .map((e) => deserialize<_incvimk7.SocialLink>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i0rtawz4.Experience>) {
      return (data as List)
              .map((e) => deserialize<_i0rtawz4.Experience>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_iad825pn.ContactInquiry>) {
      return (data as List)
              .map((e) => deserialize<_iad825pn.ContactInquiry>(e))
              .toList()
          as T;
    }
    if (t == List<_ic408x76.Project>) {
      return (data as List)
              .map((e) => deserialize<_ic408x76.Project>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_ipfnldx6.Skill>) {
      return (data as List).map((e) => deserialize<_ipfnldx6.Skill>(e)).toList()
          as T;
    }
    if (t == List<_isssluk7.SocialLink>) {
      return (data as List)
              .map((e) => deserialize<_isssluk7.SocialLink>(e))
              .toList()
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _ihm7rcgc.AnalyticsSummary => 'AnalyticsSummary',
      _i2vw0ih0.DailyEventCount => 'DailyEventCount',
      _ipp20j8q.NamedCount => 'NamedCount',
      _ibjn8qpg.ProfileAnalyticsEvent => 'ProfileAnalyticsEvent',
      _i661566d.Experience => 'Experience',
      _izw8z7ou.Greeting => 'Greeting',
      _ituin5sw.ContactInquiry => 'ContactInquiry',
      _ia5j8fch.Profile => 'Profile',
      _ie17qpis.ProfileException => 'ProfileException',
      _ipjvis7p.PublicProfileData => 'PublicProfileData',
      _ix5rnw4z.ProfileCustomization => 'ProfileCustomization',
      _il77500d.Project => 'Project',
      _i0n1ukfr.Skill => 'Skill',
      _incvimk7.SocialLink => 'SocialLink',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst(
        'professional_identity.',
        '',
      );
    }

    switch (data) {
      case _ihm7rcgc.AnalyticsSummary():
        return 'AnalyticsSummary';
      case _i2vw0ih0.DailyEventCount():
        return 'DailyEventCount';
      case _ipp20j8q.NamedCount():
        return 'NamedCount';
      case _ibjn8qpg.ProfileAnalyticsEvent():
        return 'ProfileAnalyticsEvent';
      case _i661566d.Experience():
        return 'Experience';
      case _izw8z7ou.Greeting():
        return 'Greeting';
      case _ituin5sw.ContactInquiry():
        return 'ContactInquiry';
      case _ia5j8fch.Profile():
        return 'Profile';
      case _ie17qpis.ProfileException():
        return 'ProfileException';
      case _ipjvis7p.PublicProfileData():
        return 'PublicProfileData';
      case _ix5rnw4z.ProfileCustomization():
        return 'ProfileCustomization';
      case _il77500d.Project():
        return 'Project';
      case _i0n1ukfr.Skill():
        return 'Skill';
      case _incvimk7.SocialLink():
        return 'SocialLink';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AnalyticsSummary') {
      return deserialize<_ihm7rcgc.AnalyticsSummary>(data['data']);
    }
    if (dataClassName == 'DailyEventCount') {
      return deserialize<_i2vw0ih0.DailyEventCount>(data['data']);
    }
    if (dataClassName == 'NamedCount') {
      return deserialize<_ipp20j8q.NamedCount>(data['data']);
    }
    if (dataClassName == 'ProfileAnalyticsEvent') {
      return deserialize<_ibjn8qpg.ProfileAnalyticsEvent>(data['data']);
    }
    if (dataClassName == 'Experience') {
      return deserialize<_i661566d.Experience>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName == 'ContactInquiry') {
      return deserialize<_ituin5sw.ContactInquiry>(data['data']);
    }
    if (dataClassName == 'Profile') {
      return deserialize<_ia5j8fch.Profile>(data['data']);
    }
    if (dataClassName == 'ProfileException') {
      return deserialize<_ie17qpis.ProfileException>(data['data']);
    }
    if (dataClassName == 'PublicProfileData') {
      return deserialize<_ipjvis7p.PublicProfileData>(data['data']);
    }
    if (dataClassName == 'ProfileCustomization') {
      return deserialize<_ix5rnw4z.ProfileCustomization>(data['data']);
    }
    if (dataClassName == 'Project') {
      return deserialize<_il77500d.Project>(data['data']);
    }
    if (dataClassName == 'Skill') {
      return deserialize<_i0n1ukfr.Skill>(data['data']);
    }
    if (dataClassName == 'SocialLink') {
      return deserialize<_incvimk7.SocialLink>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('professional_identity', this);
    _iacc.Protocol().registerHostProtocol('professional_identity', this);
  }

  @override
  String getModuleName() => 'professional_identity';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
