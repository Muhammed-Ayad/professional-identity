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
import '../experience/experience.dart' as _iot70o80;
import '../profile_customization/profile_customization.dart' as _i807syeh;
import '../projects/project.dart' as _ivtjr8tj;
import '../skills/skill.dart' as _iyfor54a;
import '../social_links/social_link.dart' as _i3diedg0;

abstract class PublicProfileData
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PublicProfileData._({
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
    required this.isPublic,
    required this.skills,
    required this.experiences,
    required this.projects,
    required this.socialLinks,
    this.customization,
  });

  factory PublicProfileData({
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
    required bool isPublic,
    required List<_iyfor54a.Skill> skills,
    required List<_iot70o80.Experience> experiences,
    required List<_ivtjr8tj.Project> projects,
    required List<_i3diedg0.SocialLink> socialLinks,
    _i807syeh.ProfileCustomization? customization,
  }) = _PublicProfileDataImpl;

  factory PublicProfileData.fromJson(Map<String, dynamic> jsonSerialization) {
    return PublicProfileData(
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
      isPublic: _is.BoolJsonExtension.fromJson(jsonSerialization['isPublic']),
      skills: _idwwx28q.Protocol().deserialize<List<_iyfor54a.Skill>>(
        jsonSerialization['skills'],
      ),
      experiences: _idwwx28q.Protocol().deserialize<List<_iot70o80.Experience>>(
        jsonSerialization['experiences'],
      ),
      projects: _idwwx28q.Protocol().deserialize<List<_ivtjr8tj.Project>>(
        jsonSerialization['projects'],
      ),
      socialLinks: _idwwx28q.Protocol().deserialize<List<_i3diedg0.SocialLink>>(
        jsonSerialization['socialLinks'],
      ),
      customization: jsonSerialization['customization'] == null
          ? null
          : _idwwx28q.Protocol().deserialize<_i807syeh.ProfileCustomization>(
              jsonSerialization['customization'],
            ),
    );
  }

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

  List<_iyfor54a.Skill> skills;

  List<_iot70o80.Experience> experiences;

  List<_ivtjr8tj.Project> projects;

  List<_i3diedg0.SocialLink> socialLinks;

  _i807syeh.ProfileCustomization? customization;

  /// Returns a shallow copy of this [PublicProfileData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PublicProfileData copyWith({
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
    List<_iyfor54a.Skill>? skills,
    List<_iot70o80.Experience>? experiences,
    List<_ivtjr8tj.Project>? projects,
    List<_i3diedg0.SocialLink>? socialLinks,
    _i807syeh.ProfileCustomization? customization,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PublicProfileData',
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
      'skills': skills.toJson(valueToJson: (v) => v.toJson()),
      'experiences': experiences.toJson(valueToJson: (v) => v.toJson()),
      'projects': projects.toJson(valueToJson: (v) => v.toJson()),
      'socialLinks': socialLinks.toJson(valueToJson: (v) => v.toJson()),
      if (customization != null) 'customization': customization?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PublicProfileData',
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
      'skills': skills.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'experiences': experiences.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'projects': projects.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'socialLinks': socialLinks.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      if (customization != null)
        'customization': customization?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PublicProfileDataImpl extends PublicProfileData {
  _PublicProfileDataImpl({
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
    required bool isPublic,
    required List<_iyfor54a.Skill> skills,
    required List<_iot70o80.Experience> experiences,
    required List<_ivtjr8tj.Project> projects,
    required List<_i3diedg0.SocialLink> socialLinks,
    _i807syeh.ProfileCustomization? customization,
  }) : super._(
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
         skills: skills,
         experiences: experiences,
         projects: projects,
         socialLinks: socialLinks,
         customization: customization,
       );

  /// Returns a shallow copy of this [PublicProfileData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PublicProfileData copyWith({
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
    List<_iyfor54a.Skill>? skills,
    List<_iot70o80.Experience>? experiences,
    List<_ivtjr8tj.Project>? projects,
    List<_i3diedg0.SocialLink>? socialLinks,
    Object? customization = _Undefined,
  }) {
    return PublicProfileData(
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
      skills: skills ?? this.skills.map((e0) => e0.copyWith()).toList(),
      experiences:
          experiences ?? this.experiences.map((e0) => e0.copyWith()).toList(),
      projects: projects ?? this.projects.map((e0) => e0.copyWith()).toList(),
      socialLinks:
          socialLinks ?? this.socialLinks.map((e0) => e0.copyWith()).toList(),
      customization: customization is _i807syeh.ProfileCustomization?
          ? customization
          : this.customization?.copyWith(),
    );
  }
}
