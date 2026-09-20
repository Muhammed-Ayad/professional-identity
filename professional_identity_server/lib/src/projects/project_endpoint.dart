import 'package:serverpod/serverpod.dart';

import '../common/auth_profile_helper.dart';
import '../generated/protocol.dart';

class ProjectEndpoint extends Endpoint {
  Future<List<Project>> getMyProjects(Session session) async {
    final profile = await getAuthenticatedProfile(session);
    return await Project.db.find(
      session,
      where: (t) => t.profileId.equals(profile.id!),
      orderBy: (t) => t.sortOrder.asc(),
    );
  }

  Future<Project> createProject(
    Session session, {
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
    final profile = await getAuthenticatedProfile(session);
    final validatedTitle = _validateAndSanitizeTitle(title);
    final validatedDesc = _validateAndSanitizeDescription(description);
    final validatedRole = _validateAndSanitizeRole(role);
    final validatedTechs = _validateTechnologies(technologies);
    final validatedUrl = _validateUrl(url, 'Project URL');
    final validatedRepoUrl = _validateUrl(repositoryUrl, 'Repository URL');
    _validateDates(
      startDate: startDate,
      endDate: endDate,
      isOngoing: isOngoing,
    );

    final count = await Project.db.count(
      session,
      where: (t) => t.profileId.equals(profile.id!),
    );

    final now = DateTime.now();
    final project = Project(
      profileId: profile.id!,
      title: validatedTitle,
      description: validatedDesc,
      role: validatedRole,
      url: validatedUrl,
      repositoryUrl: validatedRepoUrl,
      imageUrl: imageUrl?.trim().isEmpty == true ? null : imageUrl?.trim(),
      technologies: validatedTechs,
      startDate: startDate,
      endDate: isOngoing ? null : endDate,
      isOngoing: isOngoing,
      sortOrder: count,
      createdAt: now,
      updatedAt: now,
    );

    return await Project.db.insertRow(session, project);
  }

  Future<Project> updateProject(
    Session session, {
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
    final profile = await getAuthenticatedProfile(session);
    final existing = await Project.db.findById(session, projectId);
    if (existing == null || existing.profileId != profile.id) {
      throw ProfileException(message: 'Project not found or unauthorized.');
    }

    final validatedTitle = _validateAndSanitizeTitle(title);
    final validatedDesc = _validateAndSanitizeDescription(description);
    final validatedRole = _validateAndSanitizeRole(role);
    final validatedTechs = _validateTechnologies(technologies);
    final validatedUrl = _validateUrl(url, 'Project URL');
    final validatedRepoUrl = _validateUrl(repositoryUrl, 'Repository URL');
    _validateDates(
      startDate: startDate,
      endDate: endDate,
      isOngoing: isOngoing,
    );

    existing.title = validatedTitle;
    existing.description = validatedDesc;
    existing.role = validatedRole;
    existing.url = validatedUrl;
    existing.repositoryUrl = validatedRepoUrl;
    existing.imageUrl = imageUrl?.trim().isEmpty == true
        ? null
        : imageUrl?.trim();
    existing.technologies = validatedTechs;
    existing.startDate = startDate;
    existing.endDate = isOngoing ? null : endDate;
    existing.isOngoing = isOngoing;
    existing.updatedAt = DateTime.now();

    return await Project.db.updateRow(session, existing);
  }

  Future<void> deleteProject(Session session, int projectId) async {
    final profile = await getAuthenticatedProfile(session);
    final existing = await Project.db.findById(session, projectId);
    if (existing == null || existing.profileId != profile.id) {
      throw ProfileException(message: 'Project not found or unauthorized.');
    }

    await Project.db.deleteRow(session, existing);
  }

  Future<void> reorderProjects(Session session, List<int> projectIds) async {
    final profile = await getAuthenticatedProfile(session);
    final userProjects = await Project.db.find(
      session,
      where: (t) => t.profileId.equals(profile.id!),
    );

    final userProjectIds = userProjects.map((p) => p.id!).toSet();
    if (projectIds.length != userProjects.length ||
        !projectIds.every(userProjectIds.contains)) {
      throw ProfileException(
        message: 'Invalid project IDs provided for reordering.',
      );
    }

    final now = DateTime.now();
    await session.db.transaction((transaction) async {
      for (var i = 0; i < projectIds.length; i++) {
        final project = userProjects.firstWhere((p) => p.id == projectIds[i]);
        project.sortOrder = i;
        project.updatedAt = now;
        await Project.db.updateRow(session, project, transaction: transaction);
      }
    });
  }

  String _validateAndSanitizeTitle(String title) {
    final trimmed = title.trim();
    if (trimmed.isEmpty) {
      throw ProfileException(message: 'Project title cannot be empty.');
    }
    if (trimmed.length > 100) {
      throw ProfileException(
        message: 'Project title must not exceed 100 characters.',
      );
    }
    return trimmed;
  }

  String? _validateAndSanitizeDescription(String? description) {
    if (description == null || description.trim().isEmpty) return null;
    final trimmed = description.trim();
    if (trimmed.length > 2000) {
      throw ProfileException(
        message: 'Project description must not exceed 2000 characters.',
      );
    }
    return trimmed;
  }

  String? _validateAndSanitizeRole(String? role) {
    if (role == null || role.trim().isEmpty) return null;
    final trimmed = role.trim();
    if (trimmed.length > 100) {
      throw ProfileException(
        message: 'Project role must not exceed 100 characters.',
      );
    }
    return trimmed;
  }

  List<String> _validateTechnologies(List<String> technologies) {
    if (technologies.any((t) => t.trim().isEmpty)) {
      throw ProfileException(
        message: 'Technologies list cannot contain empty values.',
      );
    }
    return technologies.map((t) => t.trim()).toList();
  }

  String? _validateUrl(String? rawUrl, String fieldName) {
    if (rawUrl == null || rawUrl.trim().isEmpty) return null;
    final trimmed = rawUrl.trim();
    final uri = Uri.tryParse(trimmed);
    if (uri == null ||
        (!uri.hasScheme || (uri.scheme != 'http' && uri.scheme != 'https')) ||
        uri.host.isEmpty) {
      throw ProfileException(
        message:
            '$fieldName must be a valid URL (starting with http:// or https://).',
      );
    }
    return trimmed;
  }

  void _validateDates({
    DateTime? startDate,
    DateTime? endDate,
    required bool isOngoing,
  }) {
    if (isOngoing && endDate != null) {
      throw ProfileException(
        message: 'Ongoing projects cannot have an end date.',
      );
    }
    if (startDate != null && endDate != null && endDate.isBefore(startDate)) {
      throw ProfileException(
        message: 'Project end date cannot be before start date.',
      );
    }
  }
}
