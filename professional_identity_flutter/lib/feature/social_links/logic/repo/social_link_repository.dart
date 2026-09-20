import 'package:professional_identity_client/professional_identity_client.dart';

class SocialLinkRepository {
  final Client _client;

  SocialLinkRepository(this._client);

  Future<List<SocialLink>> getMySocialLinks() async {
    return await _client.socialLink.getMySocialLinks();
  }

  Future<SocialLink> createSocialLink(
    String platform,
    String url, {
    String? label,
  }) async {
    return await _client.socialLink.createSocialLink(
      platform,
      url,
      label: label,
    );
  }

  Future<SocialLink> updateSocialLink(
    int linkId,
    String platform,
    String url, {
    String? label,
  }) async {
    return await _client.socialLink.updateSocialLink(
      linkId,
      platform,
      url,
      label: label,
    );
  }

  Future<bool> deleteSocialLink(int linkId) async {
    return await _client.socialLink.deleteSocialLink(linkId);
  }

  Future<bool> reorderSocialLinks(List<int> linkIds) async {
    return await _client.socialLink.reorderSocialLinks(linkIds);
  }
}
