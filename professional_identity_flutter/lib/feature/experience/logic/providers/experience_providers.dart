import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import '../../../auth/logic/providers/auth_providers.dart';
import '../../../public_profile/logic/providers/public_profile_providers.dart';
import '../repo/experience_repository.dart';

final experienceRepositoryProvider = Provider<ExperienceRepository>((ref) {
  return ExperienceRepository(ref.watch(clientProvider));
});

class ExperienceNotifier extends AsyncNotifier<List<Experience>> {
  @override
  FutureOr<List<Experience>> build() async {
    final isAuthed = ref.watch(authStateProvider).valueOrNull ?? false;
    if (!isAuthed) return [];
    return await ref.watch(experienceRepositoryProvider).getMyExperience();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await ref.read(experienceRepositoryProvider).getMyExperience();
    });
  }

  Future<Experience> addExperience({
    required String company,
    required String jobTitle,
    required DateTime startDate,
    DateTime? endDate,
    bool isCurrent = false,
    String? description,
  }) async {
    final created = await ref
        .read(experienceRepositoryProvider)
        .createExperience(
          company: company,
          jobTitle: jobTitle,
          startDate: startDate,
          endDate: endDate,
          isCurrent: isCurrent,
          description: description,
        );
    state = AsyncData([...state.valueOrNull ?? [], created]);
    ref.invalidate(publicProfileFamilyProvider);
    return created;
  }

  Future<Experience> updateExperience({
    required int experienceId,
    required String company,
    required String jobTitle,
    required DateTime startDate,
    DateTime? endDate,
    bool isCurrent = false,
    String? description,
  }) async {
    final updated = await ref
        .read(experienceRepositoryProvider)
        .updateExperience(
          experienceId: experienceId,
          company: company,
          jobTitle: jobTitle,
          startDate: startDate,
          endDate: endDate,
          isCurrent: isCurrent,
          description: description,
        );
    state = AsyncData(
      (state.valueOrNull ?? [])
          .map((e) => e.id == experienceId ? updated : e)
          .toList(),
    );
    ref.invalidate(publicProfileFamilyProvider);
    return updated;
  }

  Future<void> deleteExperience(int experienceId) async {
    await ref.read(experienceRepositoryProvider).deleteExperience(experienceId);
    state = AsyncData(
      (state.valueOrNull ?? []).where((e) => e.id != experienceId).toList(),
    );
    ref.invalidate(publicProfileFamilyProvider);
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final current = List<Experience>.from(state.valueOrNull ?? []);
    final item = current.removeAt(oldIndex);
    current.insert(newIndex, item);
    state = AsyncData(current);

    final ids = current.map((e) => e.id!).toList();
    await ref.read(experienceRepositoryProvider).reorderExperience(ids);
    ref.invalidate(publicProfileFamilyProvider);
  }
}

final experienceNotifierProvider =
    AsyncNotifierProvider<ExperienceNotifier, List<Experience>>(
      ExperienceNotifier.new,
    );
