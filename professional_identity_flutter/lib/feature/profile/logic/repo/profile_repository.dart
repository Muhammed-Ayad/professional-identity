import 'package:professional_identity_client/professional_identity_client.dart';

class ProfileRepository {
  final Client _client;

  ProfileRepository(this._client);

  /// Fetches current user's profile from Serverpod.
  Future<Profile?> getMyProfile() async {
    return await _client.profile.getMyProfile();
  }

  /// Fetches a public profile by handle.
  Future<Profile?> getPublicProfile(String handle) async {
    return await _client.profile.getPublicProfile(handle);
  }

  /// Checks if handle is available.
  Future<bool> isHandleAvailable(String handle) async {
    return await _client.profile.isHandleAvailable(handle);
  }

  /// Creates or updates current user's profile.
  Future<Profile> saveMyProfile({
    required String handle,
    required String fullName,
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
    return await _client.profile.saveMyProfile(
      handle,
      fullName,
      headline: headline,
      bio: bio,
      location: location,
      currentRole: currentRole,
      yearsOfExperience: yearsOfExperience,
      availability: availability,
      contactEmail: contactEmail,
      websiteUrl: websiteUrl,
      avatarUrl: avatarUrl,
      isPublic: isPublic,
    );
  }
}
