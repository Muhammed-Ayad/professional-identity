import 'package:professional_identity_client/professional_identity_client.dart';

abstract class InquiryRepository {
  Future<bool> submitPublicInquiry({
    required String handle,
    required String senderName,
    required String senderEmail,
    required String subject,
    required String message,
    required String inquiryType,
    String? honeypot,
  });

  Future<List<ContactInquiry>> getMyInquiries({
    bool? isRead,
    bool? isArchived,
  });

  Future<ContactInquiry> markInquiryRead({
    required int inquiryId,
    required bool isRead,
  });

  Future<ContactInquiry> archiveInquiry({
    required int inquiryId,
    required bool isArchived,
  });

  Future<bool> deleteInquiry({
    required int inquiryId,
  });
}
