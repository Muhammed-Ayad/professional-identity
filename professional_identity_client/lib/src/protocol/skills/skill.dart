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

abstract class Skill
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Skill._({
    this.id,
    required this.profileId,
    this.profile,
    required this.name,
    this.category,
    this.yearsOfExperience,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : sortOrder = sortOrder ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Skill({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    required String name,
    String? category,
    int? yearsOfExperience,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SkillImpl;

  factory Skill.fromJson(Map<String, dynamic> jsonSerialization) {
    return Skill(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      profile: jsonSerialization['profile'] == null
          ? null
          : _ixcjy4bn.Protocol().deserialize<_i1157qfm.Profile>(
              jsonSerialization['profile'],
            ),
      name: jsonSerialization['name'] as String,
      category: jsonSerialization['category'] as String?,
      yearsOfExperience: jsonSerialization['yearsOfExperience'] as int?,
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

  String name;

  String? category;

  int? yearsOfExperience;

  int sortOrder;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Skill]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Skill copyWith({
    int? id,
    int? profileId,
    _i1157qfm.Profile? profile,
    String? name,
    String? category,
    int? yearsOfExperience,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Skill',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJson(),
      'name': name,
      if (category != null) 'category': category,
      if (yearsOfExperience != null) 'yearsOfExperience': yearsOfExperience,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Skill',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJsonForProtocol(),
      'name': name,
      if (category != null) 'category': category,
      if (yearsOfExperience != null) 'yearsOfExperience': yearsOfExperience,
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

class _SkillImpl extends Skill {
  _SkillImpl({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    required String name,
    String? category,
    int? yearsOfExperience,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         profileId: profileId,
         profile: profile,
         name: name,
         category: category,
         yearsOfExperience: yearsOfExperience,
         sortOrder: sortOrder,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Skill]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Skill copyWith({
    Object? id = _Undefined,
    int? profileId,
    Object? profile = _Undefined,
    String? name,
    Object? category = _Undefined,
    Object? yearsOfExperience = _Undefined,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Skill(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      profile: profile is _i1157qfm.Profile?
          ? profile
          : this.profile?.copyWith(),
      name: name ?? this.name,
      category: category is String? ? category : this.category,
      yearsOfExperience: yearsOfExperience is int?
          ? yearsOfExperience
          : this.yearsOfExperience,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
