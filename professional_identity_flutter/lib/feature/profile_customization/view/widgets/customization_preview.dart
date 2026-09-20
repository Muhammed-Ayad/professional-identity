import 'package:flutter/material.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import '../../logic/models/profile_customization_theme.dart';
import 'customization_browser_frame.dart';
import 'customization_preview_cards.dart';
import 'customization_preview_header.dart';

class CustomizationPreview extends StatelessWidget {
  final Profile? profile;
  final ProfileCustomization customization;

  const CustomizationPreview({
    super.key,
    required this.profile,
    required this.customization,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = customization.themePreset == 'dark';
    final primary = ProfileCustomizationTheme.parseColor(
      customization.primaryColor,
    );
    final cardShape = ProfileCustomizationTheme.getCardShape(
      customization.cardStyle,
      customization.borderRadius,
      borderColor: isDark
          ? Colors.white.withValues(alpha: 0.15)
          : theme.colorScheme.outlineVariant.withValues(alpha: 0.6),
    );
    final cardElevation = ProfileCustomizationTheme.getCardElevation(
      customization.cardStyle,
    );
    final cardBgColor = isDark
        ? const Color(0xFF161E2E)
        : (customization.cardStyle == 'flat'
              ? const Color(0xFFF1F5F9)
              : Colors.white);
    final textTheme = ProfileCustomizationTheme.getTypography(
      customization.typographyStyle,
      isDark ? ThemeData.dark().textTheme : theme.textTheme,
    );
    final textColor = isDark
        ? const Color(0xFFF8FAFC)
        : const Color(0xFF0F172A);
    final textSubColor = isDark
        ? const Color(0xFF94A3B8)
        : const Color(0xFF64748B);

    final displayHandle = profile?.handle ?? 'alex-morgan';

    return CustomizationBrowserFrame(
      isDark: isDark,
      displayHandle: displayHandle,
      child: Container(
        decoration: ProfileCustomizationTheme.getBackgroundDecoration(
          customization: customization,
          isDark: isDark,
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomizationPreviewHeaderCard(
              profile: profile,
              customization: customization,
              cardBgColor: cardBgColor,
              cardElevation: cardElevation,
              cardShape: cardShape,
              primary: primary,
              textColor: textColor,
              textSubColor: textSubColor,
              textTheme: textTheme,
            ),
            const SizedBox(height: 14),
            CustomizationPreviewSkillsCard(
              cardBgColor: cardBgColor,
              cardElevation: cardElevation,
              cardShape: cardShape,
              primary: primary,
              textColor: textColor,
              textTheme: textTheme,
            ),
            const SizedBox(height: 14),
            CustomizationPreviewProjectCard(
              cardBgColor: cardBgColor,
              cardElevation: cardElevation,
              cardShape: cardShape,
              primary: primary,
              textColor: textColor,
              textSubColor: textSubColor,
              textTheme: textTheme,
            ),
          ],
        ),
      ),
    );
  }
}
