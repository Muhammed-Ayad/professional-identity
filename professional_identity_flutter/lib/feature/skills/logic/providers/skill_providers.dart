import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import '../../../auth/logic/providers/auth_providers.dart';
import '../../../public_profile/logic/providers/public_profile_providers.dart';
import '../repo/skill_repository.dart';

final skillRepositoryProvider = Provider<SkillRepository>((ref) {
  return SkillRepository(ref.watch(clientProvider));
});

class SkillsNotifier extends AsyncNotifier<List<Skill>> {
  @override
  FutureOr<List<Skill>> build() async {
    final isAuthed = ref.watch(authStateProvider).valueOrNull ?? false;
    if (!isAuthed) return [];
    return await ref.watch(skillRepositoryProvider).getMySkills();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await ref.read(skillRepositoryProvider).getMySkills();
    });
  }

  Future<Skill> addSkill(
    String name, {
    String? category,
    int? yearsOfExperience,
  }) async {
    final newSkill = await ref
        .read(skillRepositoryProvider)
        .createSkill(
          name,
          category: category,
          yearsOfExperience: yearsOfExperience,
        );
    state = AsyncData([...state.valueOrNull ?? [], newSkill]);
    ref.invalidate(publicProfileFamilyProvider);
    return newSkill;
  }

  Future<Skill> updateSkill(
    int skillId,
    String name, {
    String? category,
    int? yearsOfExperience,
  }) async {
    final updated = await ref
        .read(skillRepositoryProvider)
        .updateSkill(
          skillId,
          name,
          category: category,
          yearsOfExperience: yearsOfExperience,
        );
    state = AsyncData(
      (state.valueOrNull ?? [])
          .map((s) => s.id == skillId ? updated : s)
          .toList(),
    );
    ref.invalidate(publicProfileFamilyProvider);
    return updated;
  }

  Future<void> deleteSkill(int skillId) async {
    await ref.read(skillRepositoryProvider).deleteSkill(skillId);
    state = AsyncData(
      (state.valueOrNull ?? []).where((s) => s.id != skillId).toList(),
    );
    ref.invalidate(publicProfileFamilyProvider);
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final current = List<Skill>.from(state.valueOrNull ?? []);
    final item = current.removeAt(oldIndex);
    current.insert(newIndex, item);
    state = AsyncData(current);

    final ids = current.map((s) => s.id!).toList();
    await ref.read(skillRepositoryProvider).reorderSkills(ids);
    ref.invalidate(publicProfileFamilyProvider);
  }
}

final skillsNotifierProvider =
    AsyncNotifierProvider<SkillsNotifier, List<Skill>>(
      SkillsNotifier.new,
    );
