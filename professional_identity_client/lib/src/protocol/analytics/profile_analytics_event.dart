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
import 'package:professional_identity_client/src/protocol/protocol.dart'
    as _ixcjy4bn;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../profile/profile.dart' as _i1157qfm;

abstract class ProfileAnalyticsEvent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ProfileAnalyticsEvent._({
    this.id,
    required this.profileId,
    this.profile,
    required this.eventType,
    this.target,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ProfileAnalyticsEvent({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    required String eventType,
    String? target,
    DateTime? createdAt,
  }) = _ProfileAnalyticsEventImpl;

  factory ProfileAnalyticsEvent.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ProfileAnalyticsEvent(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      profile: jsonSerialization['profile'] == null
          ? null
          : _ixcjy4bn.Protocol().deserialize<_i1157qfm.Profile>(
              jsonSerialization['profile'],
            ),
      eventType: jsonSerialization['eventType'] as String,
      target: jsonSerialization['target'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int profileId;

  _i1157qfm.Profile? profile;

  String eventType;

  String? target;

  DateTime createdAt;

  /// Returns a shallow copy of this [ProfileAnalyticsEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ProfileAnalyticsEvent copyWith({
    int? id,
    int? profileId,
    _i1157qfm.Profile? profile,
    String? eventType,
    String? target,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProfileAnalyticsEvent',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJson(),
      'eventType': eventType,
      if (target != null) 'target': target,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProfileAnalyticsEvent',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJsonForProtocol(),
      'eventType': eventType,
      if (target != null) 'target': target,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProfileAnalyticsEventImpl extends ProfileAnalyticsEvent {
  _ProfileAnalyticsEventImpl({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    required String eventType,
    String? target,
    DateTime? createdAt,
  }) : super._(
         id: id,
         profileId: profileId,
         profile: profile,
         eventType: eventType,
         target: target,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ProfileAnalyticsEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ProfileAnalyticsEvent copyWith({
    Object? id = _Undefined,
    int? profileId,
    Object? profile = _Undefined,
    String? eventType,
    Object? target = _Undefined,
    DateTime? createdAt,
  }) {
    return ProfileAnalyticsEvent(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      profile: profile is _i1157qfm.Profile?
          ? profile
          : this.profile?.copyWith(),
      eventType: eventType ?? this.eventType,
      target: target is String? ? target : this.target,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
