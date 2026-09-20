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

abstract class ContactInquiry
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ContactInquiry._({
    this.id,
    required this.profileId,
    this.profile,
    required this.senderName,
    required this.senderEmail,
    required this.subject,
    required this.message,
    String? inquiryType,
    bool? isRead,
    bool? isArchived,
    DateTime? createdAt,
  }) : inquiryType = inquiryType ?? 'general',
       isRead = isRead ?? false,
       isArchived = isArchived ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory ContactInquiry({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    required String senderName,
    required String senderEmail,
    required String subject,
    required String message,
    String? inquiryType,
    bool? isRead,
    bool? isArchived,
    DateTime? createdAt,
  }) = _ContactInquiryImpl;

  factory ContactInquiry.fromJson(Map<String, dynamic> jsonSerialization) {
    return ContactInquiry(
      id: jsonSerialization['id'] as int?,
      profileId: jsonSerialization['profileId'] as int,
      profile: jsonSerialization['profile'] == null
          ? null
          : _ixcjy4bn.Protocol().deserialize<_i1157qfm.Profile>(
              jsonSerialization['profile'],
            ),
      senderName: jsonSerialization['senderName'] as String,
      senderEmail: jsonSerialization['senderEmail'] as String,
      subject: jsonSerialization['subject'] as String,
      message: jsonSerialization['message'] as String,
      inquiryType: jsonSerialization['inquiryType'] as String?,
      isRead: jsonSerialization['isRead'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isRead']),
      isArchived: jsonSerialization['isArchived'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isArchived']),
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

  String senderName;

  String senderEmail;

  String subject;

  String message;

  String inquiryType;

  bool isRead;

  bool isArchived;

  DateTime createdAt;

  /// Returns a shallow copy of this [ContactInquiry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ContactInquiry copyWith({
    int? id,
    int? profileId,
    _i1157qfm.Profile? profile,
    String? senderName,
    String? senderEmail,
    String? subject,
    String? message,
    String? inquiryType,
    bool? isRead,
    bool? isArchived,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ContactInquiry',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJson(),
      'senderName': senderName,
      'senderEmail': senderEmail,
      'subject': subject,
      'message': message,
      'inquiryType': inquiryType,
      'isRead': isRead,
      'isArchived': isArchived,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ContactInquiry',
      if (id != null) 'id': id,
      'profileId': profileId,
      if (profile != null) 'profile': profile?.toJsonForProtocol(),
      'senderName': senderName,
      'senderEmail': senderEmail,
      'subject': subject,
      'message': message,
      'inquiryType': inquiryType,
      'isRead': isRead,
      'isArchived': isArchived,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ContactInquiryImpl extends ContactInquiry {
  _ContactInquiryImpl({
    int? id,
    required int profileId,
    _i1157qfm.Profile? profile,
    required String senderName,
    required String senderEmail,
    required String subject,
    required String message,
    String? inquiryType,
    bool? isRead,
    bool? isArchived,
    DateTime? createdAt,
  }) : super._(
         id: id,
         profileId: profileId,
         profile: profile,
         senderName: senderName,
         senderEmail: senderEmail,
         subject: subject,
         message: message,
         inquiryType: inquiryType,
         isRead: isRead,
         isArchived: isArchived,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ContactInquiry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ContactInquiry copyWith({
    Object? id = _Undefined,
    int? profileId,
    Object? profile = _Undefined,
    String? senderName,
    String? senderEmail,
    String? subject,
    String? message,
    String? inquiryType,
    bool? isRead,
    bool? isArchived,
    DateTime? createdAt,
  }) {
    return ContactInquiry(
      id: id is int? ? id : this.id,
      profileId: profileId ?? this.profileId,
      profile: profile is _i1157qfm.Profile?
          ? profile
          : this.profile?.copyWith(),
      senderName: senderName ?? this.senderName,
      senderEmail: senderEmail ?? this.senderEmail,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      inquiryType: inquiryType ?? this.inquiryType,
      isRead: isRead ?? this.isRead,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
