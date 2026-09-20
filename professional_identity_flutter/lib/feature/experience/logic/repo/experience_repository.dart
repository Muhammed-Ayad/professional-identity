import 'package:professional_identity_client/professional_identity_client.dart';

class ExperienceRepository {
  final Client _client;

  ExperienceRepository(this._client);

  Future<List<Experience>> getMyExperience() async {
    return await _client.experience.getMyExperience();
  }

  Future<Experience> createExperience({
    required String company,
    required String jobTitle,
    required DateTime startDate,
    DateTime? endDate,
    bool isCurrent = false,
    String? description,
  }) async {
    return await _client.experience.createExperience(
      company,
      jobTitle,
      startDate,
      endDate: endDate,
      isCurrent: isCurrent,
      description: description,
    );
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
    return await _client.experience.updateExperience(
      experienceId,
      company,
      jobTitle,
      startDate,
      endDate: endDate,
      isCurrent: isCurrent,
      description: description,
    );
  }

  Future<bool> deleteExperience(int experienceId) async {
    return await _client.experience.deleteExperience(experienceId);
  }

  Future<bool> reorderExperience(List<int> experienceIds) async {
    return await _client.experience.reorderExperience(experienceIds);
  }
}
