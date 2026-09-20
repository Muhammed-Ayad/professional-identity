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

abstract class Project
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Project._({
    this.id,
    required this.profileId,
    this.profile,
    required this.title,
    this.description,
    this.role,
    this.url,
    this.repositoryUrl,
    this.imageUrl,
    required this.technologies,
    this.startDate,
    this.endDate,
    bool? isOngoing,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isOngoing = isOngoing ?? false,
       sortOrder = sortOrder ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Project({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    required String title,
    String? description,
    String? role,
    String? url,
    String? repositoryUrl,
    String? imageUrl,
    required List<String> technologies,
    DateTime? startDate,
    DateTime? endDate,
    bool? isOngoing,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ProjectImpl;

  factory Project.fromJson(Map<String, dynamic> jsonSerialization) {
    return Project(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      profile: jsonSerialization['profile'] == null
          ? null
          : _ixcjy4bn.Protocol().deserialize<_i1157qfm.Profile>(
              jsonSerialization['profile'],
            ),
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      role: jsonSerialization['role'] as String?,
      url: jsonSerialization['url'] as String?,
      repositoryUrl: jsonSerialization['repositoryUrl'] as String?,
      imageUrl: jsonSerialization['imageUrl'] as String?,
      technologies: _ixcjy4bn.Protocol().deserialize<List<String>>(
        jsonSerialization['technologies'],
      ),
      startDate: jsonSerialization['startDate'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['startDate']),
      endDate: jsonSerialization['endDate'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['endDate']),
      isOngoing: jsonSerialization['isOngoing'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isOngoing']),
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

  String title;

  String? description;

  String? role;

  String? url;

  String? repositoryUrl;

  String? imageUrl;

  List<String> technologies;

  DateTime? startDate;

  DateTime? endDate;

  bool isOngoing;

  int sortOrder;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Project]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Project copyWith({
    int? id,
    int? profileId,
    _i1157qfm.Profile? profile,
    String? title,
    String? description,
    String? role,
    String? url,
    String? repositoryUrl,
    String? imageUrl,
    List<String>? technologies,
    DateTime? startDate,
    DateTime? endDate,
    bool? isOngoing,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Project',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJson(),
      'title': title,
      if (description != null) 'description': description,
      if (role != null) 'role': role,
      if (url != null) 'url': url,
      if (repositoryUrl != null) 'repositoryUrl': repositoryUrl,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'technologies': technologies.toJson(),
      if (startDate != null) 'startDate': startDate?.toJson(),
      if (endDate != null) 'endDate': endDate?.toJson(),
      'isOngoing': isOngoing,
      'sortOrder': sortOrder,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Project',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJsonForProtocol(),
      'title': title,
      if (description != null) 'description': description,
      if (role != null) 'role': role,
      if (url != null) 'url': url,
      if (repositoryUrl != null) 'repositoryUrl': repositoryUrl,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'technologies': technologies.toJson(),
      if (startDate != null) 'startDate': startDate?.toJson(),
      if (endDate != null) 'endDate': endDate?.toJson(),
      'isOngoing': isOngoing,
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

class _ProjectImpl extends Project {
  _ProjectImpl({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    required String title,
    String? description,
    String? role,
    String? url,
    String? repositoryUrl,
    String? imageUrl,
    required List<String> technologies,
    DateTime? startDate,
    DateTime? endDate,
    bool? isOngoing,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         profileId: profileId,
         profile: profile,
         title: title,
         description: description,
         role: role,
         url: url,
         repositoryUrl: repositoryUrl,
         imageUrl: imageUrl,
         technologies: technologies,
         startDate: startDate,
         endDate: endDate,
         isOngoing: isOngoing,
         sortOrder: sortOrder,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Project]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Project copyWith({
    Object? id = _Undefined,
    int? profileId,
    Object? profile = _Undefined,
    String? title,
    Object? description = _Undefined,
    Object? role = _Undefined,
    Object? url = _Undefined,
    Object? repositoryUrl = _Undefined,
    Object? imageUrl = _Undefined,
    List<String>? technologies,
    Object? startDate = _Undefined,
    Object? endDate = _Undefined,
    bool? isOngoing,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Project(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      profile: profile is _i1157qfm.Profile?
          ? profile
          : this.profile?.copyWith(),
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      role: role is String? ? role : this.role,
      url: url is String? ? url : this.url,
      repositoryUrl: repositoryUrl is String?
          ? repositoryUrl
          : this.repositoryUrl,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      technologies: technologies ?? this.technologies.map((e0) => e0).toList(),
      startDate: startDate is DateTime? ? startDate : this.startDate,
      endDate: endDate is DateTime? ? endDate : this.endDate,
      isOngoing: isOngoing ?? this.isOngoing,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
