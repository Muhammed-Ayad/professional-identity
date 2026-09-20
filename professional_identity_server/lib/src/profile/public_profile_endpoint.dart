import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class PublicProfileEndpoint extends Endpoint {
  /// Fetches a complete public professional profile by handle without authentication.
  /// Returns null if the profile does not exist or if isPublic is false.
  Future<PublicProfileData?> getPublicProfile(
    Session session,
    String handle,
  ) async {
    final normalized = handle.trim().toLowerCase();
    if (normalized.isEmpty) return null;

    // Server-side privacy enforcement: only retrieve profiles where isPublic == true
    final profile = await Profile.db.findFirstRow(
      session,
      where: (t) => t.handle.equals(normalized) & t.isPublic.equals(true),
    );

    if (profile == null || !profile.isPublic) {
      return null;
    }

    final profileId = profile.id!;

    // Fetch related public collections ordered by custom sortOrder
    final skills = await Skill.db.find(
      session,
      where: (t) => t.profileId.equals(profileId),
      orderBy: (t) => t.sortOrder.asc(),
    );

    final experiences = await Experience.db.find(
      session,
      where: (t) => t.profileId.equals(profileId),
      orderBy: (t) => t.sortOrder.asc(),
    );

    final projects = await Project.db.find(
      session,
      where: (t) => t.profileId.equals(profileId),
      orderBy: (t) => t.sortOrder.asc(),
    );

    final socialLinks = await SocialLink.db.find(
      session,
      where: (t) => t.profileId.equals(profileId),
      orderBy: (t) => t.sortOrder.asc(),
    );

    final customization = await ProfileCustomization.db.findFirstRow(
      session,
      where: (t) => t.profileId.equals(profileId),
    );

    return PublicProfileData(
      handle: profile.handle,
      fullName: profile.fullName,
      headline: profile.headline,
      bio: profile.bio,
      location: profile.location,
      currentRole: profile.currentRole,
      yearsOfExperience: profile.yearsOfExperience,
      availability: profile.availability,
      contactEmail: profile.contactEmail,
      websiteUrl: profile.websiteUrl,
      avatarUrl: profile.avatarUrl,
      cvUrl: profile.cvUrl,
      isPublic: profile.isPublic,
      skills: skills,
      experiences: experiences,
      projects: projects,
      socialLinks: socialLinks,
      customization: customization,
    );
  }
}
