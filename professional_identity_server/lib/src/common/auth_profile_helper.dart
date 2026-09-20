import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';

/// Helper to resolve the authenticated user's [Profile] or throw a [ProfileException].
Future<Profile> getAuthenticatedProfile(Session session) async {
  final authUserId = session.authenticated?.authUserId;
  if (authUserId == null) {
    throw ProfileException(message: 'User is not authenticated.');
  }

  final profile = await Profile.db.findFirstRow(
    session,
    where: (t) => t.authUserId.equals(authUserId),
  );

  if (profile == null) {
    throw ProfileException(message: 'Please create a profile first.');
  }

  return profile;
}
