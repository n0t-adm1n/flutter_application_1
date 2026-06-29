import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Aura & Bloom Design System Colors
  static const Color charcoal = Color(0xFF2C2C2C);
  static const Color cream = Color(0xFFFDFBF7);
  static const Color roseGold = Color(0xFFD4AF37);
  static const Color coral = Color(0xFFE07A5F);
  static const Color surfaceGray = Color(0xFFF4F4F4);

  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: charcoal,
        onPrimary: Colors.white,
        secondary: roseGold,
        onSecondary: Colors.white,
        tertiary: coral,
        background: cream,
        onBackground: charcoal,
        surface: surfaceGray,
        onSurface: charcoal,
      ),
      scaffoldBackgroundColor: cream,
      
      // Typography
      textTheme: TextTheme(
        displayLarge: GoogleFonts.plusJakartaSans(
          fontSize: 48,
          fontWeight: FontWeight.w700,
          color: charcoal,
          letterSpacing: -0.96, // -0.02em
          height: 56 / 48,
        ),
        displayMedium: GoogleFonts.plusJakartaSans(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: charcoal,
          letterSpacing: -0.64, // -0.02em
          height: 40 / 32,
        ),
        headlineMedium: GoogleFonts.plusJakartaSans(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: charcoal,
          height: 32 / 24,
        ),
        headlineSmall: GoogleFonts.plusJakartaSans(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: charcoal,
          height: 28 / 20,
        ),
        bodyLarge: GoogleFonts.workSans(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: charcoal,
          height: 28 / 18,
        ),
        bodyMedium: GoogleFonts.workSans(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: charcoal,
          height: 24 / 16,
        ),
        labelLarge: GoogleFonts.workSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: charcoal,
          height: 20 / 14,
          letterSpacing: 0.14, // 0.01em
        ),
        labelSmall: GoogleFonts.workSans(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: charcoal,
          height: 16 / 12,
          letterSpacing: 0.6, // 0.05em
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: surfaceGray,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
