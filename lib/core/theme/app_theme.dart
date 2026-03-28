import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const bg900 = Color(0xFFF7F5F0); // Warm cream organic bg
  static const bg800 = Color(0xFFEBE8E0); 
  static const bg700 = Color(0xFFE0DCD1); 
  static const bg600 = Color(0xFFD6D1C4); 

  static const surface = Color(0xFFFFFFFF); // White card
  static const surfaceElevated = Color(0xFFFAFAFA); 
  static const surfaceHover = Color(0xFFF5F5F5); 
  static const border = Color(0xFFEBE8E0); 
  static const borderBright = Color(0xFFE0DCD1);

  static const primary = Color(0xFF2D6A4F); // Forest green
  static const primaryLight = Color(0xFF40916C);
  static const primaryDark = Color(0xFF1B4332);
  static const accent = Color(0xFF52B788);
  static const accentDim = Color(0xFF74C69D);

  static const expense = Color(0xFFE07A5F); // Organic red
  static const expenseDim = Color(0xFFE59882);
  static const expenseSurface = Color(0xFFFDF2EF);
  
  static const income = Color(0xFF2D6A4F); // Forest green
  static const incomeSurface = Color(0xFFE9F0EC);
  
  static const warning = Color(0xFFF4A261);
  static const warningSurface = Color(0xFFFDF5ED);
  
  static const info = Color(0xFF2A9D8F);

  static const textPrimary = Color(0xFF1A1C1A); // Almost black
  static const textSecondary = Color(0xFF4A5568); // Muted dark
  static const textMuted = Color(0xFF868E96); 
  static const textDisabled = Color(0xFFADB5BD);

  // gradient stops
  static const g1 = Color(0xFF2D6A4F);
  static const g2 = Color(0xFF40916C);
  static const g3 = Color(0xFF52B788);
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.bg900,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.surface,
        error: AppColors.expense,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimary,
      ),
      textTheme: GoogleFonts.dmSansTextTheme().copyWith(
        displayLarge: GoogleFonts.spaceGrotesk(
          color: AppColors.textPrimary, fontSize: 32,
          fontWeight: FontWeight.w800, letterSpacing: -1,
        ),
        displayMedium: GoogleFonts.spaceGrotesk(
          color: AppColors.textPrimary, fontSize: 26,
          fontWeight: FontWeight.w700, letterSpacing: -0.5,
        ),
        headlineLarge: GoogleFonts.spaceGrotesk(
          color: AppColors.textPrimary, fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: GoogleFonts.spaceGrotesk(
          color: AppColors.textPrimary, fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: GoogleFonts.spaceGrotesk(
          color: AppColors.textPrimary, fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.dmSans(color: AppColors.textPrimary, fontSize: 15),
        bodyMedium: GoogleFonts.dmSans(color: AppColors.textSecondary, fontSize: 13),
        labelLarge: GoogleFonts.spaceGrotesk(
          color: AppColors.textPrimary, fontSize: 14,
          fontWeight: FontWeight.w600, letterSpacing: 0.2,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.expense),
        ),
        hintStyle: GoogleFonts.dmSans(color: AppColors.textMuted),
        labelStyle: GoogleFonts.dmSans(color: AppColors.textSecondary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: GoogleFonts.spaceGrotesk(
            fontSize: 15, fontWeight: FontWeight.w700, letterSpacing: 0.2,
          ),
          elevation: 0,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.border, thickness: 1),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.bg900,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.spaceGrotesk(
          color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.w700,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textMuted,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
