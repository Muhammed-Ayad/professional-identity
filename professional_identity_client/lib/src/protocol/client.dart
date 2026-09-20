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
import 'dart:async' as _ida;
import 'dart:typed_data' as _idt;
import 'package:http/http.dart' as _i85jenna;
import 'package:professional_identity_client/src/protocol/analytics/models/analytics_summary.dart'
    as _i4ihd4gw;
import 'package:professional_identity_client/src/protocol/experience/experience.dart'
    as _i0rtawz4;
import 'package:professional_identity_client/src/protocol/greetings/greeting.dart'
    as _ivrm668i;
import 'package:professional_identity_client/src/protocol/inquiries/contact_inquiry.dart'
    as _iad825pn;
import 'package:professional_identity_client/src/protocol/profile/profile.dart'
    as _ilwj95em;
import 'package:professional_identity_client/src/protocol/profile/public_profile_data.dart'
    as _idqjzgj4;
import 'package:professional_identity_client/src/protocol/profile_customization/profile_customization.dart'
    as _ijit4gwq;
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
import 'protocol.dart' as _il2as5qe;

/// Privacy-conscious analytics endpoint for tracking profile interactions
/// and delivering aggregated analytics metrics.
///
/// PRIVACY GUARANTEE:
/// - Never collects or stores IP addresses, visitor account IDs, emails,
///   auth tokens, device identifiers, precise geolocation, or user agents.
/// - The only data captured: profileId, eventType, safe target, server-generated createdAt.
/// {@category Endpoint}
class EndpointAnalytics extends _isc.EndpointRef {
  EndpointAnalytics(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'analytics';

  /// Records a public profile interaction event safely and anonymously.
  ///
  /// The client cannot provide a profileId or createdAt timestamp.
  /// The server resolves the profile using the public handle and assigns `DateTime.now()`.
  _ida.Future<bool> recordPublicEvent(
    String handle,
    String eventType,
    String? target,
  ) => caller.callServerEndpoint<bool>(
    'analytics',
    'recordPublicEvent',
    {
      'handle': handle,
      'eventType': eventType,
      'target': target,
    },
  );

  /// Returns aggregated analytics for the authenticated user's profile
  /// within the specified date window [from] to [to].
  _ida.Future<_i4ihd4gw.AnalyticsSummary> getAnalyticsSummary(
    DateTime from,
    DateTime to,
  ) => caller.callServerEndpoint<_i4ihd4gw.AnalyticsSummary>(
    'analytics',
    'getAnalyticsSummary',
    {
      'from': from,
      'to': to,
    },
  );
}

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// {@category Endpoint}
class EndpointCv extends _isc.EndpointRef {
  EndpointCv(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'cv';

  _ida.Future<String?> getMyCv() => caller.callServerEndpoint<String?>(
    'cv',
    'getMyCv',
    {},
  );

  _ida.Future<String> uploadCv(
    String fileName,
    _idt.ByteData fileBytes,
  ) => caller.callServerEndpoint<String>(
    'cv',
    'uploadCv',
    {
      'fileName': fileName,
      'fileBytes': fileBytes,
    },
  );

  _ida.Future<void> deleteCv() => caller.callServerEndpoint<void>(
    'cv',
    'deleteCv',
    {},
  );
}

/// {@category Endpoint}
class EndpointExperience extends _isc.EndpointRef {
  EndpointExperience(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'experience';

  /// Fetches all work experiences for the authenticated user's profile.
  _ida.Future<List<_i0rtawz4.Experience>> getMyExperience() =>
      caller.callServerEndpoint<List<_i0rtawz4.Experience>>(
        'experience',
        'getMyExperience',
        {},
      );

  /// Creates a new work experience entry.
  _ida.Future<_i0rtawz4.Experience> createExperience(
    String company,
    String jobTitle,
    DateTime startDate, {
    DateTime? endDate,
    required bool isCurrent,
    String? description,
  }) => caller.callServerEndpoint<_i0rtawz4.Experience>(
    'experience',
    'createExperience',
    {
      'company': company,
      'jobTitle': jobTitle,
      'startDate': startDate,
      'endDate': endDate,
      'isCurrent': isCurrent,
      'description': description,
    },
  );

  /// Updates an existing work experience entry owned by the user.
  _ida.Future<_i0rtawz4.Experience> updateExperience(
    int experienceId,
    String company,
    String jobTitle,
    DateTime startDate, {
    DateTime? endDate,
    required bool isCurrent,
    String? description,
  }) => caller.callServerEndpoint<_i0rtawz4.Experience>(
    'experience',
    'updateExperience',
    {
      'experienceId': experienceId,
      'company': company,
      'jobTitle': jobTitle,
      'startDate': startDate,
      'endDate': endDate,
      'isCurrent': isCurrent,
      'description': description,
    },
  );

  /// Deletes a work experience entry owned by the user.
  _ida.Future<bool> deleteExperience(int experienceId) =>
      caller.callServerEndpoint<bool>(
        'experience',
        'deleteExperience',
        {'experienceId': experienceId},
      );

  /// Reorders work experience entries for the authenticated user.
  _ida.Future<bool> reorderExperience(List<int> experienceIds) =>
      caller.callServerEndpoint<bool>(
        'experience',
        'reorderExperience',
        {'experienceIds': experienceIds},
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _isc.EndpointRef {
  EndpointGreeting(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _ida.Future<_ivrm668i.Greeting> hello(String name) =>
      caller.callServerEndpoint<_ivrm668i.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

/// {@category Endpoint}
class EndpointInquiry extends _isc.EndpointRef {
  EndpointInquiry(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'inquiry';

  /// Submits a contact inquiry to a public profile.
  /// Unauthenticated endpoint for visitors.
  _ida.Future<bool> submitPublicInquiry(
    String handle,
    String senderName,
    String senderEmail,
    String subject,
    String message,
    String inquiryType, {
    String? honeypot,
  }) => caller.callServerEndpoint<bool>(
    'inquiry',
    'submitPublicInquiry',
    {
      'handle': handle,
      'senderName': senderName,
      'senderEmail': senderEmail,
      'subject': subject,
      'message': message,
      'inquiryType': inquiryType,
      'honeypot': honeypot,
    },
  );

  /// Fetches all inquiries for the authenticated user's profile.
  _ida.Future<List<_iad825pn.ContactInquiry>> getMyInquiries({
    bool? isRead,
    bool? isArchived,
  }) => caller.callServerEndpoint<List<_iad825pn.ContactInquiry>>(
    'inquiry',
    'getMyInquiries',
    {
      'isRead': isRead,
      'isArchived': isArchived,
    },
  );

  /// Toggles read/unread status of an inquiry owned by the authenticated user.
  _ida.Future<_iad825pn.ContactInquiry> markInquiryRead(
    int inquiryId,
    bool isRead,
  ) => caller.callServerEndpoint<_iad825pn.ContactInquiry>(
    'inquiry',
    'markInquiryRead',
    {
      'inquiryId': inquiryId,
      'isRead': isRead,
    },
  );

  /// Toggles archive status of an inquiry owned by the authenticated user.
  _ida.Future<_iad825pn.ContactInquiry> archiveInquiry(
    int inquiryId,
    bool isArchived,
  ) => caller.callServerEndpoint<_iad825pn.ContactInquiry>(
    'inquiry',
    'archiveInquiry',
    {
      'inquiryId': inquiryId,
      'isArchived': isArchived,
    },
  );

  /// Deletes an inquiry owned by the authenticated user.
  _ida.Future<bool> deleteInquiry(int inquiryId) =>
      caller.callServerEndpoint<bool>(
        'inquiry',
        'deleteInquiry',
        {'inquiryId': inquiryId},
      );
}

/// {@category Endpoint}
class EndpointProfile extends _isc.EndpointRef {
  EndpointProfile(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'profile';

  /// Fetches the profile of the currently authenticated user, or null if they haven't set one up yet.
  _ida.Future<_ilwj95em.Profile?> getMyProfile() =>
      caller.callServerEndpoint<_ilwj95em.Profile?>(
        'profile',
        'getMyProfile',
        {},
      );

  /// Gets a public profile by its unique handle.
  /// Only returns the profile if `isPublic` is true.
  _ida.Future<_ilwj95em.Profile?> getPublicProfile(String handle) =>
      caller.callServerEndpoint<_ilwj95em.Profile?>(
        'profile',
        'getPublicProfile',
        {'handle': handle},
      );

  /// Checks whether a handle is available for registration or update.
  _ida.Future<bool> isHandleAvailable(String handle) =>
      caller.callServerEndpoint<bool>(
        'profile',
        'isHandleAvailable',
        {'handle': handle},
      );

  /// Creates or updates the authenticated user's profile.
  _ida.Future<_ilwj95em.Profile> saveMyProfile(
    String handle,
    String fullName, {
    String? headline,
    String? bio,
    String? location,
    String? currentRole,
    int? yearsOfExperience,
    String? availability,
    String? contactEmail,
    String? websiteUrl,
    String? avatarUrl,
    bool? isPublic,
  }) => caller.callServerEndpoint<_ilwj95em.Profile>(
    'profile',
    'saveMyProfile',
    {
      'handle': handle,
      'fullName': fullName,
      'headline': headline,
      'bio': bio,
      'location': location,
      'currentRole': currentRole,
      'yearsOfExperience': yearsOfExperience,
      'availability': availability,
      'contactEmail': contactEmail,
      'websiteUrl': websiteUrl,
      'avatarUrl': avatarUrl,
      'isPublic': isPublic,
    },
  );
}

/// {@category Endpoint}
class EndpointPublicProfile extends _isc.EndpointRef {
  EndpointPublicProfile(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'publicProfile';

  /// Fetches a complete public professional profile by handle without authentication.
  /// Returns null if the profile does not exist or if isPublic is false.
  _ida.Future<_idqjzgj4.PublicProfileData?> getPublicProfile(String handle) =>
      caller.callServerEndpoint<_idqjzgj4.PublicProfileData?>(
        'publicProfile',
        'getPublicProfile',
        {'handle': handle},
      );
}

/// {@category Endpoint}
class EndpointCustomization extends _isc.EndpointRef {
  EndpointCustomization(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'customization';

  /// Fetches the profile customization for the authenticated user.
  _ida.Future<_ijit4gwq.ProfileCustomization?> getCustomization() =>
      caller.callServerEndpoint<_ijit4gwq.ProfileCustomization?>(
        'customization',
        'getCustomization',
        {},
      );

  /// Updates or creates the profile customization for the authenticated user.
  _ida.Future<_ijit4gwq.ProfileCustomization> updateCustomization(
    String themePreset,
    String? primaryColor,
    String backgroundStyle,
    String cardStyle,
    String borderRadius,
    String typographyStyle,
  ) => caller.callServerEndpoint<_ijit4gwq.ProfileCustomization>(
    'customization',
    'updateCustomization',
    {
      'themePreset': themePreset,
      'primaryColor': primaryColor,
      'backgroundStyle': backgroundStyle,
      'cardStyle': cardStyle,
      'borderRadius': borderRadius,
      'typographyStyle': typographyStyle,
    },
  );

  /// Fetches the profile customization for a public profile.
  /// Returns null if the profile does not exist or is private.
  _ida.Future<_ijit4gwq.ProfileCustomization?> getPublicCustomization(
    String handle,
  ) => caller.callServerEndpoint<_ijit4gwq.ProfileCustomization?>(
    'customization',
    'getPublicCustomization',
    {'handle': handle},
  );
}

/// {@category Endpoint}
class EndpointProject extends _isc.EndpointRef {
  EndpointProject(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'project';

  _ida.Future<List<_ic408x76.Project>> getMyProjects() =>
      caller.callServerEndpoint<List<_ic408x76.Project>>(
        'project',
        'getMyProjects',
        {},
      );

  _ida.Future<_ic408x76.Project> createProject({
    required String title,
    String? description,
    String? role,
    String? url,
    String? repositoryUrl,
    String? imageUrl,
    required List<String> technologies,
    DateTime? startDate,
    DateTime? endDate,
    required bool isOngoing,
  }) => caller.callServerEndpoint<_ic408x76.Project>(
    'project',
    'createProject',
    {
      'title': title,
      'description': description,
      'role': role,
      'url': url,
      'repositoryUrl': repositoryUrl,
      'imageUrl': imageUrl,
      'technologies': technologies,
      'startDate': startDate,
      'endDate': endDate,
      'isOngoing': isOngoing,
    },
  );

  _ida.Future<_ic408x76.Project> updateProject({
    required int projectId,
    required String title,
    String? description,
    String? role,
    String? url,
    String? repositoryUrl,
    String? imageUrl,
    required List<String> technologies,
    DateTime? startDate,
    DateTime? endDate,
    required bool isOngoing,
  }) => caller.callServerEndpoint<_ic408x76.Project>(
    'project',
    'updateProject',
    {
      'projectId': projectId,
      'title': title,
      'description': description,
      'role': role,
      'url': url,
      'repositoryUrl': repositoryUrl,
      'imageUrl': imageUrl,
      'technologies': technologies,
      'startDate': startDate,
      'endDate': endDate,
      'isOngoing': isOngoing,
    },
  );

  _ida.Future<void> deleteProject(int projectId) =>
      caller.callServerEndpoint<void>(
        'project',
        'deleteProject',
        {'projectId': projectId},
      );

  _ida.Future<void> reorderProjects(List<int> projectIds) =>
      caller.callServerEndpoint<void>(
        'project',
        'reorderProjects',
        {'projectIds': projectIds},
      );
}

/// {@category Endpoint}
class EndpointSkill extends _isc.EndpointRef {
  EndpointSkill(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'skill';

  /// Fetches all skills for the current authenticated user's profile, ordered by sortOrder.
  _ida.Future<List<_ipfnldx6.Skill>> getMySkills() =>
      caller.callServerEndpoint<List<_ipfnldx6.Skill>>(
        'skill',
        'getMySkills',
        {},
      );

  /// Creates a new skill for the authenticated user's profile.
  _ida.Future<_ipfnldx6.Skill> createSkill(
    String name, {
    String? category,
    int? yearsOfExperience,
  }) => caller.callServerEndpoint<_ipfnldx6.Skill>(
    'skill',
    'createSkill',
    {
      'name': name,
      'category': category,
      'yearsOfExperience': yearsOfExperience,
    },
  );

  /// Updates an existing skill owned by the authenticated user.
  _ida.Future<_ipfnldx6.Skill> updateSkill(
    int skillId,
    String name, {
    String? category,
    int? yearsOfExperience,
  }) => caller.callServerEndpoint<_ipfnldx6.Skill>(
    'skill',
    'updateSkill',
    {
      'skillId': skillId,
      'name': name,
      'category': category,
      'yearsOfExperience': yearsOfExperience,
    },
  );

  /// Deletes an existing skill owned by the authenticated user.
  _ida.Future<bool> deleteSkill(int skillId) => caller.callServerEndpoint<bool>(
    'skill',
    'deleteSkill',
    {'skillId': skillId},
  );

  /// Reorders skills according to the list of IDs for the authenticated user.
  _ida.Future<bool> reorderSkills(List<int> skillIds) =>
      caller.callServerEndpoint<bool>(
        'skill',
        'reorderSkills',
        {'skillIds': skillIds},
      );
}

/// {@category Endpoint}
class EndpointSocialLink extends _isc.EndpointRef {
  EndpointSocialLink(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'socialLink';

  /// Fetches all social links for the authenticated user's profile.
  _ida.Future<List<_isssluk7.SocialLink>> getMySocialLinks() =>
      caller.callServerEndpoint<List<_isssluk7.SocialLink>>(
        'socialLink',
        'getMySocialLinks',
        {},
      );

  /// Creates a new social link for the user's profile.
  _ida.Future<_isssluk7.SocialLink> createSocialLink(
    String platform,
    String url, {
    String? label,
  }) => caller.callServerEndpoint<_isssluk7.SocialLink>(
    'socialLink',
    'createSocialLink',
    {
      'platform': platform,
      'url': url,
      'label': label,
    },
  );

  /// Updates an existing social link owned by the user.
  _ida.Future<_isssluk7.SocialLink> updateSocialLink(
    int linkId,
    String platform,
    String url, {
    String? label,
  }) => caller.callServerEndpoint<_isssluk7.SocialLink>(
    'socialLink',
    'updateSocialLink',
    {
      'linkId': linkId,
      'platform': platform,
      'url': url,
      'label': label,
    },
  );

  /// Deletes a social link owned by the user.
  _ida.Future<bool> deleteSocialLink(int linkId) =>
      caller.callServerEndpoint<bool>(
        'socialLink',
        'deleteSocialLink',
        {'linkId': linkId},
      );

  /// Reorders social links for the authenticated user.
  _ida.Future<bool> reorderSocialLinks(List<int> linkIds) =>
      caller.callServerEndpoint<bool>(
        'socialLink',
        'reorderSocialLinks',
        {'linkIds': linkIds},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    analytics = EndpointAnalytics(this);
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    cv = EndpointCv(this);
    experience = EndpointExperience(this);
    greeting = EndpointGreeting(this);
    inquiry = EndpointInquiry(this);
    profile = EndpointProfile(this);
    publicProfile = EndpointPublicProfile(this);
    customization = EndpointCustomization(this);
    project = EndpointProject(this);
    skill = EndpointSkill(this);
    socialLink = EndpointSocialLink(this);
    modules = Modules(this);
  }

  late final EndpointAnalytics analytics;

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointCv cv;

  late final EndpointExperience experience;

  late final EndpointGreeting greeting;

  late final EndpointInquiry inquiry;

  late final EndpointProfile profile;

  late final EndpointPublicProfile publicProfile;

  late final EndpointCustomization customization;

  late final EndpointProject project;

  late final EndpointSkill skill;

  late final EndpointSocialLink socialLink;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'analytics': analytics,
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'cv': cv,
    'experience': experience,
    'greeting': greeting,
    'inquiry': inquiry,
    'profile': profile,
    'publicProfile': publicProfile,
    'customization': customization,
    'project': project,
    'skill': skill,
    'socialLink': socialLink,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
