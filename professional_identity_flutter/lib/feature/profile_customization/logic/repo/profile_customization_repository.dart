import 'package:professional_identity_client/professional_identity_client.dart';
import '../../../../client.dart';

class ProfileCustomizationRepository {
  /// Fetches customization for the authenticated user.
  Future<ProfileCustomization?> getCustomization() async {
    return await client.customization.getCustomization();
  }

  /// Updates or creates the profile customization for the authenticated user.
  Future<ProfileCustomization> updateCustomization({
    required String themePreset,
    required String? primaryColor,
    required String backgroundStyle,
    required String cardStyle,
    required String borderRadius,
    required String typographyStyle,
  }) async {
    return await client.customization.updateCustomization(
      themePreset,
      primaryColor,
      backgroundStyle,
      cardStyle,
      borderRadius,
      typographyStyle,
    );
  }

  /// Fetches customization for a public profile handle.
  Future<ProfileCustomization?> getPublicCustomization(String handle) async {
    return await client.customization.getPublicCustomization(handle);
  }
}
