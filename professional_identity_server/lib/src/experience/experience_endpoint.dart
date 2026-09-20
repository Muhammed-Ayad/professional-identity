import 'package:serverpod/serverpod.dart';
import '../common/auth_profile_helper.dart';
import '../generated/protocol.dart';

class ExperienceEndpoint extends Endpoint {
  /// Fetches all work experiences for the authenticated user's profile.
  Future<List<Experience>> getMyExperience(Session session) async {
    final profile = await getAuthenticatedProfile(session);
    return await Experience.db.find(
      session,
      where: (t) => t.profileId.equals(profile.id!),
      orderBy: (t) => t.sortOrder,
    );
  }

  /// Creates a new work experience entry.
  Future<Experience> createExperience(
    Session session,
    String company,
    String jobTitle,
    DateTime startDate, {
    DateTime? endDate,
    bool isCurrent = false,
    String? description,
  }) async {
    final profile = await getAuthenticatedProfile(session);

    _validateExperience(
      company: company,
      jobTitle: jobTitle,
      startDate: startDate,
      endDate: endDate,
      isCurrent: isCurrent,
      description: description,
    );

    // Determine next sortOrder
    final existing = await Experience.db.find(
      session,
      where: (t) => t.profileId.equals(profile.id!),
      orderBy: (t) => t.sortOrder.desc(),
      limit: 1,
    );
    final nextSortOrder = (existing.firstOrNull?.sortOrder ?? -1) + 1;

    final now = DateTime.now();
    final newExp = Experience(
      profileId: profile.id!,
      company: company.trim(),
      jobTitle: jobTitle.trim(),
      startDate: startDate,
      endDate: isCurrent ? null : endDate,
      isCurrent: isCurrent,
      description: description?.trim().isEmpty == true
          ? null
          : description?.trim(),
      sortOrder: nextSortOrder,
      createdAt: now,
      updatedAt: now,
    );

    return await Experience.db.insertRow(session, newExp);
  }

  /// Updates an existing work experience entry owned by the user.
  Future<Experience> updateExperience(
    Session session,
    int experienceId,
    String company,
    String jobTitle,
    DateTime startDate, {
    DateTime? endDate,
    bool isCurrent = false,
    String? description,
  }) async {
    final profile = await getAuthenticatedProfile(session);

    final exp = await Experience.db.findById(session, experienceId);
    if (exp == null || exp.profileId != profile.id) {
      throw ProfileException(
        message: 'Experience entry not found or unauthorized.',
      );
    }

    _validateExperience(
      company: company,
      jobTitle: jobTitle,
      startDate: startDate,
      endDate: endDate,
      isCurrent: isCurrent,
      description: description,
    );

    final updated = exp.copyWith(
      company: company.trim(),
      jobTitle: jobTitle.trim(),
      startDate: startDate,
      endDate: isCurrent ? null : endDate,
      isCurrent: isCurrent,
      description: description?.trim().isEmpty == true
          ? null
          : description?.trim(),
      updatedAt: DateTime.now(),
    );

    return await Experience.db.updateRow(session, updated);
  }

  /// Deletes a work experience entry owned by the user.
  Future<bool> deleteExperience(Session session, int experienceId) async {
    final profile = await getAuthenticatedProfile(session);

    final exp = await Experience.db.findById(session, experienceId);
    if (exp == null || exp.profileId != profile.id) {
      throw ProfileException(
        message: 'Experience entry not found or unauthorized.',
      );
    }

    await Experience.db.deleteRow(session, exp);
    return true;
  }

  /// Reorders work experience entries for the authenticated user.
  Future<bool> reorderExperience(
    Session session,
    List<int> experienceIds,
  ) async {
    final profile = await getAuthenticatedProfile(session);

    final myExp = await Experience.db.find(
      session,
      where: (t) => t.profileId.equals(profile.id!),
    );
    final expMap = {for (final e in myExp) e.id!: e};

    final now = DateTime.now();
    for (var i = 0; i < experienceIds.length; i++) {
      final id = experienceIds[i];
      final item = expMap[id];
      if (item != null && item.sortOrder != i) {
        await Experience.db.updateRow(
          session,
          item.copyWith(sortOrder: i, updatedAt: now),
        );
      }
    }

    return true;
  }

  void _validateExperience({
    required String company,
    required String jobTitle,
    required DateTime startDate,
    required DateTime? endDate,
    required bool isCurrent,
    required String? description,
  }) {
    if (company.trim().isEmpty) {
      throw ProfileException(message: 'Company name cannot be empty.');
    }
    if (company.trim().length > 100) {
      throw ProfileException(
        message: 'Company name cannot exceed 100 characters.',
      );
    }
    if (jobTitle.trim().isEmpty) {
      throw ProfileException(message: 'Job title cannot be empty.');
    }
    if (jobTitle.trim().length > 100) {
      throw ProfileException(
        message: 'Job title cannot exceed 100 characters.',
      );
    }
    if (isCurrent && endDate != null) {
      throw ProfileException(
        message: 'Current position cannot have an end date.',
      );
    }
    if (!isCurrent && endDate != null && endDate.isBefore(startDate)) {
      throw ProfileException(
        message: 'End date cannot be before start date.',
      );
    }
    if (description != null && description.length > 2000) {
      throw ProfileException(
        message: 'Description cannot exceed 2000 characters.',
      );
    }
  }
}
