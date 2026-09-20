import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import '../../../auth/logic/providers/auth_providers.dart';
import '../../../public_profile/logic/providers/public_profile_providers.dart';
import '../repo/profile_repository.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(ref.watch(clientProvider));
});

/// Notifier managing current user's profile state.
class UserProfileNotifier extends AsyncNotifier<Profile?> {
  @override
  FutureOr<Profile?> build() async {
    final repo = ref.watch(profileRepositoryProvider);
    // When auth state changes, re-evaluate
    final isAuthed = ref.watch(authStateProvider).valueOrNull ?? false;
    if (!isAuthed) return null;

    return await repo.getMyProfile();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await ref.read(profileRepositoryProvider).getMyProfile();
    });
  }

  Future<Profile> saveProfile({
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
    final repo = ref.read(profileRepositoryProvider);
    final saved = await repo.saveMyProfile(
      handle: handle,
      fullName: fullName,
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
    state = AsyncData(saved);
    ref.invalidate(publicProfileFamilyProvider);
    return saved;
  }
}

final userProfileNotifierProvider =
    AsyncNotifierProvider<UserProfileNotifier, Profile?>(
      UserProfileNotifier.new,
    );
