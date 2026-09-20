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

abstract class Experience
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Experience._({
    this.id,
    required this.profileId,
    this.profile,
    required this.company,
    required this.jobTitle,
    required this.startDate,
    this.endDate,
    bool? isCurrent,
    this.description,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isCurrent = isCurrent ?? false,
       sortOrder = sortOrder ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Experience({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    required String company,
    required String jobTitle,
    required DateTime startDate,
    DateTime? endDate,
    bool? isCurrent,
    String? description,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ExperienceImpl;

  factory Experience.fromJson(Map<String, dynamic> jsonSerialization) {
    return Experience(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      profile: jsonSerialization['profile'] == null
          ? null
          : _ixcjy4bn.Protocol().deserialize<_i1157qfm.Profile>(
              jsonSerialization['profile'],
            ),
      company: jsonSerialization['company'] as String,
      jobTitle: jsonSerialization['jobTitle'] as String,
      startDate: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startDate'],
      ),
      endDate: jsonSerialization['endDate'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['endDate']),
      isCurrent: jsonSerialization['isCurrent'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isCurrent']),
      description: jsonSerialization['description'] as String?,
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

  String company;

  String jobTitle;

  DateTime startDate;

  DateTime? endDate;

  bool isCurrent;

  String? description;

  int sortOrder;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Experience]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Experience copyWith({
    int? id,
    int? profileId,
    _i1157qfm.Profile? profile,
    String? company,
    String? jobTitle,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrent,
    String? description,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Experience',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJson(),
      'company': company,
      'jobTitle': jobTitle,
      'startDate': startDate.toJson(),
      if (endDate != null) 'endDate': endDate?.toJson(),
      'isCurrent': isCurrent,
      if (description != null) 'description': description,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Experience',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJsonForProtocol(),
      'company': company,
      'jobTitle': jobTitle,
      'startDate': startDate.toJson(),
      if (endDate != null) 'endDate': endDate?.toJson(),
      'isCurrent': isCurrent,
      if (description != null) 'description': description,
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

class _ExperienceImpl extends Experience {
  _ExperienceImpl({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    required String company,
    required String jobTitle,
    required DateTime startDate,
    DateTime? endDate,
    bool? isCurrent,
    String? description,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         profileId: profileId,
         profile: profile,
         company: company,
         jobTitle: jobTitle,
         startDate: startDate,
         endDate: endDate,
         isCurrent: isCurrent,
         description: description,
         sortOrder: sortOrder,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Experience]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Experience copyWith({
    Object? id = _Undefined,
    int? profileId,
    Object? profile = _Undefined,
    String? company,
    String? jobTitle,
    DateTime? startDate,
    Object? endDate = _Undefined,
    bool? isCurrent,
    Object? description = _Undefined,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Experience(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      profile: profile is _i1157qfm.Profile?
          ? profile
          : this.profile?.copyWith(),
      company: company ?? this.company,
      jobTitle: jobTitle ?? this.jobTitle,
      startDate: startDate ?? this.startDate,
      endDate: endDate is DateTime? ? endDate : this.endDate,
      isCurrent: isCurrent ?? this.isCurrent,
      description: description is String? ? description : this.description,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
