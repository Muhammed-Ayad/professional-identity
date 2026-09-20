import 'package:serverpod/serverpod.dart';

import '../common/auth_profile_helper.dart';
import '../generated/protocol.dart';

class CustomizationEndpoint extends Endpoint {
  static const allowedThemePresets = {
    'minimal',
    'modern',
    'professional',
    'dark',
  };
  static const allowedBackgroundStyles = {'solid', 'subtle_gradient'};
  static const allowedCardStyles = {'outlined', 'elevated', 'flat'};
  static const allowedBorderRadii = {'small', 'medium', 'large'};
  static const allowedTypographyStyles = {'modern', 'classic', 'compact'};

  static final _hexColorRegex = RegExp(r'^#([0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})$');

  /// Fetches the profile customization for the authenticated user.
  Future<ProfileCustomization?> getCustomization(Session session) async {
    final profile = await getAuthenticatedProfile(session);
    return await ProfileCustomization.db.findFirstRow(
      session,
      where: (t) => t.profileId.equals(profile.id!),
    );
  }

  /// Updates or creates the profile customization for the authenticated user.
  Future<ProfileCustomization> updateCustomization(
    Session session,
    String themePreset,
    String? primaryColor,
    String backgroundStyle,
    String cardStyle,
    String borderRadius,
    String typographyStyle,
  ) async {
    final profile = await getAuthenticatedProfile(session);

    // 1. Validate theme preset
    final normTheme = themePreset.trim().toLowerCase();
    if (!allowedThemePresets.contains(normTheme)) {
      throw ProfileException(
        message:
            'Invalid theme preset: $themePreset. Allowed: ${allowedThemePresets.join(', ')}',
      );
    }

    // 2. Validate background style
    final normBackground = backgroundStyle.trim().toLowerCase();
    if (!allowedBackgroundStyles.contains(normBackground)) {
      throw ProfileException(
        message:
            'Invalid background style: $backgroundStyle. Allowed: ${allowedBackgroundStyles.join(', ')}',
      );
    }

    // 3. Validate card style
    final normCard = cardStyle.trim().toLowerCase();
    if (!allowedCardStyles.contains(normCard)) {
      throw ProfileException(
        message:
            'Invalid card style: $cardStyle. Allowed: ${allowedCardStyles.join(', ')}',
      );
    }

    // 4. Validate border radius
    final normRadius = borderRadius.trim().toLowerCase();
    if (!allowedBorderRadii.contains(normRadius)) {
      throw ProfileException(
        message:
            'Invalid border radius: $borderRadius. Allowed: ${allowedBorderRadii.join(', ')}',
      );
    }

    // 5. Validate typography style
    final normTypography = typographyStyle.trim().toLowerCase();
    if (!allowedTypographyStyles.contains(normTypography)) {
      throw ProfileException(
        message:
            'Invalid typography style: $typographyStyle. Allowed: ${allowedTypographyStyles.join(', ')}',
      );
    }

    // 6. Validate primary color
    String? normColor;
    if (primaryColor != null && primaryColor.trim().isNotEmpty) {
      var trimmedColor = primaryColor.trim();
      if (!trimmedColor.startsWith('#')) {
        trimmedColor = '#$trimmedColor';
      }
      trimmedColor = trimmedColor.toUpperCase();

      if (!_hexColorRegex.hasMatch(trimmedColor)) {
        throw ProfileException(
          message:
              'Invalid primary color format: $primaryColor. Expected hex color (e.g. #2563EB).',
        );
      }
      normColor = trimmedColor;
    }

    // 7. Upsert customization
    final existing = await ProfileCustomization.db.findFirstRow(
      session,
      where: (t) => t.profileId.equals(profile.id!),
    );

    if (existing != null) {
      existing.themePreset = normTheme;
      existing.primaryColor = normColor;
      existing.backgroundStyle = normBackground;
      existing.cardStyle = normCard;
      existing.borderRadius = normRadius;
      existing.typographyStyle = normTypography;
      existing.updatedAt = DateTime.now();

      return await ProfileCustomization.db.updateRow(session, existing);
    } else {
      final newCustomization = ProfileCustomization(
        profileId: profile.id!,
        themePreset: normTheme,
        primaryColor: normColor,
        backgroundStyle: normBackground,
        cardStyle: normCard,
        borderRadius: normRadius,
        typographyStyle: normTypography,
        updatedAt: DateTime.now(),
      );

      return await ProfileCustomization.db.insertRow(session, newCustomization);
    }
  }

  /// Fetches the profile customization for a public profile.
  /// Returns null if the profile does not exist or is private.
  Future<ProfileCustomization?> getPublicCustomization(
    Session session,
    String handle,
  ) async {
    final normalized = handle.trim().toLowerCase();
    if (normalized.isEmpty) return null;

    final profile = await Profile.db.findFirstRow(
      session,
      where: (t) => t.handle.equals(normalized) & t.isPublic.equals(true),
    );

    if (profile == null || !profile.isPublic) {
      return null;
    }

    return await ProfileCustomization.db.findFirstRow(
      session,
      where: (t) => t.profileId.equals(profile.id!),
    );
  }
}
