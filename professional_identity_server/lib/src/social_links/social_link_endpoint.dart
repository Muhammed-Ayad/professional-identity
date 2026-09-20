import 'package:serverpod/serverpod.dart';
import '../common/auth_profile_helper.dart';
import '../generated/protocol.dart';

class SocialLinkEndpoint extends Endpoint {
  /// Fetches all social links for the authenticated user's profile.
  Future<List<SocialLink>> getMySocialLinks(Session session) async {
    final profile = await getAuthenticatedProfile(session);
    return await SocialLink.db.find(
      session,
      where: (t) => t.profileId.equals(profile.id!),
      orderBy: (t) => t.sortOrder,
    );
  }

  /// Creates a new social link for the user's profile.
  Future<SocialLink> createSocialLink(
    Session session,
    String platform,
    String url, {
    String? label,
  }) async {
    final profile = await getAuthenticatedProfile(session);

    _validateSocialLink(platform: platform, url: url, label: label);

    final existing = await SocialLink.db.find(
      session,
      where: (t) => t.profileId.equals(profile.id!),
      orderBy: (t) => t.sortOrder.desc(),
      limit: 1,
    );
    final nextSortOrder = (existing.firstOrNull?.sortOrder ?? -1) + 1;

    final now = DateTime.now();
    final newLink = SocialLink(
      profileId: profile.id!,
      platform: platform.trim().toLowerCase(),
      url: url.trim(),
      label: label?.trim().isEmpty == true ? null : label?.trim(),
      sortOrder: nextSortOrder,
      createdAt: now,
      updatedAt: now,
    );

    return await SocialLink.db.insertRow(session, newLink);
  }

  /// Updates an existing social link owned by the user.
  Future<SocialLink> updateSocialLink(
    Session session,
    int linkId,
    String platform,
    String url, {
    String? label,
  }) async {
    final profile = await getAuthenticatedProfile(session);

    final link = await SocialLink.db.findById(session, linkId);
    if (link == null || link.profileId != profile.id) {
      throw ProfileException(message: 'Social link not found or unauthorized.');
    }

    _validateSocialLink(platform: platform, url: url, label: label);

    final updated = link.copyWith(
      platform: platform.trim().toLowerCase(),
      url: url.trim(),
      label: label?.trim().isEmpty == true ? null : label?.trim(),
      updatedAt: DateTime.now(),
    );

    return await SocialLink.db.updateRow(session, updated);
  }

  /// Deletes a social link owned by the user.
  Future<bool> deleteSocialLink(Session session, int linkId) async {
    final profile = await getAuthenticatedProfile(session);

    final link = await SocialLink.db.findById(session, linkId);
    if (link == null || link.profileId != profile.id) {
      throw ProfileException(message: 'Social link not found or unauthorized.');
    }

    await SocialLink.db.deleteRow(session, link);
    return true;
  }

  /// Reorders social links for the authenticated user.
  Future<bool> reorderSocialLinks(Session session, List<int> linkIds) async {
    final profile = await getAuthenticatedProfile(session);

    final myLinks = await SocialLink.db.find(
      session,
      where: (t) => t.profileId.equals(profile.id!),
    );
    final linkMap = {for (final l in myLinks) l.id!: l};

    final now = DateTime.now();
    for (var i = 0; i < linkIds.length; i++) {
      final id = linkIds[i];
      final item = linkMap[id];
      if (item != null && item.sortOrder != i) {
        await SocialLink.db.updateRow(
          session,
          item.copyWith(sortOrder: i, updatedAt: now),
        );
      }
    }

    return true;
  }

  void _validateSocialLink({
    required String platform,
    required String url,
    required String? label,
  }) {
    if (platform.trim().isEmpty) {
      throw ProfileException(message: 'Platform cannot be empty.');
    }
    if (platform.trim().length > 50) {
      throw ProfileException(message: 'Platform cannot exceed 50 characters.');
    }
    final trimmedUrl = url.trim();
    if (trimmedUrl.isEmpty) {
      throw ProfileException(message: 'URL cannot be empty.');
    }
    final uri = Uri.tryParse(trimmedUrl);
    if (uri == null || (!uri.isScheme('http') && !uri.isScheme('https'))) {
      throw ProfileException(
        message: 'Please provide a valid URL starting with http:// or https://',
      );
    }
    if (label != null && label.length > 100) {
      throw ProfileException(message: 'Label cannot exceed 100 characters.');
    }
  }
}
