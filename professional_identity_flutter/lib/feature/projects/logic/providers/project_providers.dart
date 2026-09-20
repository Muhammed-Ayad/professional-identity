import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import '../../../auth/logic/providers/auth_providers.dart';
import '../../../public_profile/logic/providers/public_profile_providers.dart';
import '../repo/project_repository.dart';

final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  return ProjectRepository(ref.watch(clientProvider));
});

class ProjectsNotifier extends AsyncNotifier<List<Project>> {
  @override
  FutureOr<List<Project>> build() async {
    final isAuthed = ref.watch(authStateProvider).valueOrNull ?? false;
    if (!isAuthed) return [];
    return await ref.watch(projectRepositoryProvider).getMyProjects();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await ref.read(projectRepositoryProvider).getMyProjects();
    });
  }

  Future<Project> addProject({
    required String title,
    String? description,
    String? role,
    String? url,
    String? repositoryUrl,
    String? imageUrl,
    required List<String> technologies,
    DateTime? startDate,
    DateTime? endDate,
    bool isOngoing = false,
  }) async {
    final newProject = await ref
        .read(projectRepositoryProvider)
        .createProject(
          title: title,
          description: description,
          role: role,
          url: url,
          repositoryUrl: repositoryUrl,
          imageUrl: imageUrl,
          technologies: technologies,
          startDate: startDate,
          endDate: endDate,
          isOngoing: isOngoing,
        );
    state = AsyncData([...state.valueOrNull ?? [], newProject]);
    ref.invalidate(publicProfileFamilyProvider);
    return newProject;
  }

  Future<Project> updateProject({
    required int projectId,
    required String title,
    String? description,
    String? role,
    String? url,
    String? repositoryUrl,
    String? imageUrl,
    required List<String> technologies,
    DateTime? startDate,
    DateTime? endDate,
    required bool isOngoing,
  }) async {
    final updated = await ref
        .read(projectRepositoryProvider)
        .updateProject(
          projectId: projectId,
          title: title,
          description: description,
          role: role,
          url: url,
          repositoryUrl: repositoryUrl,
          imageUrl: imageUrl,
          technologies: technologies,
          startDate: startDate,
          endDate: endDate,
          isOngoing: isOngoing,
        );
    state = AsyncData(
      (state.valueOrNull ?? [])
          .map((p) => p.id == projectId ? updated : p)
          .toList(),
    );
    ref.invalidate(publicProfileFamilyProvider);
    return updated;
  }

  Future<void> deleteProject(int projectId) async {
    await ref.read(projectRepositoryProvider).deleteProject(projectId);
    state = AsyncData(
      (state.valueOrNull ?? []).where((p) => p.id != projectId).toList(),
    );
    ref.invalidate(publicProfileFamilyProvider);
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final current = List<Project>.from(state.valueOrNull ?? []);
    final item = current.removeAt(oldIndex);
    current.insert(newIndex, item);
    state = AsyncData(current);

    final ids = current.map((p) => p.id!).toList();
    await ref.read(projectRepositoryProvider).reorderProjects(ids);
    ref.invalidate(publicProfileFamilyProvider);
  }
}

final projectsNotifierProvider =
    AsyncNotifierProvider<ProjectsNotifier, List<Project>>(
      ProjectsNotifier.new,
    );
