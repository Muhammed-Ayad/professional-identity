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
import 'dart:typed_data' as _idt;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../analytics/analytics_endpoint.dart' as _iowd1mgi;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../cv/cv_endpoint.dart' as _imwg6er9;
import '../experience/experience_endpoint.dart' as _i8z4eepn;
import '../greetings/greeting_endpoint.dart' as _il624ik7;
import '../inquiries/inquiry_endpoint.dart' as _ip34u3f4;
import '../profile/profile_endpoint.dart' as _i6ky944g;
import '../profile/public_profile_endpoint.dart' as _is0nlsdg;
import '../profile_customization/customization_endpoint.dart' as _ivf585to;
import '../projects/project_endpoint.dart' as _ibi8sted;
import '../skills/skill_endpoint.dart' as _ijs4sson;
import '../social_links/social_link_endpoint.dart' as _i5nug4n9;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'analytics': _iowd1mgi.AnalyticsEndpoint()
        ..initialize(
          server,
          'analytics',
          null,
        ),
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'cv': _imwg6er9.CvEndpoint()
        ..initialize(
          server,
          'cv',
          null,
        ),
      'experience': _i8z4eepn.ExperienceEndpoint()
        ..initialize(
          server,
          'experience',
          null,
        ),
      'greeting': _il624ik7.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
      'inquiry': _ip34u3f4.InquiryEndpoint()
        ..initialize(
          server,
          'inquiry',
          null,
        ),
      'profile': _i6ky944g.ProfileEndpoint()
        ..initialize(
          server,
          'profile',
          null,
        ),
      'publicProfile': _is0nlsdg.PublicProfileEndpoint()
        ..initialize(
          server,
          'publicProfile',
          null,
        ),
      'customization': _ivf585to.CustomizationEndpoint()
        ..initialize(
          server,
          'customization',
          null,
        ),
      'project': _ibi8sted.ProjectEndpoint()
        ..initialize(
          server,
          'project',
          null,
        ),
      'skill': _ijs4sson.SkillEndpoint()
        ..initialize(
          server,
          'skill',
          null,
        ),
      'socialLink': _i5nug4n9.SocialLinkEndpoint()
        ..initialize(
          server,
          'socialLink',
          null,
        ),
    };
    connectors['analytics'] = _is.EndpointConnector(
      name: 'analytics',
      endpoint: endpoints['analytics']!,
      methodConnectors: {
        'recordPublicEvent': _is.MethodConnector(
          name: 'recordPublicEvent',
          params: {
            'handle': _is.ParameterDescription(
              name: 'handle',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'eventType': _is.ParameterDescription(
              name: 'eventType',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'target': _is.ParameterDescription(
              name: 'target',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _iowd1mgi.AnalyticsEndpoint)
                  .recordPublicEvent(
                    session,
                    params['handle'],
                    params['eventType'],
                    params['target'],
                  ),
        ),
        'getAnalyticsSummary': _is.MethodConnector(
          name: 'getAnalyticsSummary',
          params: {
            'from': _is.ParameterDescription(
              name: 'from',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'to': _is.ParameterDescription(
              name: 'to',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _iowd1mgi.AnalyticsEndpoint)
                  .getAnalyticsSummary(
                    session,
                    params['from'],
                    params['to'],
                  ),
        ),
      },
    );
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['cv'] = _is.EndpointConnector(
      name: 'cv',
      endpoint: endpoints['cv']!,
      methodConnectors: {
        'getMyCv': _is.MethodConnector(
          name: 'getMyCv',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['cv'] as _imwg6er9.CvEndpoint).getMyCv(session),
        ),
        'uploadCv': _is.MethodConnector(
          name: 'uploadCv',
          params: {
            'fileName': _is.ParameterDescription(
              name: 'fileName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'fileBytes': _is.ParameterDescription(
              name: 'fileBytes',
              type: _is.getType<_idt.ByteData>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['cv'] as _imwg6er9.CvEndpoint).uploadCv(
                session,
                params['fileName'],
                params['fileBytes'],
              ),
        ),
        'deleteCv': _is.MethodConnector(
          name: 'deleteCv',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['cv'] as _imwg6er9.CvEndpoint).deleteCv(session),
        ),
      },
    );
    connectors['experience'] = _is.EndpointConnector(
      name: 'experience',
      endpoint: endpoints['experience']!,
      methodConnectors: {
        'getMyExperience': _is.MethodConnector(
          name: 'getMyExperience',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['experience'] as _i8z4eepn.ExperienceEndpoint)
                      .getMyExperience(session),
        ),
        'createExperience': _is.MethodConnector(
          name: 'createExperience',
          params: {
            'company': _is.ParameterDescription(
              name: 'company',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'jobTitle': _is.ParameterDescription(
              name: 'jobTitle',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'startDate': _is.ParameterDescription(
              name: 'startDate',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'endDate': _is.ParameterDescription(
              name: 'endDate',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'isCurrent': _is.ParameterDescription(
              name: 'isCurrent',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['experience'] as _i8z4eepn.ExperienceEndpoint)
                      .createExperience(
                        session,
                        params['company'],
                        params['jobTitle'],
                        params['startDate'],
                        endDate: params['endDate'],
                        isCurrent: params['isCurrent'],
                        description: params['description'],
                      ),
        ),
        'updateExperience': _is.MethodConnector(
          name: 'updateExperience',
          params: {
            'experienceId': _is.ParameterDescription(
              name: 'experienceId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'company': _is.ParameterDescription(
              name: 'company',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'jobTitle': _is.ParameterDescription(
              name: 'jobTitle',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'startDate': _is.ParameterDescription(
              name: 'startDate',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'endDate': _is.ParameterDescription(
              name: 'endDate',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'isCurrent': _is.ParameterDescription(
              name: 'isCurrent',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['experience'] as _i8z4eepn.ExperienceEndpoint)
                      .updateExperience(
                        session,
                        params['experienceId'],
                        params['company'],
                        params['jobTitle'],
                        params['startDate'],
                        endDate: params['endDate'],
                        isCurrent: params['isCurrent'],
                        description: params['description'],
                      ),
        ),
        'deleteExperience': _is.MethodConnector(
          name: 'deleteExperience',
          params: {
            'experienceId': _is.ParameterDescription(
              name: 'experienceId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['experience'] as _i8z4eepn.ExperienceEndpoint)
                      .deleteExperience(
                        session,
                        params['experienceId'],
                      ),
        ),
        'reorderExperience': _is.MethodConnector(
          name: 'reorderExperience',
          params: {
            'experienceIds': _is.ParameterDescription(
              name: 'experienceIds',
              type: _is.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['experience'] as _i8z4eepn.ExperienceEndpoint)
                      .reorderExperience(
                        session,
                        params['experienceIds'],
                      ),
        ),
      },
    );
    connectors['greeting'] = _is.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _is.MethodConnector(
          name: 'hello',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['greeting'] as _il624ik7.GreetingEndpoint).hello(
                    session,
                    params['name'],
                  ),
        ),
      },
    );
    connectors['inquiry'] = _is.EndpointConnector(
      name: 'inquiry',
      endpoint: endpoints['inquiry']!,
      methodConnectors: {
        'submitPublicInquiry': _is.MethodConnector(
          name: 'submitPublicInquiry',
          params: {
            'handle': _is.ParameterDescription(
              name: 'handle',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'senderName': _is.ParameterDescription(
              name: 'senderName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'senderEmail': _is.ParameterDescription(
              name: 'senderEmail',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'subject': _is.ParameterDescription(
              name: 'subject',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'message': _is.ParameterDescription(
              name: 'message',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'inquiryType': _is.ParameterDescription(
              name: 'inquiryType',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'honeypot': _is.ParameterDescription(
              name: 'honeypot',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['inquiry'] as _ip34u3f4.InquiryEndpoint)
                  .submitPublicInquiry(
                    session,
                    params['handle'],
                    params['senderName'],
                    params['senderEmail'],
                    params['subject'],
                    params['message'],
                    params['inquiryType'],
                    honeypot: params['honeypot'],
                  ),
        ),
        'getMyInquiries': _is.MethodConnector(
          name: 'getMyInquiries',
          params: {
            'isRead': _is.ParameterDescription(
              name: 'isRead',
              type: _is.getType<bool?>(),
              nullable: true,
            ),
            'isArchived': _is.ParameterDescription(
              name: 'isArchived',
              type: _is.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['inquiry'] as _ip34u3f4.InquiryEndpoint)
                  .getMyInquiries(
                    session,
                    isRead: params['isRead'],
                    isArchived: params['isArchived'],
                  ),
        ),
        'markInquiryRead': _is.MethodConnector(
          name: 'markInquiryRead',
          params: {
            'inquiryId': _is.ParameterDescription(
              name: 'inquiryId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'isRead': _is.ParameterDescription(
              name: 'isRead',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['inquiry'] as _ip34u3f4.InquiryEndpoint)
                  .markInquiryRead(
                    session,
                    params['inquiryId'],
                    params['isRead'],
                  ),
        ),
        'archiveInquiry': _is.MethodConnector(
          name: 'archiveInquiry',
          params: {
            'inquiryId': _is.ParameterDescription(
              name: 'inquiryId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'isArchived': _is.ParameterDescription(
              name: 'isArchived',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['inquiry'] as _ip34u3f4.InquiryEndpoint)
                  .archiveInquiry(
                    session,
                    params['inquiryId'],
                    params['isArchived'],
                  ),
        ),
        'deleteInquiry': _is.MethodConnector(
          name: 'deleteInquiry',
          params: {
            'inquiryId': _is.ParameterDescription(
              name: 'inquiryId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['inquiry'] as _ip34u3f4.InquiryEndpoint)
                  .deleteInquiry(
                    session,
                    params['inquiryId'],
                  ),
        ),
      },
    );
    connectors['profile'] = _is.EndpointConnector(
      name: 'profile',
      endpoint: endpoints['profile']!,
      methodConnectors: {
        'getMyProfile': _is.MethodConnector(
          name: 'getMyProfile',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i6ky944g.ProfileEndpoint)
                  .getMyProfile(session),
        ),
        'getPublicProfile': _is.MethodConnector(
          name: 'getPublicProfile',
          params: {
            'handle': _is.ParameterDescription(
              name: 'handle',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i6ky944g.ProfileEndpoint)
                  .getPublicProfile(
                    session,
                    params['handle'],
                  ),
        ),
        'isHandleAvailable': _is.MethodConnector(
          name: 'isHandleAvailable',
          params: {
            'handle': _is.ParameterDescription(
              name: 'handle',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i6ky944g.ProfileEndpoint)
                  .isHandleAvailable(
                    session,
                    params['handle'],
                  ),
        ),
        'saveMyProfile': _is.MethodConnector(
          name: 'saveMyProfile',
          params: {
            'handle': _is.ParameterDescription(
              name: 'handle',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'fullName': _is.ParameterDescription(
              name: 'fullName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'headline': _is.ParameterDescription(
              name: 'headline',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'bio': _is.ParameterDescription(
              name: 'bio',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'location': _is.ParameterDescription(
              name: 'location',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'currentRole': _is.ParameterDescription(
              name: 'currentRole',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'yearsOfExperience': _is.ParameterDescription(
              name: 'yearsOfExperience',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'availability': _is.ParameterDescription(
              name: 'availability',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'contactEmail': _is.ParameterDescription(
              name: 'contactEmail',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'websiteUrl': _is.ParameterDescription(
              name: 'websiteUrl',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'avatarUrl': _is.ParameterDescription(
              name: 'avatarUrl',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'isPublic': _is.ParameterDescription(
              name: 'isPublic',
              type: _is.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i6ky944g.ProfileEndpoint)
                  .saveMyProfile(
                    session,
                    params['handle'],
                    params['fullName'],
                    headline: params['headline'],
                    bio: params['bio'],
                    location: params['location'],
                    currentRole: params['currentRole'],
                    yearsOfExperience: params['yearsOfExperience'],
                    availability: params['availability'],
                    contactEmail: params['contactEmail'],
                    websiteUrl: params['websiteUrl'],
                    avatarUrl: params['avatarUrl'],
                    isPublic: params['isPublic'],
                  ),
        ),
      },
    );
    connectors['publicProfile'] = _is.EndpointConnector(
      name: 'publicProfile',
      endpoint: endpoints['publicProfile']!,
      methodConnectors: {
        'getPublicProfile': _is.MethodConnector(
          name: 'getPublicProfile',
          params: {
            'handle': _is.ParameterDescription(
              name: 'handle',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['publicProfile']
                          as _is0nlsdg.PublicProfileEndpoint)
                      .getPublicProfile(
                        session,
                        params['handle'],
                      ),
        ),
      },
    );
    connectors['customization'] = _is.EndpointConnector(
      name: 'customization',
      endpoint: endpoints['customization']!,
      methodConnectors: {
        'getCustomization': _is.MethodConnector(
          name: 'getCustomization',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['customization']
                          as _ivf585to.CustomizationEndpoint)
                      .getCustomization(session),
        ),
        'updateCustomization': _is.MethodConnector(
          name: 'updateCustomization',
          params: {
            'themePreset': _is.ParameterDescription(
              name: 'themePreset',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'primaryColor': _is.ParameterDescription(
              name: 'primaryColor',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'backgroundStyle': _is.ParameterDescription(
              name: 'backgroundStyle',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'cardStyle': _is.ParameterDescription(
              name: 'cardStyle',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'borderRadius': _is.ParameterDescription(
              name: 'borderRadius',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'typographyStyle': _is.ParameterDescription(
              name: 'typographyStyle',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['customization']
                          as _ivf585to.CustomizationEndpoint)
                      .updateCustomization(
                        session,
                        params['themePreset'],
                        params['primaryColor'],
                        params['backgroundStyle'],
                        params['cardStyle'],
                        params['borderRadius'],
                        params['typographyStyle'],
                      ),
        ),
        'getPublicCustomization': _is.MethodConnector(
          name: 'getPublicCustomization',
          params: {
            'handle': _is.ParameterDescription(
              name: 'handle',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['customization']
                          as _ivf585to.CustomizationEndpoint)
                      .getPublicCustomization(
                        session,
                        params['handle'],
                      ),
        ),
      },
    );
    connectors['project'] = _is.EndpointConnector(
      name: 'project',
      endpoint: endpoints['project']!,
      methodConnectors: {
        'getMyProjects': _is.MethodConnector(
          name: 'getMyProjects',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['project'] as _ibi8sted.ProjectEndpoint)
                  .getMyProjects(session),
        ),
        'createProject': _is.MethodConnector(
          name: 'createProject',
          params: {
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'role': _is.ParameterDescription(
              name: 'role',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'url': _is.ParameterDescription(
              name: 'url',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'repositoryUrl': _is.ParameterDescription(
              name: 'repositoryUrl',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'imageUrl': _is.ParameterDescription(
              name: 'imageUrl',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'technologies': _is.ParameterDescription(
              name: 'technologies',
              type: _is.getType<List<String>>(),
              nullable: false,
            ),
            'startDate': _is.ParameterDescription(
              name: 'startDate',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'endDate': _is.ParameterDescription(
              name: 'endDate',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'isOngoing': _is.ParameterDescription(
              name: 'isOngoing',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['project'] as _ibi8sted.ProjectEndpoint)
                  .createProject(
                    session,
                    title: params['title'],
                    description: params['description'],
                    role: params['role'],
                    url: params['url'],
                    repositoryUrl: params['repositoryUrl'],
                    imageUrl: params['imageUrl'],
                    technologies: params['technologies'],
                    startDate: params['startDate'],
                    endDate: params['endDate'],
                    isOngoing: params['isOngoing'],
                  ),
        ),
        'updateProject': _is.MethodConnector(
          name: 'updateProject',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'role': _is.ParameterDescription(
              name: 'role',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'url': _is.ParameterDescription(
              name: 'url',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'repositoryUrl': _is.ParameterDescription(
              name: 'repositoryUrl',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'imageUrl': _is.ParameterDescription(
              name: 'imageUrl',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'technologies': _is.ParameterDescription(
              name: 'technologies',
              type: _is.getType<List<String>>(),
              nullable: false,
            ),
            'startDate': _is.ParameterDescription(
              name: 'startDate',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'endDate': _is.ParameterDescription(
              name: 'endDate',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'isOngoing': _is.ParameterDescription(
              name: 'isOngoing',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['project'] as _ibi8sted.ProjectEndpoint)
                  .updateProject(
                    session,
                    projectId: params['projectId'],
                    title: params['title'],
                    description: params['description'],
                    role: params['role'],
                    url: params['url'],
                    repositoryUrl: params['repositoryUrl'],
                    imageUrl: params['imageUrl'],
                    technologies: params['technologies'],
                    startDate: params['startDate'],
                    endDate: params['endDate'],
                    isOngoing: params['isOngoing'],
                  ),
        ),
        'deleteProject': _is.MethodConnector(
          name: 'deleteProject',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['project'] as _ibi8sted.ProjectEndpoint)
                  .deleteProject(
                    session,
                    params['projectId'],
                  ),
        ),
        'reorderProjects': _is.MethodConnector(
          name: 'reorderProjects',
          params: {
            'projectIds': _is.ParameterDescription(
              name: 'projectIds',
              type: _is.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['project'] as _ibi8sted.ProjectEndpoint)
                  .reorderProjects(
                    session,
                    params['projectIds'],
                  ),
        ),
      },
    );
    connectors['skill'] = _is.EndpointConnector(
      name: 'skill',
      endpoint: endpoints['skill']!,
      methodConnectors: {
        'getMySkills': _is.MethodConnector(
          name: 'getMySkills',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['skill'] as _ijs4sson.SkillEndpoint)
                  .getMySkills(session),
        ),
        'createSkill': _is.MethodConnector(
          name: 'createSkill',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'category': _is.ParameterDescription(
              name: 'category',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'yearsOfExperience': _is.ParameterDescription(
              name: 'yearsOfExperience',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['skill'] as _ijs4sson.SkillEndpoint).createSkill(
                    session,
                    params['name'],
                    category: params['category'],
                    yearsOfExperience: params['yearsOfExperience'],
                  ),
        ),
        'updateSkill': _is.MethodConnector(
          name: 'updateSkill',
          params: {
            'skillId': _is.ParameterDescription(
              name: 'skillId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'category': _is.ParameterDescription(
              name: 'category',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'yearsOfExperience': _is.ParameterDescription(
              name: 'yearsOfExperience',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['skill'] as _ijs4sson.SkillEndpoint).updateSkill(
                    session,
                    params['skillId'],
                    params['name'],
                    category: params['category'],
                    yearsOfExperience: params['yearsOfExperience'],
                  ),
        ),
        'deleteSkill': _is.MethodConnector(
          name: 'deleteSkill',
          params: {
            'skillId': _is.ParameterDescription(
              name: 'skillId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['skill'] as _ijs4sson.SkillEndpoint).deleteSkill(
                    session,
                    params['skillId'],
                  ),
        ),
        'reorderSkills': _is.MethodConnector(
          name: 'reorderSkills',
          params: {
            'skillIds': _is.ParameterDescription(
              name: 'skillIds',
              type: _is.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['skill'] as _ijs4sson.SkillEndpoint).reorderSkills(
                    session,
                    params['skillIds'],
                  ),
        ),
      },
    );
    connectors['socialLink'] = _is.EndpointConnector(
      name: 'socialLink',
      endpoint: endpoints['socialLink']!,
      methodConnectors: {
        'getMySocialLinks': _is.MethodConnector(
          name: 'getMySocialLinks',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['socialLink'] as _i5nug4n9.SocialLinkEndpoint)
                      .getMySocialLinks(session),
        ),
        'createSocialLink': _is.MethodConnector(
          name: 'createSocialLink',
          params: {
            'platform': _is.ParameterDescription(
              name: 'platform',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'url': _is.ParameterDescription(
              name: 'url',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'label': _is.ParameterDescription(
              name: 'label',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['socialLink'] as _i5nug4n9.SocialLinkEndpoint)
                      .createSocialLink(
                        session,
                        params['platform'],
                        params['url'],
                        label: params['label'],
                      ),
        ),
        'updateSocialLink': _is.MethodConnector(
          name: 'updateSocialLink',
          params: {
            'linkId': _is.ParameterDescription(
              name: 'linkId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'platform': _is.ParameterDescription(
              name: 'platform',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'url': _is.ParameterDescription(
              name: 'url',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'label': _is.ParameterDescription(
              name: 'label',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['socialLink'] as _i5nug4n9.SocialLinkEndpoint)
                      .updateSocialLink(
                        session,
                        params['linkId'],
                        params['platform'],
                        params['url'],
                        label: params['label'],
                      ),
        ),
        'deleteSocialLink': _is.MethodConnector(
          name: 'deleteSocialLink',
          params: {
            'linkId': _is.ParameterDescription(
              name: 'linkId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['socialLink'] as _i5nug4n9.SocialLinkEndpoint)
                      .deleteSocialLink(
                        session,
                        params['linkId'],
                      ),
        ),
        'reorderSocialLinks': _is.MethodConnector(
          name: 'reorderSocialLinks',
          params: {
            'linkIds': _is.ParameterDescription(
              name: 'linkIds',
              type: _is.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['socialLink'] as _i5nug4n9.SocialLinkEndpoint)
                      .reorderSocialLinks(
                        session,
                        params['linkIds'],
                      ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }
}
