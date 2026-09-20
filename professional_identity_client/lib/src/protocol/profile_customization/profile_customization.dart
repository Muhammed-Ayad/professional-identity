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

abstract class ProfileCustomization
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ProfileCustomization._({
    this.id,
    required this.profileId,
    this.profile,
    String? themePreset,
    this.primaryColor,
    String? backgroundStyle,
    String? cardStyle,
    String? borderRadius,
    String? typographyStyle,
    DateTime? updatedAt,
  }) : themePreset = themePreset ?? 'minimal',
       backgroundStyle = backgroundStyle ?? 'solid',
       cardStyle = cardStyle ?? 'outlined',
       borderRadius = borderRadius ?? 'medium',
       typographyStyle = typographyStyle ?? 'modern',
       updatedAt = updatedAt ?? DateTime.now();

  factory ProfileCustomization({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    String? themePreset,
    String? primaryColor,
    String? backgroundStyle,
    String? cardStyle,
    String? borderRadius,
    String? typographyStyle,
    DateTime? updatedAt,
  }) = _ProfileCustomizationImpl;

  factory ProfileCustomization.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ProfileCustomization(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      profile: jsonSerialization['profile'] == null
          ? null
          : _ixcjy4bn.Protocol().deserialize<_i1157qfm.Profile>(
              jsonSerialization['profile'],
            ),
      themePreset: jsonSerialization['themePreset'] as String?,
      primaryColor: jsonSerialization['primaryColor'] as String?,
      backgroundStyle: jsonSerialization['backgroundStyle'] as String?,
      cardStyle: jsonSerialization['cardStyle'] as String?,
      borderRadius: jsonSerialization['borderRadius'] as String?,
      typographyStyle: jsonSerialization['typographyStyle'] as String?,
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

  String themePreset;

  String? primaryColor;

  String backgroundStyle;

  String cardStyle;

  String borderRadius;

  String typographyStyle;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ProfileCustomization]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ProfileCustomization copyWith({
    int? id,
    int? profileId,
    _i1157qfm.Profile? profile,
    String? themePreset,
    String? primaryColor,
    String? backgroundStyle,
    String? cardStyle,
    String? borderRadius,
    String? typographyStyle,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProfileCustomization',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJson(),
      'themePreset': themePreset,
      if (primaryColor != null) 'primaryColor': primaryColor,
      'backgroundStyle': backgroundStyle,
      'cardStyle': cardStyle,
      'borderRadius': borderRadius,
      'typographyStyle': typographyStyle,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProfileCustomization',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJsonForProtocol(),
      'themePreset': themePreset,
      if (primaryColor != null) 'primaryColor': primaryColor,
      'backgroundStyle': backgroundStyle,
      'cardStyle': cardStyle,
      'borderRadius': borderRadius,
      'typographyStyle': typographyStyle,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProfileCustomizationImpl extends ProfileCustomization {
  _ProfileCustomizationImpl({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    String? themePreset,
    String? primaryColor,
    String? backgroundStyle,
    String? cardStyle,
    String? borderRadius,
    String? typographyStyle,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         profileId: profileId,
         profile: profile,
         themePreset: themePreset,
         primaryColor: primaryColor,
         backgroundStyle: backgroundStyle,
         cardStyle: cardStyle,
         borderRadius: borderRadius,
         typographyStyle: typographyStyle,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ProfileCustomization]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ProfileCustomization copyWith({
    Object? id = _Undefined,
    int? profileId,
    Object? profile = _Undefined,
    String? themePreset,
    Object? primaryColor = _Undefined,
    String? backgroundStyle,
    String? cardStyle,
    String? borderRadius,
    String? typographyStyle,
    DateTime? updatedAt,
  }) {
    return ProfileCustomization(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      profile: profile is _i1157qfm.Profile?
          ? profile
          : this.profile?.copyWith(),
      themePreset: themePreset ?? this.themePreset,
      primaryColor: primaryColor is String? ? primaryColor : this.primaryColor,
      backgroundStyle: backgroundStyle ?? this.backgroundStyle,
      cardStyle: cardStyle ?? this.cardStyle,
      borderRadius: borderRadius ?? this.borderRadius,
      typographyStyle: typographyStyle ?? this.typographyStyle,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
