import 'dart:async';
import 'dart:typed_data';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../auth/logic/providers/auth_providers.dart';
import '../../../profile/logic/providers/profile_providers.dart';
import '../../../public_profile/logic/providers/public_profile_providers.dart';
import '../repo/cv_repository.dart';

final cvRepositoryProvider = Provider<CvRepository>((ref) {
  return CvRepository(ref.watch(clientProvider));
});

class CvNotifier extends AsyncNotifier<String?> {
  @override
  FutureOr<String?> build() async {
    final isAuthed = ref.watch(authStateProvider).valueOrNull ?? false;
    if (!isAuthed) return null;

    final profile = ref.watch(userProfileNotifierProvider).valueOrNull;
    if (profile != null) {
      return profile.cvUrl;
    }
    return await ref.watch(cvRepositoryProvider).getMyCv();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await ref.read(cvRepositoryProvider).getMyCv();
    });
  }

  Future<String> uploadCv(String fileName, ByteData fileBytes) async {
    final url = await ref
        .read(cvRepositoryProvider)
        .uploadCv(fileName, fileBytes);
    state = AsyncData(url);
    // Refresh profile so cvUrl in profile is kept in sync across dashboard
    ref.read(userProfileNotifierProvider.notifier).refresh();
    ref.invalidate(publicProfileFamilyProvider);
    return url;
  }

  Future<void> deleteCv() async {
    await ref.read(cvRepositoryProvider).deleteCv();
    state = const AsyncData(null);
    ref.read(userProfileNotifierProvider.notifier).refresh();
    ref.invalidate(publicProfileFamilyProvider);
  }
}

final cvNotifierProvider = AsyncNotifierProvider<CvNotifier, String?>(
  CvNotifier.new,
);
