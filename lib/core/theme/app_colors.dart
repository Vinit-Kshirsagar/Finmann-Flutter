import 'package:flutter/material.dart';

class AppColors {
  // Aliases for compatibility with old codebase during refactoring
  static const bg900 = cream100;
  static const bg800 = cream200;
  static const bg700 = cream300;
  static const bg600 = cream400;

  static const bgAlt = Color(0xFFF7F5F0);
  
  static const primary = forest700;
  static const primaryLight = forest500;
  static const primaryDark = forest900;
  static const accent = forest300;
  static const accentDim = Color(0xFF74C69D);

  static const expense = expenseRed;
  static const income = forest700;
  static const warning = warningOpen;
  static const info = Color(0xFF2A9D8F);
  static const expenseSurface = Color(0xFFFDF2EF);

  // New strict token names
  static const Color cream100 = Color(0xFFF7F5F0);
  static const Color cream200 = Color(0xFFEBE8E0);
  static const Color cream300 = Color(0xFFE0DCD1);
  static const Color cream400 = Color(0xFFD6D1C4);

  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceElevated = Color(0xFFFAFAFA);
  static const Color surfaceHover = Color(0xFFF5F5F5);

  static const Color forest900 = Color(0xFF1B4332);
  static const Color forest700 = Color(0xFF2D6A4F);
  static const Color forest500 = Color(0xFF40916C);
  static const Color forest300 = Color(0xFF52B788);

  static const Color textPrimary = Color(0xFF1A1C1A);
  static const Color textSecondary = Color(0xFF4A5568);
  static const Color textMuted = Color(0xFF868E96);
  static const Color textDisabled = Color(0xFFADB5BD);

  static const Color expenseRed = Color(0xFFE07A5F);
  static const Color warningOpen = Color(0xFFF4A261);

  static const Color border = cream200;
  static const Color borderBright = cream300;
}
