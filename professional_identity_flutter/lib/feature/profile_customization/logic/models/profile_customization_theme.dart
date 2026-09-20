import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:professional_identity_client/professional_identity_client.dart';

class ProfileColorOption {
  final String hex;
  final String label;
  final Color color;

  const ProfileColorOption({
    required this.hex,
    required this.label,
    required this.color,
  });
}

class ThemePresetOption {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final String defaultColor;
  final String backgroundStyle;
  final String cardStyle;
  final String borderRadius;
  final String typographyStyle;

  const ThemePresetOption({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.defaultColor,
    required this.backgroundStyle,
    required this.cardStyle,
    required this.borderRadius,
    required this.typographyStyle,
  });
}

class ProfileCustomizationTheme {
  static const List<ProfileColorOption> colorPalette = [
    ProfileColorOption(
      hex: '#2563EB',
      label: 'Royal Blue',
      color: Color(0xFF2563EB),
    ),
    ProfileColorOption(
      hex: '#4F46E5',
      label: 'Indigo',
      color: Color(0xFF4F46E5),
    ),
    ProfileColorOption(
      hex: '#059669',
      label: 'Emerald',
      color: Color(0xFF059669),
    ),
    ProfileColorOption(
      hex: '#7C3AED',
      label: 'Violet',
      color: Color(0xFF7C3AED),
    ),
    ProfileColorOption(hex: '#E11D48', label: 'Rose', color: Color(0xFFE11D48)),
    ProfileColorOption(
      hex: '#D97706',
      label: 'Amber',
      color: Color(0xFFD97706),
    ),
    ProfileColorOption(hex: '#0D9488', label: 'Teal', color: Color(0xFF0D9488)),
    ProfileColorOption(
      hex: '#334155',
      label: 'Slate',
      color: Color(0xFF334155),
    ),
  ];

  static const List<ThemePresetOption> presets = [
    ThemePresetOption(
      id: 'minimal',
      name: 'Minimal',
      description:
          'Clean, understated design with crisp outlines and subtle slate accents.',
      icon: Icons.crop_square_rounded,
      defaultColor: '#334155',
      backgroundStyle: 'solid',
      cardStyle: 'outlined',
      borderRadius: 'medium',
      typographyStyle: 'modern',
    ),
    ThemePresetOption(
      id: 'modern',
      name: 'Modern',
      description:
          'Dynamic gradient backdrop, rounded cards, and vibrant royal blue highlights.',
      icon: Icons.auto_awesome_rounded,
      defaultColor: '#2563EB',
      backgroundStyle: 'subtle_gradient',
      cardStyle: 'elevated',
      borderRadius: 'large',
      typographyStyle: 'modern',
    ),
    ThemePresetOption(
      id: 'professional',
      name: 'Professional',
      description:
          'Structured corporate framing, executive serif accents, and deep indigo tones.',
      icon: Icons.workspace_premium_rounded,
      defaultColor: '#4F46E5',
      backgroundStyle: 'solid',
      cardStyle: 'outlined',
      borderRadius: 'small',
      typographyStyle: 'classic',
    ),
    ThemePresetOption(
      id: 'dark',
      name: 'Dark',
      description:
          'Sleek dark mode atmosphere with rich contrast and luminous teal accents.',
      icon: Icons.dark_mode_rounded,
      defaultColor: '#0D9488',
      backgroundStyle: 'subtle_gradient',
      cardStyle: 'elevated',
      borderRadius: 'medium',
      typographyStyle: 'modern',
    ),
  ];

  static ProfileCustomization get defaultCustomization => ProfileCustomization(
    profileId: 0,
    themePreset: 'minimal',
    primaryColor: '#2563EB',
    backgroundStyle: 'solid',
    cardStyle: 'outlined',
    borderRadius: 'medium',
    typographyStyle: 'modern',
    updatedAt: DateTime.now(),
  );

  static Color parseColor(
    String? hexString, {
    Color fallback = const Color(0xFF2563EB),
  }) {
    if (hexString == null || hexString.trim().isEmpty) return fallback;
    var clean = hexString.trim().replaceAll('#', '');
    if (clean.length == 6) {
      clean = 'FF$clean';
    }
    if (clean.length != 8) return fallback;
    final val = int.tryParse(clean, radix: 16);
    if (val == null) return fallback;
    return Color(val);
  }

  static double getBorderRadius(String radiusStyle) {
    switch (radiusStyle) {
      case 'small':
        return 8.0;
      case 'large':
        return 24.0;
      case 'medium':
      default:
        return 16.0;
    }
  }

  static ShapeBorder getCardShape(
    String cardStyle,
    String radiusStyle, {
    Color? borderColor,
  }) {
    final radius = BorderRadius.circular(getBorderRadius(radiusStyle));
    if (cardStyle == 'outlined') {
      return RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(
          color: borderColor ?? const Color(0xFFE2E8F0),
          width: 1,
        ),
      );
    }
    return RoundedRectangleBorder(borderRadius: radius);
  }

  static double getCardElevation(String cardStyle) {
    switch (cardStyle) {
      case 'elevated':
        return 3.0;
      case 'flat':
      case 'outlined':
      default:
        return 0.0;
    }
  }

  static BoxDecoration getBackgroundDecoration({
    required ProfileCustomization customization,
    required bool isDark,
  }) {
    final primary = parseColor(customization.primaryColor);
    final isPresetDark = customization.themePreset == 'dark' || isDark;

    if (customization.backgroundStyle == 'subtle_gradient') {
      if (isPresetDark) {
        return BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primary.withValues(alpha: 0.15),
              const Color(0xFF0B0F17),
              const Color(0xFF111827),
            ],
          ),
        );
      } else {
        return BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primary.withValues(alpha: 0.07),
              const Color(0xFFF8FAFC),
              Colors.white,
            ],
          ),
        );
      }
    }

    return BoxDecoration(
      color: isPresetDark ? const Color(0xFF0B0F17) : const Color(0xFFF8FAFC),
    );
  }

  static TextTheme getTypography(String typographyStyle, TextTheme baseTheme) {
    switch (typographyStyle) {
      case 'classic':
        return GoogleFonts.merriweatherTextTheme(baseTheme);
      case 'compact':
        return GoogleFonts.interTextTheme(baseTheme).copyWith(
          titleLarge: baseTheme.titleLarge?.copyWith(
            letterSpacing: -0.5,
            height: 1.15,
          ),
          headlineSmall: baseTheme.headlineSmall?.copyWith(
            letterSpacing: -0.5,
            height: 1.15,
          ),
          bodyMedium: baseTheme.bodyMedium?.copyWith(
            letterSpacing: -0.2,
            height: 1.3,
          ),
        );
      case 'modern':
      default:
        return GoogleFonts.interTextTheme(baseTheme);
    }
  }
}
