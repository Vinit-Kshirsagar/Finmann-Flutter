import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  static TextStyle get hero => GoogleFonts.dmSerifDisplay(
    fontSize: 40,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static TextStyle get h1 => GoogleFonts.dmSerifDisplay(
    fontSize: 32,
    color: AppColors.textPrimary,
  );

  static TextStyle get h2 => GoogleFonts.dmSans(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static TextStyle get h3 => GoogleFonts.dmSans(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodyLarge => GoogleFonts.dmSans(
    fontSize: 16,
    color: AppColors.textPrimary,
  );

  static TextStyle get body => GoogleFonts.dmSans(
    fontSize: 14,
    color: AppColors.textSecondary,
  );

  static TextStyle get bodySmall => GoogleFonts.dmSans(
    fontSize: 12,
    color: AppColors.textMuted,
  );

  static TextStyle get label => GoogleFonts.dmSans(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: AppColors.textSecondary,
  );
}
