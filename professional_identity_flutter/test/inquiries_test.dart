import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import 'package:professional_identity_flutter/client.dart';
import 'package:professional_identity_flutter/core/theme/app_theme.dart';
import 'package:professional_identity_flutter/feature/inquiries/logic/providers/inquiry_providers.dart';
import 'package:professional_identity_flutter/feature/inquiries/logic/repo/inquiry_repository.dart';
import 'package:professional_identity_flutter/feature/inquiries/view/screens/inquiries_screen.dart';
import 'package:professional_identity_flutter/feature/inquiries/view/widgets/contact_inquiry_dialog.dart';
import 'package:professional_identity_flutter/feature/inquiries/view/widgets/inquiry_details_dialog.dart';
import 'package:professional_identity_flutter/feature/inquiries/view/widgets/inquiry_item_card.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

class FakeInquiryRepository implements InquiryRepository {
  List<ContactInquiry> inquiries;
  final List<Map<String, dynamic>> submittedInquiries = [];

  FakeInquiryRepository(this.inquiries);

  @override
  Future<bool> submitPublicInquiry({
    required String handle,
    required String senderName,
    required String senderEmail,
    required String subject,
    required String message,
    required String inquiryType,
    String? honeypot,
  }) async {
    submittedInquiries.add({
      'handle': handle,
      'senderName': senderName,
      'senderEmail': senderEmail,
      'subject': subject,
      'message': message,
      'inquiryType': inquiryType,
      'honeypot': honeypot,
    });
    return true;
  }

  @override
  Future<List<ContactInquiry>> getMyInquiries({
    bool? isRead,
    bool? isArchived,
  }) async {
    return inquiries.where((item) {
      if (isRead != null && item.isRead != isRead) return false;
      if (isArchived != null && item.isArchived != isArchived) return false;
      return true;
    }).toList();
  }

  @override
  Future<ContactInquiry> markInquiryRead({
    required int inquiryId,
    required bool isRead,
  }) async {
    final index = inquiries.indexWhere((i) => i.id == inquiryId);
    final updated = inquiries[index].copyWith(isRead: isRead);
    inquiries[index] = updated;
    return updated;
  }

  @override
  Future<ContactInquiry> archiveInquiry({
    required int inquiryId,
    required bool isArchived,
  }) async {
    final index = inquiries.indexWhere((i) => i.id == inquiryId);
    final updated = inquiries[index].copyWith(isArchived: isArchived);
    inquiries[index] = updated;
    return updated;
  }

  @override
  Future<bool> deleteInquiry({required int inquiryId}) async {
    inquiries.removeWhere((i) => i.id == inquiryId);
    return true;
  }
}

void main() {
  setUpAll(() {
    client = Client('http://localhost:8080/')
      ..connectivityMonitor = FlutterConnectivityMonitor()
      ..authSessionManager = FlutterAuthSessionManager();
  });

  final sampleInquiries = [
    ContactInquiry(
      id: 1,
      profileId: 10,
      senderName: 'Sarah Recruiter',
      senderEmail: 'sarah@google.com',
      subject: 'Staff Flutter Engineer Opportunity',
      message: 'We were impressed by your open source work.',
      inquiryType: 'job_offer',
      isRead: false,
      isArchived: false,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    ContactInquiry(
      id: 2,
      profileId: 10,
      senderName: 'Alex Founder',
      senderEmail: 'alex@startup.io',
      subject: 'Freelance Advisory',
      message: 'Need 10 hours consultation.',
      inquiryType: 'freelance',
      isRead: true,
      isArchived: false,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    ContactInquiry(
      id: 3,
      profileId: 10,
      senderName: 'Old Inquiry',
      senderEmail: 'old@archive.com',
      subject: 'Archived Message',
      message: 'Archived conversation.',
      inquiryType: 'general',
      isRead: true,
      isArchived: true,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  group('ContactInquiryDialog Widget Tests', () {
    testWidgets('renders inputs and submits inquiry', (tester) async {
      tester.view.physicalSize = const Size(800, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final fakeRepo = FakeInquiryRepository([]);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [inquiryRepositoryProvider.overrideWithValue(fakeRepo)],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const Scaffold(
              body: ContactInquiryDialog(
                handle: 'mohamed-ayad',
                recipientName: 'Mohamed Ayad',
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Contact Mohamed Ayad'), findsOneWidget);
      await tester.tap(find.text('Send Inquiry'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter your name.'), findsOneWidget);

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Your Name *'),
        'Recruiter Alice',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Your Email *'),
        'alice@techcorp.com',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Subject *'),
        'Exciting Role',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Message *'),
        'Open for a call?',
      );

      await tester.tap(find.text('Send Inquiry'));
      await tester.pumpAndSettle();

      expect(fakeRepo.submittedInquiries.length, equals(1));
      expect(
        fakeRepo.submittedInquiries.first['senderName'],
        equals('Recruiter Alice'),
      );
    });
  });

  group('InquiriesScreen Management & Filtering Tests', () {
    testWidgets('renders inquiries and filters by status tabs', (tester) async {
      tester.view.physicalSize = const Size(1280, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final fakeRepo = FakeInquiryRepository(List.from(sampleInquiries));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [inquiryRepositoryProvider.overrideWithValue(fakeRepo)],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const InquiriesScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Contact Inquiries'), findsOneWidget);
      expect(find.text('1'), findsOneWidget); // unread badge
      expect(find.text('Sarah Recruiter'), findsOneWidget);
      expect(find.text('Old Inquiry'), findsNothing);

      await tester.tap(find.text('Unread'));
      await tester.pumpAndSettle();
      expect(find.text('Sarah Recruiter'), findsOneWidget);
      expect(find.text('Alex Founder'), findsNothing);

      await tester.tap(find.text('Archived'));
      await tester.pumpAndSettle();
      expect(find.text('Old Inquiry'), findsOneWidget);
    });

    testWidgets('tapping inquiry opens details dialog', (tester) async {
      tester.view.physicalSize = const Size(1280, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final fakeRepo = FakeInquiryRepository(List.from(sampleInquiries));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [inquiryRepositoryProvider.overrideWithValue(fakeRepo)],
          child: MaterialApp(
            theme: AppTheme.light(),
            home: const InquiriesScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.text('Sarah Recruiter'));
      await tester.pumpAndSettle();

      expect(find.byType(InquiryDetailsDialog), findsOneWidget);
      expect(find.text('sarah@google.com'), findsOneWidget);
      expect(find.text('Reply via Email'), findsOneWidget);
    });
  });

  group('Multi-Viewport Responsive Verification for Inquiries', () {
    const viewports = [
      Size(320, 568),
      Size(390, 844),
      Size(768, 1024),
      Size(1440, 900),
    ];

    for (final size in viewports) {
      testWidgets(
        'renders cleanly at ${size.width}x${size.height} with 0 overflows',
        (
          tester,
        ) async {
          tester.view.physicalSize = size;
          tester.view.devicePixelRatio = 1.0;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);

          final fakeRepo = FakeInquiryRepository(List.from(sampleInquiries));

          await tester.pumpWidget(
            ProviderScope(
              overrides: [
                inquiryRepositoryProvider.overrideWithValue(fakeRepo),
              ],
              child: MaterialApp(
                theme: AppTheme.light(),
                home: const InquiriesScreen(),
              ),
            ),
          );

          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
          expect(find.text('Contact Inquiries'), findsOneWidget);
          expect(find.byType(InquiryItemCard), findsWidgets);
        },
      );
    }
  });
}
