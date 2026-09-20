import 'package:professional_identity_client/professional_identity_client.dart';

class SkillRepository {
  final Client _client;

  SkillRepository(this._client);

  Future<List<Skill>> getMySkills() async {
    return await _client.skill.getMySkills();
  }

  Future<Skill> createSkill(
    String name, {
    String? category,
    int? yearsOfExperience,
  }) async {
    return await _client.skill.createSkill(
      name,
      category: category,
      yearsOfExperience: yearsOfExperience,
    );
  }

  Future<Skill> updateSkill(
    int skillId,
    String name, {
    String? category,
    int? yearsOfExperience,
  }) async {
    return await _client.skill.updateSkill(
      skillId,
      name,
      category: category,
      yearsOfExperience: yearsOfExperience,
    );
  }

  Future<bool> deleteSkill(int skillId) async {
    return await _client.skill.deleteSkill(skillId);
  }

  Future<bool> reorderSkills(List<int> skillIds) async {
    return await _client.skill.reorderSkills(skillIds);
  }
}
