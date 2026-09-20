import 'package:serverpod/serverpod.dart';
import '../common/auth_profile_helper.dart';
import '../generated/protocol.dart';

class SkillEndpoint extends Endpoint {
  /// Fetches all skills for the current authenticated user's profile, ordered by sortOrder.
  Future<List<Skill>> getMySkills(Session session) async {
    final profile = await getAuthenticatedProfile(session);
    return await Skill.db.find(
      session,
      where: (t) => t.profileId.equals(profile.id!),
      orderBy: (t) => t.sortOrder,
    );
  }

  /// Creates a new skill for the authenticated user's profile.
  Future<Skill> createSkill(
    Session session,
    String name, {
    String? category,
    int? yearsOfExperience,
  }) async {
    final profile = await getAuthenticatedProfile(session);

    final trimmedName = name.trim();
    if (trimmedName.isEmpty) {
      throw ProfileException(message: 'Skill name cannot be empty.');
    }
    if (trimmedName.length > 50) {
      throw ProfileException(
        message: 'Skill name cannot exceed 50 characters.',
      );
    }
    if (yearsOfExperience != null && yearsOfExperience < 0) {
      throw ProfileException(
        message: 'Years of experience cannot be negative.',
      );
    }

    final trimmedCategory = category?.trim();
    if (trimmedCategory != null && trimmedCategory.length > 50) {
      throw ProfileException(
        message: 'Category cannot exceed 50 characters.',
      );
    }

    // Determine current max sortOrder
    final existing = await Skill.db.find(
      session,
      where: (t) => t.profileId.equals(profile.id!),
      orderBy: (t) => t.sortOrder.desc(),
      limit: 1,
    );
    final nextSortOrder = (existing.firstOrNull?.sortOrder ?? -1) + 1;

    final now = DateTime.now();
    final newSkill = Skill(
      profileId: profile.id!,
      name: trimmedName,
      category: trimmedCategory?.isEmpty == true ? null : trimmedCategory,
      yearsOfExperience: yearsOfExperience,
      sortOrder: nextSortOrder,
      createdAt: now,
      updatedAt: now,
    );

    return await Skill.db.insertRow(session, newSkill);
  }

  /// Updates an existing skill owned by the authenticated user.
  Future<Skill> updateSkill(
    Session session,
    int skillId,
    String name, {
    String? category,
    int? yearsOfExperience,
  }) async {
    final profile = await getAuthenticatedProfile(session);

    final skill = await Skill.db.findById(session, skillId);
    if (skill == null || skill.profileId != profile.id) {
      throw ProfileException(message: 'Skill not found or unauthorized.');
    }

    final trimmedName = name.trim();
    if (trimmedName.isEmpty) {
      throw ProfileException(message: 'Skill name cannot be empty.');
    }
    if (trimmedName.length > 50) {
      throw ProfileException(
        message: 'Skill name cannot exceed 50 characters.',
      );
    }
    if (yearsOfExperience != null && yearsOfExperience < 0) {
      throw ProfileException(
        message: 'Years of experience cannot be negative.',
      );
    }

    final trimmedCategory = category?.trim();
    if (trimmedCategory != null && trimmedCategory.length > 50) {
      throw ProfileException(
        message: 'Category cannot exceed 50 characters.',
      );
    }

    final updated = skill.copyWith(
      name: trimmedName,
      category: trimmedCategory?.isEmpty == true ? null : trimmedCategory,
      yearsOfExperience: yearsOfExperience,
      updatedAt: DateTime.now(),
    );

    return await Skill.db.updateRow(session, updated);
  }

  /// Deletes an existing skill owned by the authenticated user.
  Future<bool> deleteSkill(Session session, int skillId) async {
    final profile = await getAuthenticatedProfile(session);

    final skill = await Skill.db.findById(session, skillId);
    if (skill == null || skill.profileId != profile.id) {
      throw ProfileException(message: 'Skill not found or unauthorized.');
    }

    await Skill.db.deleteRow(session, skill);
    return true;
  }

  /// Reorders skills according to the list of IDs for the authenticated user.
  Future<bool> reorderSkills(Session session, List<int> skillIds) async {
    final profile = await getAuthenticatedProfile(session);

    final mySkills = await Skill.db.find(
      session,
      where: (t) => t.profileId.equals(profile.id!),
    );
    final skillMap = {for (final s in mySkills) s.id!: s};

    final now = DateTime.now();
    for (var i = 0; i < skillIds.length; i++) {
      final skillId = skillIds[i];
      final skill = skillMap[skillId];
      if (skill != null && skill.sortOrder != i) {
        await Skill.db.updateRow(
          session,
          skill.copyWith(sortOrder: i, updatedAt: now),
        );
      }
    }

    return true;
  }
}
