import 'package:professional_identity_client/professional_identity_client.dart';
import 'inquiry_repository.dart';

class ServerpodInquiryRepository implements InquiryRepository {
  final Client _client;

  ServerpodInquiryRepository(this._client);

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
    return await _client.inquiry.submitPublicInquiry(
      handle,
      senderName,
      senderEmail,
      subject,
      message,
      inquiryType,
      honeypot: honeypot,
    );
  }

  @override
  Future<List<ContactInquiry>> getMyInquiries({
    bool? isRead,
    bool? isArchived,
  }) async {
    return await _client.inquiry.getMyInquiries(
      isRead: isRead,
      isArchived: isArchived,
    );
  }

  @override
  Future<ContactInquiry> markInquiryRead({
    required int inquiryId,
    required bool isRead,
  }) async {
    return await _client.inquiry.markInquiryRead(inquiryId, isRead);
  }

  @override
  Future<ContactInquiry> archiveInquiry({
    required int inquiryId,
    required bool isArchived,
  }) async {
    return await _client.inquiry.archiveInquiry(inquiryId, isArchived);
  }

  @override
  Future<bool> deleteInquiry({
    required int inquiryId,
  }) async {
    return await _client.inquiry.deleteInquiry(inquiryId);
  }
}
