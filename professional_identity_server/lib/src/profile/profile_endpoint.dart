import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';

class ProfileEndpoint extends Endpoint {
  /// Fetches the profile of the currently authenticated user, or null if they haven't set one up yet.
  Future<Profile?> getMyProfile(Session session) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw ProfileException(message: 'User is not authenticated.');
    }
    return await Profile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
  }

  /// Gets a public profile by its unique handle.
  /// Only returns the profile if `isPublic` is true.
  Future<Profile?> getPublicProfile(Session session, String handle) async {
    final normalized = handle.trim().toLowerCase();
    if (normalized.isEmpty) return null;

    return await Profile.db.findFirstRow(
      session,
      where: (t) => t.handle.equals(normalized) & t.isPublic.equals(true),
    );
  }

  /// Checks whether a handle is available for registration or update.
  Future<bool> isHandleAvailable(Session session, String handle) async {
    final normalized = handle.trim().toLowerCase();
    if (normalized.length < 3) return false;

    // Check handle format: alphanumeric and hyphen/underscore only
    final validFormat = RegExp(r'^[a-z0-9_-]+$').hasMatch(normalized);
    if (!validFormat) return false;

    final currentAuthUserId = session.authenticated?.authUserId;
    final existing = await Profile.db.findFirstRow(
      session,
      where: (t) => t.handle.equals(normalized),
    );

    if (existing == null) return true;
    if (currentAuthUserId != null && existing.authUserId == currentAuthUserId) {
      return true;
    }
    return false;
  }

  /// Creates or updates the authenticated user's profile.
  Future<Profile> saveMyProfile(
    Session session,
    String handle,
    String fullName, {
    String? headline,
    String? bio,
    String? location,
    String? currentRole,
    int? yearsOfExperience,
    String? availability,
    String? contactEmail,
    String? websiteUrl,
    String? avatarUrl,
    bool? isPublic,
  }) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw ProfileException(message: 'User is not authenticated.');
    }

    final normalizedHandle = handle.trim().toLowerCase();
    if (normalizedHandle.length < 3) {
      throw ProfileException(
        message: 'Handle must be at least 3 characters long.',
      );
    }
    if (!RegExp(r'^[a-z0-9_-]+$').hasMatch(normalizedHandle)) {
      throw ProfileException(
        message:
            'Handle may only contain lowercase letters, numbers, hyphens, and underscores.',
      );
    }
    if (fullName.trim().isEmpty) {
      throw ProfileException(message: 'Full name cannot be empty.');
    }

    // Check handle collision
    final existingWithHandle = await Profile.db.findFirstRow(
      session,
      where: (t) => t.handle.equals(normalizedHandle),
    );
    if (existingWithHandle != null &&
        existingWithHandle.authUserId != authUserId) {
      throw ProfileException(message: 'Handle is already taken.');
    }

    final existingProfile = await Profile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );

    final now = DateTime.now();
    if (existingProfile == null) {
      final newProfile = Profile(
        authUserId: authUserId,
        handle: normalizedHandle,
        fullName: fullName.trim(),
        headline: headline?.trim(),
        bio: bio?.trim(),
        location: location?.trim(),
        currentRole: currentRole?.trim(),
        yearsOfExperience: yearsOfExperience,
        availability: availability?.trim(),
        contactEmail: contactEmail?.trim(),
        websiteUrl: websiteUrl?.trim(),
        avatarUrl: avatarUrl?.trim(),
        isPublic: isPublic ?? true,
        createdAt: now,
        updatedAt: now,
      );
      return await Profile.db.insertRow(session, newProfile);
    } else {
      final updated = existingProfile.copyWith(
        handle: normalizedHandle,
        fullName: fullName.trim(),
        headline: headline?.trim(),
        bio: bio?.trim(),
        location: location?.trim(),
        currentRole: currentRole?.trim(),
        yearsOfExperience: yearsOfExperience,
        availability: availability?.trim(),
        contactEmail: contactEmail?.trim(),
        websiteUrl: websiteUrl?.trim(),
        avatarUrl: avatarUrl?.trim(),
        isPublic: isPublic ?? existingProfile.isPublic,
        updatedAt: now,
      );
      return await Profile.db.updateRow(session, updated);
    }
  }
}
