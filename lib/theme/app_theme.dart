import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFFDC2626);      // Warm Red
  static const Color primaryDark = Color(0xFFB91C1C);
  static const Color secondary = Color(0xFFF97316);    // Orange
  static const Color accent = Color(0xFFF59E0B);       // Amber
  static const Color success = Color(0xFF10B981);
  static const Color surface = Color(0xFFFFF7ED);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1C0A00);
  static const Color textSecondary = Color(0xFF78716C);
  static const Color divider = Color(0xFFE7E5E4);

  static const List<Color> categoryColors = [
    Color(0xFFF59E0B), // Breakfast - amber
    Color(0xFF10B981), // Lunch - emerald
    Color(0xFFDC2626), // Dinner - red
    Color(0xFFEC4899), // Dessert - pink
    Color(0xFFF97316), // Snacks - orange
    Color(0xFF06B6D4), // Drinks - cyan
    Color(0xFF8B5CF6), // Vegetarian - violet
    Color(0xFF3B82F6), // International - blue
  ];

  static LinearGradient get heroGradient => const LinearGradient(
        colors: [Color(0xFFDC2626), Color(0xFFF97316)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static BoxShadow get cardShadow => BoxShadow(
        color: const Color(0xFFDC2626).withOpacity(0.08),
        blurRadius: 16,
        offset: const Offset(0, 4),
      );

  static BoxShadow get softShadow => BoxShadow(
        color: Colors.black.withOpacity(0.07),
        blurRadius: 12,
        offset: const Offset(0, 3),
      );

  static ThemeData get lightTheme {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: Brightness.light,
        surface: surface,
      ),
    );
    return base.copyWith(
      scaffoldBackgroundColor: surface,
      textTheme: base.textTheme.copyWith(
        bodyMedium: TextStyle(color: textPrimary, fontSize: 14),
        bodySmall: TextStyle(color: textSecondary, fontSize: 12),
        bodyLarge: TextStyle(color: textPrimary, fontSize: 16),
        labelSmall: TextStyle(color: textSecondary),
        labelMedium: TextStyle(color: textSecondary),
        labelLarge: TextStyle(color: textPrimary),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontWeight: FontWeight.w800,
          fontSize: 20,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14)),
          textStyle: TextStyle(fontWeight: FontWeight.w700),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),
    );
  }
}
