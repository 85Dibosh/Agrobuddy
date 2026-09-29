import 'package:flutter/material.dart';

class AppTheme {
  // Brand Colors
  static const Color darkBackground = Color(0xFF121B13);
  static const Color surfaceDark = Color(0xFF14201A);
  static const Color cardBackground = Color(0xFF1E2C1F);
  static const Color cardAltBackground = Color(0xFF1E2B22);
  static const Color cardHighlight = Color(0xFF2E3B23);
  static const Color pillBackground = Color(0xFF24301B);

  // Accent & Action Colors
  static const Color primaryGold = Color(0xFFD4A017);
  static const Color secondaryGold = Color(0xFFE5B800);
  static const Color goldLight = Color(0xFFE5A93C);
  static const Color errorRed = Color(0xFFE55353);
  static const Color successGreen = Color(0xFF2ECC71);

  // Text Colors
  static const Color textLight = Colors.white;
  static const Color textMuted = Color(0xFFA0AAB0);
  static const Color textSecondary = Color(0xFF8E9B90);
  static const Color textSubtle = Color(0xFFB0BEB4);
  static const Color textDark = Color(0xFF14201A);

  // Border Colors
  static const Color borderMuted = Color(0xFF2E3B23);
  static const Color borderLight = Color(0xFF556845);

  /// Main theme configuration for MaterialApp
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      primaryColor: primaryGold,
      colorScheme: const ColorScheme.dark(
        primary: primaryGold,
        secondary: secondaryGold,
        surface: surfaceDark,
        error: errorRed,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackground,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGold,
          foregroundColor: textDark,
          elevation: 0,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardHighlight,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: const TextStyle(color: textMuted, fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: primaryGold, width: 1.5),
        ),
      ),
    );
  }
}
