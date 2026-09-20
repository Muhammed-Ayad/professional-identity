import 'dart:typed_data';

import 'package:professional_identity_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given CV endpoint', (sessionBuilder, endpoints) {
    const user1 = '550e8400-e29b-41d4-a716-446655440009';
    const user2 = '550e8400-e29b-41d4-a716-446655440010';

    late TestSessionBuilder authed1;
    late TestSessionBuilder authed2;

    // Helper to generate valid mock PDF ByteData with '%PDF-' magic header
    ByteData createMockPdfBytes({int size = 100}) {
      final bytes = Uint8List(size);
      // '%PDF-' header
      bytes[0] = 0x25;
      bytes[1] = 0x50;
      bytes[2] = 0x44;
      bytes[3] = 0x46;
      bytes[4] = 0x2D;
      for (var i = 5; i < size; i++) {
        bytes[i] = (i % 256);
      }
      return ByteData.sublistView(bytes);
    }

    setUp(() async {
      final session = sessionBuilder.build();

      await AuthUser.db.insert(session, [
        AuthUser(
          id: UuidValue.fromString(user1),
          createdAt: DateTime.now(),
          scopeNames: {},
          blocked: false,
        ),
        AuthUser(
          id: UuidValue.fromString(user2),
          createdAt: DateTime.now(),
          scopeNames: {},
          blocked: false,
        ),
      ]);

      authed1 = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(user1, {}),
      );
      authed2 = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(user2, {}),
      );

      // Create profiles for both users
      await endpoints.profile.saveMyProfile(
        authed1,
        'cv-user-1',
        'User One',
      );
      await endpoints.profile.saveMyProfile(
        authed2,
        'cv-user-2',
        'User Two',
      );
    });

    test(
      'when unauthenticated calling getMyCv then throws ProfileException',
      () async {
        expect(
          () => endpoints.cv.getMyCv(sessionBuilder),
          throwsA(isA<ProfileException>()),
        );
      },
    );

    test(
      'when newly created profile calls getMyCv then returns null',
      () async {
        final cvUrl = await endpoints.cv.getMyCv(authed1);
        expect(cvUrl, isNull);
      },
    );

    test('when uploading non-pdf file then throws ProfileException', () async {
      final bytes = createMockPdfBytes();
      expect(
        () => endpoints.cv.uploadCv(authed1, 'resume.docx', bytes),
        throwsA(isA<ProfileException>()),
      );
    });

    test('when uploading empty file then throws ProfileException', () async {
      final emptyBytes = ByteData(0);
      expect(
        () => endpoints.cv.uploadCv(authed1, 'empty.pdf', emptyBytes),
        throwsA(isA<ProfileException>()),
      );
    });

    test(
      'when uploading file without PDF magic bytes then throws ProfileException',
      () async {
        final badBytes = ByteData(10);
        for (var i = 0; i < 10; i++) {
          badBytes.setUint8(i, 0xFF);
        }
        expect(
          () => endpoints.cv.uploadCv(authed1, 'fake.pdf', badBytes),
          throwsA(isA<ProfileException>()),
        );
      },
    );

    test(
      'when uploading file exceeding 5 MB limit then throws ProfileException',
      () async {
        final oversizeBytes = ByteData(5 * 1024 * 1024 + 1);
        oversizeBytes.setUint8(0, 0x25);
        oversizeBytes.setUint8(1, 0x50);
        oversizeBytes.setUint8(2, 0x44);
        oversizeBytes.setUint8(3, 0x46);
        oversizeBytes.setUint8(4, 0x2D);

        expect(
          () => endpoints.cv.uploadCv(authed1, 'large.pdf', oversizeBytes),
          throwsA(isA<ProfileException>()),
        );
      },
    );

    test('when uploading valid PDF then URL is saved and returned', () async {
      final validPdf = createMockPdfBytes(size: 1024);
      final url = await endpoints.cv.uploadCv(
        authed1,
        'my_resume.pdf',
        validPdf,
      );

      expect(url, isNotEmpty);
      expect(url, contains('cv.pdf'));

      final currentCv = await endpoints.cv.getMyCv(authed1);
      expect(currentCv, equals(url));

      // User 2 should not see User 1's CV
      final user2Cv = await endpoints.cv.getMyCv(authed2);
      expect(user2Cv, isNull);
    });

    test(
      'when replacing and deleting CV then profile is updated accordingly',
      () async {
        final pdf1 = createMockPdfBytes(size: 512);
        final url1 = await endpoints.cv.uploadCv(authed1, 'cv_v1.pdf', pdf1);
        expect(url1, isNotEmpty);

        final pdf2 = createMockPdfBytes(size: 1024);
        final url2 = await endpoints.cv.uploadCv(authed1, 'cv_v2.pdf', pdf2);
        expect(url2, isNotEmpty);

        // Deleting CV
        await endpoints.cv.deleteCv(authed1);
        final afterDelete = await endpoints.cv.getMyCv(authed1);
        expect(afterDelete, isNull);
      },
    );
  });
}
