import 'package:serverpod/serverpod.dart';
import '../common/auth_profile_helper.dart';
import '../generated/protocol.dart';

class InquiryEndpoint extends Endpoint {
  static const allowedInquiryTypes = {
    'general',
    'job_offer',
    'freelance',
    'collaboration',
    'speaking',
  };

  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$',
  );

  /// Submits a contact inquiry to a public profile.
  /// Unauthenticated endpoint for visitors.
  Future<bool> submitPublicInquiry(
    Session session,
    String handle,
    String senderName,
    String senderEmail,
    String subject,
    String message,
    String inquiryType, {
    String? honeypot,
  }) async {
    // 1. Anti-bot honeypot check
    if (honeypot != null && honeypot.trim().isNotEmpty) {
      // Silently succeed to fool spammers
      return true;
    }

    final normalizedHandle = handle.trim().toLowerCase();
    if (normalizedHandle.isEmpty) {
      throw ProfileException(message: 'Handle cannot be empty.');
    }

    // 2. Validate input fields
    final cleanName = senderName.trim();
    if (cleanName.isEmpty) {
      throw ProfileException(message: 'Name cannot be empty.');
    }
    if (cleanName.length > 100) {
      throw ProfileException(message: 'Name cannot exceed 100 characters.');
    }

    final cleanEmail = senderEmail.trim().toLowerCase();
    if (cleanEmail.isEmpty || !_emailRegex.hasMatch(cleanEmail)) {
      throw ProfileException(message: 'Please provide a valid email address.');
    }
    if (cleanEmail.length > 254) {
      throw ProfileException(message: 'Email cannot exceed 254 characters.');
    }

    final cleanSubject = subject.trim();
    if (cleanSubject.isEmpty) {
      throw ProfileException(message: 'Subject cannot be empty.');
    }
    if (cleanSubject.length > 150) {
      throw ProfileException(message: 'Subject cannot exceed 150 characters.');
    }

    final cleanMessage = message.trim();
    if (cleanMessage.isEmpty) {
      throw ProfileException(message: 'Message cannot be empty.');
    }
    if (cleanMessage.length > 3000) {
      throw ProfileException(message: 'Message cannot exceed 3000 characters.');
    }

    final cleanType = inquiryType.trim().toLowerCase();
    final effectiveType = allowedInquiryTypes.contains(cleanType)
        ? cleanType
        : 'general';

    // 3. Resolve public profile
    final profile = await Profile.db.findFirstRow(
      session,
      where: (t) => t.handle.equals(normalizedHandle) & t.isPublic.equals(true),
    );

    if (profile == null || profile.id == null) {
      throw ProfileException(message: 'Profile not found or is not public.');
    }

    // 4. Save inquiry
    final inquiry = ContactInquiry(
      profileId: profile.id!,
      senderName: cleanName,
      senderEmail: cleanEmail,
      subject: cleanSubject,
      message: cleanMessage,
      inquiryType: effectiveType,
      isRead: false,
      isArchived: false,
      createdAt: DateTime.now(),
    );

    await ContactInquiry.db.insertRow(session, inquiry);

    // 5. Track inquiry submission in analytics pipeline
    try {
      await ProfileAnalyticsEvent.db.insertRow(
        session,
        ProfileAnalyticsEvent(
          profileId: profile.id!,
          eventType: 'inquiry_received',
          target: effectiveType,
          createdAt: DateTime.now(),
        ),
      );
    } catch (_) {
      // Non-critical logging failure should not abort inquiry submission
    }

    return true;
  }

  /// Fetches all inquiries for the authenticated user's profile.
  Future<List<ContactInquiry>> getMyInquiries(
    Session session, {
    bool? isRead,
    bool? isArchived,
  }) async {
    final profile = await getAuthenticatedProfile(session);
    final profileId = profile.id!;

    return await ContactInquiry.db.find(
      session,
      where: (t) {
        var expression = t.profileId.equals(profileId);
        if (isRead != null) {
          expression = expression & t.isRead.equals(isRead);
        }
        if (isArchived != null) {
          expression = expression & t.isArchived.equals(isArchived);
        }
        return expression;
      },
      orderBy: (t) => t.createdAt.desc(),
    );
  }

  /// Toggles read/unread status of an inquiry owned by the authenticated user.
  Future<ContactInquiry> markInquiryRead(
    Session session,
    int inquiryId,
    bool isRead,
  ) async {
    final profile = await getAuthenticatedProfile(session);

    final inquiry = await ContactInquiry.db.findById(session, inquiryId);
    if (inquiry == null || inquiry.profileId != profile.id) {
      throw ProfileException(
        message: 'Inquiry not found or access unauthorized.',
      );
    }

    inquiry.isRead = isRead;
    return await ContactInquiry.db.updateRow(session, inquiry);
  }

  /// Toggles archive status of an inquiry owned by the authenticated user.
  Future<ContactInquiry> archiveInquiry(
    Session session,
    int inquiryId,
    bool isArchived,
  ) async {
    final profile = await getAuthenticatedProfile(session);

    final inquiry = await ContactInquiry.db.findById(session, inquiryId);
    if (inquiry == null || inquiry.profileId != profile.id) {
      throw ProfileException(
        message: 'Inquiry not found or access unauthorized.',
      );
    }

    inquiry.isArchived = isArchived;
    return await ContactInquiry.db.updateRow(session, inquiry);
  }

  /// Deletes an inquiry owned by the authenticated user.
  Future<bool> deleteInquiry(Session session, int inquiryId) async {
    final profile = await getAuthenticatedProfile(session);

    final inquiry = await ContactInquiry.db.findById(session, inquiryId);
    if (inquiry == null || inquiry.profileId != profile.id) {
      throw ProfileException(
        message: 'Inquiry not found or access unauthorized.',
      );
    }

    await ContactInquiry.db.deleteRow(session, inquiry);
    return true;
  }
}
