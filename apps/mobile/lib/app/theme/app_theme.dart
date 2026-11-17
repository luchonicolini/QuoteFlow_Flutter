import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData get lightTheme {
    final baseTextTheme = Typography.material2021().black;
    final textTheme = GoogleFonts.interTextTheme(baseTextTheme).copyWith(
      displayLarge: GoogleFonts.manrope(
        fontSize: 30,
        height: 36 / 30,
        fontWeight: FontWeight.w600,
        color: AppColors.graphite900,
      ),
      headlineMedium: GoogleFonts.manrope(
        fontSize: 24,
        height: 30 / 24,
        fontWeight: FontWeight.bold,
        color: AppColors.graphite900,
      ),
      headlineSmall: GoogleFonts.manrope(
        fontSize: 20,
        height: 26 / 20,
        fontWeight: FontWeight.w600,
        color: AppColors.graphite900,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        height: 24 / 16,
        color: AppColors.graphite900,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        height: 20 / 14,
        color: AppColors.graphite900,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        height: 16 / 12,
        color: AppColors.neutralMuted,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.canvas50,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.limePrimary,
        onPrimary: AppColors.graphite900, // Never white on lime
        secondary: AppColors.graphite900,
        onSecondary: AppColors.canvas50,
        surface: AppColors.white,
        onSurface: AppColors.graphite900,
        error: AppColors.error,
        onError: Colors.white,
      ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.canvas50,
        foregroundColor: AppColors.graphite900,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: GoogleFonts.manrope(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.graphite900,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.limePrimary,
          foregroundColor: AppColors.graphite900,
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFE2E6DD)),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    final baseTextTheme = Typography.material2021().white;
    final textTheme = GoogleFonts.interTextTheme(baseTextTheme).copyWith(
      displayLarge: GoogleFonts.manrope(
        fontSize: 30,
        height: 36 / 30,
        fontWeight: FontWeight.w600,
        color: AppColors.darkText,
      ),
      headlineMedium: GoogleFonts.manrope(
        fontSize: 24,
        height: 30 / 24,
        fontWeight: FontWeight.bold,
        color: AppColors.darkText,
      ),
      headlineSmall: GoogleFonts.manrope(
        fontSize: 20,
        height: 26 / 20,
        fontWeight: FontWeight.w600,
        color: AppColors.darkText,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        height: 24 / 16,
        color: AppColors.darkText,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        height: 20 / 14,
        color: AppColors.darkMuted,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        height: 16 / 12,
        color: AppColors.darkMuted,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.graphite900,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.limePrimary,
        onPrimary: AppColors.graphite900, // Never white on lime
        secondary: AppColors.limeSoft,
        onSecondary: AppColors.graphite900,
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkText,
        error: AppColors.error,
        onError: Colors.white,
      ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.graphite900,
        foregroundColor: AppColors.darkText,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: GoogleFonts.manrope(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.darkText,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.limePrimary,
          foregroundColor: AppColors.graphite900,
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.darkBorder),
        ),
      ),
    );
  }
}
