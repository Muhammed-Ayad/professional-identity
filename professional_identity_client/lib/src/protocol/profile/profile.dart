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
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class Profile
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Profile._({
    this.id,
    required this.authUserId,
    this.authUser,
    required this.handle,
    required this.fullName,
    this.headline,
    this.bio,
    this.location,
    this.currentRole,
    this.yearsOfExperience,
    this.availability,
    this.contactEmail,
    this.websiteUrl,
    this.avatarUrl,
    this.cvUrl,
    bool? isPublic,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isPublic = isPublic ?? true,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Profile({
    int? id,
    required _isc.UuidValue authUserId,
    _iacc.AuthUser? authUser,
    required String handle,
    required String fullName,
    String? headline,
    String? bio,
    String? location,
    String? currentRole,
    int? yearsOfExperience,
    String? availability,
    String? contactEmail,
    String? websiteUrl,
    String? avatarUrl,
    String? cvUrl,
    bool? isPublic,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ProfileImpl;

  factory Profile.fromJson(Map<String, dynamic> jsonSerialization) {
    return Profile(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _ixcjy4bn.Protocol().deserialize<_iacc.AuthUser>(
              jsonSerialization['authUser'],
            ),
      handle: jsonSerialization['handle'] as String,
      fullName: jsonSerialization['fullName'] as String,
      headline: jsonSerialization['headline'] as String?,
      bio: jsonSerialization['bio'] as String?,
      location: jsonSerialization['location'] as String?,
      currentRole: jsonSerialization['currentRole'] as String?,
      yearsOfExperience: jsonSerialization['yearsOfExperience'] as int?,
      availability: jsonSerialization['availability'] as String?,
      contactEmail: jsonSerialization['contactEmail'] as String?,
      websiteUrl: jsonSerialization['websiteUrl'] as String?,
      avatarUrl: jsonSerialization['avatarUrl'] as String?,
      cvUrl: jsonSerialization['cvUrl'] as String?,
      isPublic: jsonSerialization['isPublic'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isPublic']),
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

  _isc.UuidValue authUserId;

  _iacc.AuthUser? authUser;

  String handle;

  String fullName;

  String? headline;

  String? bio;

  String? location;

  String? currentRole;

  int? yearsOfExperience;

  String? availability;

  String? contactEmail;

  String? websiteUrl;

  String? avatarUrl;

  String? cvUrl;

  bool isPublic;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Profile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Profile copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    _iacc.AuthUser? authUser,
    String? handle,
    String? fullName,
    String? headline,
    String? bio,
    String? location,
    String? currentRole,
    int? yearsOfExperience,
    String? availability,
    String? contactEmail,
    String? websiteUrl,
    String? avatarUrl,
    String? cvUrl,
    bool? isPublic,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Profile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'handle': handle,
      'fullName': fullName,
      if (headline != null) 'headline': headline,
      if (bio != null) 'bio': bio,
      if (location != null) 'location': location,
      if (currentRole != null) 'currentRole': currentRole,
      if (yearsOfExperience != null) 'yearsOfExperience': yearsOfExperience,
      if (availability != null) 'availability': availability,
      if (contactEmail != null) 'contactEmail': contactEmail,
      if (websiteUrl != null) 'websiteUrl': websiteUrl,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      if (cvUrl != null) 'cvUrl': cvUrl,
      'isPublic': isPublic,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Profile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'handle': handle,
      'fullName': fullName,
      if (headline != null) 'headline': headline,
      if (bio != null) 'bio': bio,
      if (location != null) 'location': location,
      if (currentRole != null) 'currentRole': currentRole,
      if (yearsOfExperience != null) 'yearsOfExperience': yearsOfExperience,
      if (availability != null) 'availability': availability,
      if (contactEmail != null) 'contactEmail': contactEmail,
      if (websiteUrl != null) 'websiteUrl': websiteUrl,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      if (cvUrl != null) 'cvUrl': cvUrl,
      'isPublic': isPublic,
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

class _ProfileImpl extends Profile {
  _ProfileImpl({
    int? id,
    required _isc.UuidValue authUserId,
    _iacc.AuthUser? authUser,
    required String handle,
    required String fullName,
    String? headline,
    String? bio,
    String? location,
    String? currentRole,
    int? yearsOfExperience,
    String? availability,
    String? contactEmail,
    String? websiteUrl,
    String? avatarUrl,
    String? cvUrl,
    bool? isPublic,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         handle: handle,
         fullName: fullName,
         headline: headline,
         bio: bio,
         location: location,
         currentRole: currentRole,
         yearsOfExperience: yearsOfExperience,
         availability: availability,
         contactEmail: contactEmail,
         websiteUrl: websiteUrl,
         avatarUrl: avatarUrl,
         cvUrl: cvUrl,
         isPublic: isPublic,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Profile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Profile copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    Object? authUser = _Undefined,
    String? handle,
    String? fullName,
    Object? headline = _Undefined,
    Object? bio = _Undefined,
    Object? location = _Undefined,
    Object? currentRole = _Undefined,
    Object? yearsOfExperience = _Undefined,
    Object? availability = _Undefined,
    Object? contactEmail = _Undefined,
    Object? websiteUrl = _Undefined,
    Object? avatarUrl = _Undefined,
    Object? cvUrl = _Undefined,
    bool? isPublic,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Profile(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _iacc.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      handle: handle ?? this.handle,
      fullName: fullName ?? this.fullName,
      headline: headline is String? ? headline : this.headline,
      bio: bio is String? ? bio : this.bio,
      location: location is String? ? location : this.location,
      currentRole: currentRole is String? ? currentRole : this.currentRole,
      yearsOfExperience: yearsOfExperience is int?
          ? yearsOfExperience
          : this.yearsOfExperience,
      availability: availability is String? ? availability : this.availability,
      contactEmail: contactEmail is String? ? contactEmail : this.contactEmail,
      websiteUrl: websiteUrl is String? ? websiteUrl : this.websiteUrl,
      avatarUrl: avatarUrl is String? ? avatarUrl : this.avatarUrl,
      cvUrl: cvUrl is String? ? cvUrl : this.cvUrl,
      isPublic: isPublic ?? this.isPublic,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
