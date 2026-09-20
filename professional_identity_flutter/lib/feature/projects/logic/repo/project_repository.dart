import 'package:professional_identity_client/professional_identity_client.dart';

class ProjectRepository {
  final Client _client;

  ProjectRepository(this._client);

  Future<List<Project>> getMyProjects() async {
    return await _client.project.getMyProjects();
  }

  Future<Project> createProject({
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
    return await _client.project.createProject(
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
    return await _client.project.updateProject(
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
  }

  Future<void> deleteProject(int projectId) async {
    await _client.project.deleteProject(projectId);
  }

  Future<void> reorderProjects(List<int> projectIds) async {
    await _client.project.reorderProjects(projectIds);
  }
}
