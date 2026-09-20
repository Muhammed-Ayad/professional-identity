import 'package:professional_identity_client/professional_identity_client.dart';

class PublicProfileRepository {
  final Client _client;

  PublicProfileRepository(this._client);

  Future<PublicProfileData?> getPublicProfile(String handle) async {
    return await _client.publicProfile.getPublicProfile(handle);
  }
}
