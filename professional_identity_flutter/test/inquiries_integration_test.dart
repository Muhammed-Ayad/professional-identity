import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import 'package:professional_identity_flutter/client.dart';
import 'package:professional_identity_flutter/core/theme/app_theme.dart';
import 'package:professional_identity_flutter/feature/dashboard/view/screens/dashboard_screen.dart';
import 'package:professional_identity_flutter/feature/inquiries/logic/providers/inquiry_providers.dart';
import 'package:professional_identity_flutter/feature/inquiries/logic/repo/inquiry_repository.dart';
import 'package:professional_identity_flutter/feature/inquiries/view/screens/inquiries_screen.dart';
import 'package:professional_identity_flutter/feature/inquiries/view/widgets/contact_inquiry_dialog.dart';
import 'package:professional_identity_flutter/feature/profile/logic/providers/profile_providers.dart';
import 'package:professional_identity_flutter/feature/public_profile/logic/providers/public_profile_providers.dart';
import 'package:professional_identity_flutter/feature/public_profile/view/screens/public_profile_screen.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

class _FakeIntegrationInquiryRepo implements InquiryRepository {
  @override
  Future<bool> submitPublicInquiry({
    required String handle,
    required String senderName,
    required String senderEmail,
    required String subject,
    required String message,
    required String inquiryType,
    String? honeypot,
  }) async => true;

  @override
  Future<List<ContactInquiry>> getMyInquiries({
    bool? isRead,
    bool? isArchived,
  }) async => [];

  @override
  Future<ContactInquiry> markInquiryRead({
    required int inquiryId,
    required bool isRead,
  }) async => throw UnimplementedError();

  @override
  Future<ContactInquiry> archiveInquiry({
    required int inquiryId,
    required bool isArchived,
  }) async => throw UnimplementedError();

  @override
  Future<bool> deleteInquiry({required int inquiryId}) async => true;
}

class _MockProfileNotifier extends UserProfileNotifier {
  final Profile? _profile;
  _MockProfileNotifier(this._profile);

  @override
  Future<Profile?> build() async => _profile;
}

void main() {
  setUpAll(() {
    client = Client('http://localhost:8080/')
      ..connectivityMonitor = FlutterConnectivityMonitor()
      ..authSessionManager = FlutterAuthSessionManager();
  });

  testWidgets(
    'PublicProfileScreen renders Get In Touch and opens ContactInquiryDialog',
    (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1280, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final publicProfile = PublicProfileData(
        handle: 'mohamed-ayad',
        fullName: 'Mohamed Ayad',
        isPublic: true,
        skills: [],
        experiences: [],
        projects: [],
        socialLinks: [],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            inquiryRepositoryProvider.overrideWithValue(
              _FakeIntegrationInquiryRepo(),
            ),
            publicProfileFamilyProvider('mohamed-ayad').overrideWith(
              (ref) => publicProfile,
            ),
          ],
          child: const MaterialApp(
            home: PublicProfileScreen(handle: 'mohamed-ayad'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Get In Touch'), findsOneWidget);
      expect(find.text('Send Message'), findsOneWidget);

      await tester.tap(find.text('Send Message'));
      await tester.pumpAndSettle();

      expect(find.byType(ContactInquiryDialog), findsOneWidget);
      expect(find.text('Contact Mohamed Ayad'), findsOneWidget);
    },
  );

  testWidgets(
    'DashboardScreen renders Contact Inquiries module and navigates to InquiriesScreen',
    (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1280, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final profile = Profile(
        id: 1,
        authUserId: UuidValue.fromString(
          '00000000-0000-0000-0000-000000000001',
        ),
        handle: 'mohamed-ayad',
        fullName: 'Mohamed Ayad',
        isPublic: true,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            inquiryRepositoryProvider.overrideWithValue(
              _FakeIntegrationInquiryRepo(),
            ),
            userProfileNotifierProvider.overrideWith(
              () => _MockProfileNotifier(profile),
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const DashboardScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Contact Inquiries'), findsOneWidget);
      expect(find.text('View Inquiries'), findsOneWidget);

      await tester.scrollUntilVisible(find.text('View Inquiries'), 300);
      await tester.pumpAndSettle();
      await tester.tap(find.text('View Inquiries'));
      await tester.pumpAndSettle();

      expect(find.byType(InquiriesScreen), findsOneWidget);
    },
  );
}
