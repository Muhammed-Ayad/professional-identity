import 'package:flutter/material.dart';
import 'package:professional_identity_client/professional_identity_client.dart';
import 'package:professional_identity_flutter/feature/profile_customization/logic/models/profile_customization_theme.dart';

ThemeData buildPublicProfileTheme({
  required ProfileCustomization? customization,
  required ThemeData fallbackTheme,
}) {
  final custom =
      customization ?? ProfileCustomizationTheme.defaultCustomization;
  final isDark = custom.themePreset == 'dark';
  final primaryColor = ProfileCustomizationTheme.parseColor(
    custom.primaryColor,
  );
  final baseTheme = isDark
      ? ThemeData.dark(useMaterial3: true)
      : ThemeData.light(useMaterial3: true);
  final cardShape = ProfileCustomizationTheme.getCardShape(
    custom.cardStyle,
    custom.borderRadius,
    borderColor: isDark
        ? Colors.white.withValues(alpha: 0.15)
        : fallbackTheme.colorScheme.outlineVariant.withValues(alpha: 0.5),
  );
  final cardElevation = ProfileCustomizationTheme.getCardElevation(
    custom.cardStyle,
  );
  final cardBgColor = isDark
      ? const Color(0xFF161E2E)
      : (custom.cardStyle == 'flat' ? const Color(0xFFF1F5F9) : Colors.white);
  final textTheme = ProfileCustomizationTheme.getTypography(
    custom.typographyStyle,
    baseTheme.textTheme,
  );

  return baseTheme.copyWith(
    colorScheme: baseTheme.colorScheme.copyWith(
      primary: primaryColor,
      secondary: primaryColor,
      surface: cardBgColor,
    ),
    cardTheme: CardThemeData(
      color: cardBgColor,
      elevation: cardElevation,
      shape: cardShape,
    ),
    textTheme: textTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            ProfileCustomizationTheme.getBorderRadius(
                  custom.borderRadius,
                ) /
                2,
          ),
        ),
      ),
    ),
  );
}
