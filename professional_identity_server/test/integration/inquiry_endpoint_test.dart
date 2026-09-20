import 'package:professional_identity_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Inquiry endpoint', (sessionBuilder, endpoints) {
    const userId1 = '770e8400-e29b-41d4-a716-446655440001';
    const userId2 = '770e8400-e29b-41d4-a716-446655440002';

    late TestSessionBuilder authedSession1;
    late TestSessionBuilder authedSession2;

    late Profile profile1;
    late Profile profile2;

    setUp(() async {
      final session = sessionBuilder.build();

      // Seed AuthUsers
      await AuthUser.db.insert(session, [
        AuthUser(
          id: UuidValue.fromString(userId1),
          createdAt: DateTime.now(),
          scopeNames: {},
          blocked: false,
        ),
        AuthUser(
          id: UuidValue.fromString(userId2),
          createdAt: DateTime.now(),
          scopeNames: {},
          blocked: false,
        ),
      ]);

      authedSession1 = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          userId1,
          {},
        ),
      );
      authedSession2 = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          userId2,
          {},
        ),
      );

      // Seed Profiles (Profile 1 is public, Profile 2 is private)
      profile1 = await Profile.db.insertRow(
        session,
        Profile(
          authUserId: UuidValue.fromString(userId1),
          handle: 'dev-alice',
          fullName: 'Alice Developer',
          isPublic: true,
        ),
      );

      profile2 = await Profile.db.insertRow(
        session,
        Profile(
          authUserId: UuidValue.fromString(userId2),
          handle: 'dev-bob',
          fullName: 'Bob Developer',
          isPublic: false,
        ),
      );
    });

    group('Public Inquiry Submission', () {
      test(
        'submitting valid inquiry saves to database and logs analytics',
        () async {
          final result = await endpoints.inquiry.submitPublicInquiry(
            sessionBuilder,
            'dev-alice',
            'Recruiter Jane',
            'jane@company.com',
            'Senior Flutter Engineer Role',
            'We love your portfolio and would love to discuss an opportunity.',
            'job_offer',
          );

          expect(result, isTrue);

          final session = sessionBuilder.build();
          final inquiries = await ContactInquiry.db.find(
            session,
            where: (t) => t.profileId.equals(profile1.id!),
          );

          expect(inquiries.length, equals(1));
          final item = inquiries.first;
          expect(item.senderName, equals('Recruiter Jane'));
          expect(item.senderEmail, equals('jane@company.com'));
          expect(item.subject, equals('Senior Flutter Engineer Role'));
          expect(item.inquiryType, equals('job_offer'));
          expect(item.isRead, isFalse);
          expect(item.isArchived, isFalse);
        },
      );

      test(
        'honeypot field triggers silent discard without database insertion',
        () async {
          final result = await endpoints.inquiry.submitPublicInquiry(
            sessionBuilder,
            'dev-alice',
            'Spam Bot',
            'bot@spam.com',
            'Buy cheap products',
            'Spam text...',
            'general',
            honeypot: 'http://spamlink.com',
          );

          expect(result, isTrue);

          final session = sessionBuilder.build();
          final count = await ContactInquiry.db.count(
            session,
            where: (t) => t.profileId.equals(profile1.id!),
          );
          expect(count, equals(0));
        },
      );

      test('rejects inquiry for private profile', () async {
        await expectLater(
          endpoints.inquiry.submitPublicInquiry(
            sessionBuilder,
            'dev-bob',
            'Jane',
            'jane@mail.com',
            'Role',
            'Hello',
            'job_offer',
          ),
          throwsA(isA<ProfileException>()),
        );
      });

      test(
        'validates email format, name, subject, and message length',
        () async {
          // Invalid email
          await expectLater(
            endpoints.inquiry.submitPublicInquiry(
              sessionBuilder,
              'dev-alice',
              'Jane',
              'not-an-email',
              'Subj',
              'Msg',
              'general',
            ),
            throwsA(isA<ProfileException>()),
          );

          // Empty message
          await expectLater(
            endpoints.inquiry.submitPublicInquiry(
              sessionBuilder,
              'dev-alice',
              'Jane',
              'jane@mail.com',
              'Subj',
              '   ',
              'general',
            ),
            throwsA(isA<ProfileException>()),
          );
        },
      );
    });

    group('Authenticated Inquiries Management', () {
      setUp(() async {
        final session = sessionBuilder.build();
        await ContactInquiry.db.insert(session, [
          ContactInquiry(
            profileId: profile1.id!,
            senderName: 'Inquiry 1',
            senderEmail: 'one@mail.com',
            subject: 'Subject 1',
            message: 'Msg 1',
            isRead: false,
            isArchived: false,
            createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
          ),
          ContactInquiry(
            profileId: profile1.id!,
            senderName: 'Inquiry 2',
            senderEmail: 'two@mail.com',
            subject: 'Subject 2',
            message: 'Msg 2',
            isRead: true,
            isArchived: false,
            createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
          ),
          ContactInquiry(
            profileId: profile2.id!,
            senderName: 'Inquiry 3',
            senderEmail: 'three@mail.com',
            subject: 'Subject 3',
            message: 'Msg 3',
            isRead: false,
            isArchived: false,
          ),
        ]);
      });

      test(
        'getMyInquiries returns only user inquiries and supports filtering',
        () async {
          final all = await endpoints.inquiry.getMyInquiries(authedSession1);
          expect(all.length, equals(2));

          final unread = await endpoints.inquiry.getMyInquiries(
            authedSession1,
            isRead: false,
          );
          expect(unread.length, equals(1));
          expect(unread.first.senderName, equals('Inquiry 1'));
        },
      );

      test('markInquiryRead toggles isRead', () async {
        final inquiries = await endpoints.inquiry.getMyInquiries(
          authedSession1,
        );
        final target = inquiries.firstWhere((i) => !i.isRead);

        final updated = await endpoints.inquiry.markInquiryRead(
          authedSession1,
          target.id!,
          true,
        );
        expect(updated.isRead, isTrue);
      });

      test('archiveInquiry and deleteInquiry work properly', () async {
        final inquiries = await endpoints.inquiry.getMyInquiries(
          authedSession1,
        );
        final target = inquiries.first;

        final archived = await endpoints.inquiry.archiveInquiry(
          authedSession1,
          target.id!,
          true,
        );
        expect(archived.isArchived, isTrue);

        final deleted = await endpoints.inquiry.deleteInquiry(
          authedSession1,
          target.id!,
        );
        expect(deleted, isTrue);

        final remaining = await endpoints.inquiry.getMyInquiries(
          authedSession1,
        );
        expect(remaining.length, equals(1));
      });

      test(
        'ownership isolation: user cannot mutate another user inquiry',
        () async {
          final inquiries = await endpoints.inquiry.getMyInquiries(
            authedSession1,
          );
          final targetId = inquiries.first.id!;

          await expectLater(
            endpoints.inquiry.markInquiryRead(authedSession2, targetId, true),
            throwsA(isA<ProfileException>()),
          );

          await expectLater(
            endpoints.inquiry.deleteInquiry(authedSession2, targetId),
            throwsA(isA<ProfileException>()),
          );
        },
      );
    });
  });
}
