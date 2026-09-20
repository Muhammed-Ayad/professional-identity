import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import '../../../auth/logic/providers/auth_providers.dart';
import '../../../public_profile/logic/providers/public_profile_providers.dart';
import '../repo/social_link_repository.dart';

final socialLinkRepositoryProvider = Provider<SocialLinkRepository>((ref) {
  return SocialLinkRepository(ref.watch(clientProvider));
});

class SocialLinksNotifier extends AsyncNotifier<List<SocialLink>> {
  @override
  FutureOr<List<SocialLink>> build() async {
    final isAuthed = ref.watch(authStateProvider).valueOrNull ?? false;
    if (!isAuthed) return [];
    return await ref.watch(socialLinkRepositoryProvider).getMySocialLinks();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await ref.read(socialLinkRepositoryProvider).getMySocialLinks();
    });
  }

  Future<SocialLink> addSocialLink(
    String platform,
    String url, {
    String? label,
  }) async {
    final created = await ref
        .read(socialLinkRepositoryProvider)
        .createSocialLink(
          platform,
          url,
          label: label,
        );
    state = AsyncData([...state.valueOrNull ?? [], created]);
    ref.invalidate(publicProfileFamilyProvider);
    return created;
  }

  Future<SocialLink> updateSocialLink(
    int linkId,
    String platform,
    String url, {
    String? label,
  }) async {
    final updated = await ref
        .read(socialLinkRepositoryProvider)
        .updateSocialLink(
          linkId,
          platform,
          url,
          label: label,
        );
    state = AsyncData(
      (state.valueOrNull ?? [])
          .map((l) => l.id == linkId ? updated : l)
          .toList(),
    );
    ref.invalidate(publicProfileFamilyProvider);
    return updated;
  }

  Future<void> deleteSocialLink(int linkId) async {
    await ref.read(socialLinkRepositoryProvider).deleteSocialLink(linkId);
    state = AsyncData(
      (state.valueOrNull ?? []).where((l) => l.id != linkId).toList(),
    );
    ref.invalidate(publicProfileFamilyProvider);
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final current = List<SocialLink>.from(state.valueOrNull ?? []);
    final item = current.removeAt(oldIndex);
    current.insert(newIndex, item);
    state = AsyncData(current);

    final ids = current.map((l) => l.id!).toList();
    await ref.read(socialLinkRepositoryProvider).reorderSocialLinks(ids);
    ref.invalidate(publicProfileFamilyProvider);
  }
}

final socialLinksNotifierProvider =
    AsyncNotifierProvider<SocialLinksNotifier, List<SocialLink>>(
      SocialLinksNotifier.new,
    );
