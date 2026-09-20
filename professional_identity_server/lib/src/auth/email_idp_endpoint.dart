import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
class EmailIdpEndpoint extends EmailIdpBaseEndpoint {
  @override
  Future<UuidValue> startRegistration(
    final Session session, {
    required final String email,
  }) async {
    final normalized = email.trim().toLowerCase();
    final existingAccountCount = await EmailAccount.db.count(
      session,
      where: (final t) => t.email.equals(normalized),
    );
    if (existingAccountCount > 0) {
      throw EmailAccountRequestException(
        reason: EmailAccountRequestExceptionReason.invalid,
      );
    }

    return super.startRegistration(session, email: email);
  }
}
