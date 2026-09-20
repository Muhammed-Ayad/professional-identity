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

abstract class SocialLink
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SocialLink._({
    this.id,
    required this.profileId,
    this.profile,
    required this.platform,
    required this.url,
    this.label,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : sortOrder = sortOrder ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory SocialLink({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    required String platform,
    required String url,
    String? label,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SocialLinkImpl;

  factory SocialLink.fromJson(Map<String, dynamic> jsonSerialization) {
    return SocialLink(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      profile: jsonSerialization['profile'] == null
          ? null
          : _ixcjy4bn.Protocol().deserialize<_i1157qfm.Profile>(
              jsonSerialization['profile'],
            ),
      platform: jsonSerialization['platform'] as String,
      url: jsonSerialization['url'] as String,
      label: jsonSerialization['label'] as String?,
      sortOrder: jsonSerialization['sortOrder'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int profileId;

  _i1157qfm.Profile? profile;

  String platform;

  String url;

  String? label;

  int sortOrder;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [SocialLink]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SocialLink copyWith({
    int? id,
    int? profileId,
    _i1157qfm.Profile? profile,
    String? platform,
    String? url,
    String? label,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SocialLink',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJson(),
      'platform': platform,
      'url': url,
      if (label != null) 'label': label,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SocialLink',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJsonForProtocol(),
      'platform': platform,
      'url': url,
      if (label != null) 'label': label,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SocialLinkImpl extends SocialLink {
  _SocialLinkImpl({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    required String platform,
    required String url,
    String? label,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         profileId: profileId,
         profile: profile,
         platform: platform,
         url: url,
         label: label,
         sortOrder: sortOrder,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SocialLink]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SocialLink copyWith({
    Object? id = _Undefined,
    int? profileId,
    Object? profile = _Undefined,
    String? platform,
    String? url,
    Object? label = _Undefined,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SocialLink(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      profile: profile is _i1157qfm.Profile?
          ? profile
          : this.profile?.copyWith(),
      platform: platform ?? this.platform,
      url: url ?? this.url,
      label: label is String? ? label : this.label,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
