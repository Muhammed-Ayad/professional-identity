import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const primaryColor = Color(0xFF0F172A); // Slate 900
  static const primaryLight = Color(0xFF3B82F6); // Blue 500
  static const accentColor = Color(0xFF2563EB); // Royal Blue
  static const backgroundLight = Color(0xFFF8FAFC); // Slate 50
  static const cardLight = Colors.white;
  static const borderLight = Color(0xFFE2E8F0); // Slate 200
  static const textPrimaryLight = Color(0xFF0F172A);
  static const textSecondaryLight = Color(0xFF64748B); // Slate 500

  static const backgroundDark = Color(0xFF0B0F17);
  static const cardDark = Color(0xFF161E2E);
  static const borderDark = Color(0xFF2E384D);
  static const textPrimaryDark = Color(0xFFF8FAFC);
  static const textSecondaryDark = Color(0xFF94A3B8);

  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);
    final textTheme = GoogleFonts.interTextTheme(base.textTheme);

    return base.copyWith(
      scaffoldBackgroundColor: backgroundLight,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
        surface: cardLight,
        error: Color(0xFFEF4444),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textPrimaryLight,
        outline: borderLight,
      ),
      cardTheme: CardThemeData(
        color: cardLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: borderLight, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: cardLight,
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: textPrimaryLight),
        titleTextStyle: TextStyle(
          color: textPrimaryLight,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: borderLight,
        thickness: 1,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: accentColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFEF4444)),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        hintStyle: const TextStyle(color: textSecondaryLight, fontSize: 14),
        labelStyle: const TextStyle(color: textSecondaryLight, fontSize: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textPrimaryLight,
          side: const BorderSide(color: borderLight),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      textTheme: textTheme.copyWith(
        titleLarge: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: textPrimaryLight,
          letterSpacing: -0.5,
        ),
        titleMedium: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: textPrimaryLight,
        ),
        bodyLarge: textTheme.bodyLarge?.copyWith(
          color: textPrimaryLight,
        ),
        bodyMedium: textTheme.bodyMedium?.copyWith(
          color: textSecondaryLight,
        ),
      ),
    );
  }

  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);
    final textTheme = GoogleFonts.interTextTheme(base.textTheme);

    return base.copyWith(
      scaffoldBackgroundColor: backgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: Colors.white,
        secondary: primaryLight,
        surface: cardDark,
        error: Color(0xFFF87171),
        onPrimary: primaryColor,
        onSecondary: Colors.white,
        onSurface: textPrimaryDark,
        outline: borderDark,
      ),
      cardTheme: CardThemeData(
        color: cardDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: borderDark, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: cardDark,
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: textPrimaryDark),
        titleTextStyle: TextStyle(
          color: textPrimaryDark,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: borderDark,
        thickness: 1,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: borderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: borderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryLight, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        hintStyle: const TextStyle(color: textSecondaryDark, fontSize: 14),
        labelStyle: const TextStyle(color: textSecondaryDark, fontSize: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: primaryColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textPrimaryDark,
          side: const BorderSide(color: borderDark),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      textTheme: textTheme.copyWith(
        titleLarge: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: textPrimaryDark,
          letterSpacing: -0.5,
        ),
        titleMedium: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: textPrimaryDark,
        ),
        bodyLarge: textTheme.bodyLarge?.copyWith(
          color: textPrimaryDark,
        ),
        bodyMedium: textTheme.bodyMedium?.copyWith(
          color: textSecondaryDark,
        ),
      ),
    );
  }
}
