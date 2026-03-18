import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Logo-inspired warm culinary palette.
  static const Color primary = Color(0xFF8D332E);
  static const Color primaryDark = Color(0xFF5D1E1A);
  static const Color secondary = Color(0xFFE8A63C);
  static const Color accent = Color(0xFF2A8C75);
  static const Color success = Color(0xFF2E8B57);
  static const Color spice = Color(0xFFC85A3D);
  static const Color olive = Color(0xFF6C8B2E);

  static const Color surface = Color(0xFFF8F2EA);
  static const Color surfaceAlt = Color(0xFFF2E6D8);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF25130E);
  static const Color textSecondary = Color(0xFF7A6255);
  static const Color divider = Color(0xFFE6D8CA);

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF8D332E), Color(0xFFC85A3D), Color(0xFFE8A63C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const List<Color> categoryColors = [
    Color(0xFFE8A63C),
    Color(0xFF2A8C75),
    Color(0xFF8D332E),
    Color(0xFFC85A3D),
    Color(0xFFA35A2A),
    Color(0xFF3F8396),
    Color(0xFF6C8B2E),
    Color(0xFF4464A1),
  ];

  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: primary.withOpacity(0.08),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  static TextTheme _textTheme() {
    final base = ThemeData.light().textTheme;
    return GoogleFonts.dmSansTextTheme(base).copyWith(
      displaySmall: GoogleFonts.playfairDisplay(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      ),
      headlineMedium: GoogleFonts.playfairDisplay(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      ),
      titleLarge: GoogleFonts.dmSans(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      ),
      titleMedium: GoogleFonts.dmSans(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      ),
      bodyLarge: GoogleFonts.dmSans(
        fontSize: 16,
        color: textPrimary,
      ),
      bodyMedium: GoogleFonts.dmSans(
        fontSize: 14,
        color: textSecondary,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        secondary: secondary,
        surface: surface,
      ),
      textTheme: _textTheme(),
      brightness: Brightness.light,
      scaffoldBackgroundColor: surface,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: IconThemeData(color: textPrimary),
      ),
      cardTheme: CardTheme(
        color: cardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.transparent,
        indicatorColor: primary.withOpacity(0.12),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.dmSans(color: primary, fontSize: 12, fontWeight: FontWeight.w700);
          }
          return GoogleFonts.dmSans(color: textSecondary, fontSize: 12);
        }),
      ),
    );
  }
}
