import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import '../../../auth/logic/providers/auth_providers.dart';
import '../repo/public_profile_repository.dart';

final publicProfileRepositoryProvider = Provider<PublicProfileRepository>((
  ref,
) {
  return PublicProfileRepository(ref.watch(clientProvider));
});

final publicProfileFamilyProvider =
    FutureProvider.autoDispose.family<PublicProfileData?, String>((
      ref,
      handle,
    ) async {
      final repo = ref.watch(publicProfileRepositoryProvider);
      return await repo.getPublicProfile(handle);
    });
