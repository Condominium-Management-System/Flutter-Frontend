
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_axis/shared/theme/colors.dart';

class AuthTheme {
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.primaryBlack,
      primaryColor: AppColors.primaryGold,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryGold,
        secondary: AppColors.secondaryGold,
        error: AppColors.errorRed,
        surface: AppColors.secondaryBlack,
        background: AppColors.primaryBlack,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryBlack,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textWhite,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.primaryGold,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.textDark,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.primaryGold.withValues(alpha: 0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primaryGold,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.errorRed,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.errorRed,
            width: 2,
          ),
        ),
        labelStyle: const TextStyle(
          color: AppColors.textGray,
        ),
        hintStyle: const TextStyle(
          color: AppColors.textDark,
        ),
        prefixIconColor: AppColors.primaryGold,
        suffixIconColor: AppColors.primaryGold,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGold,
          foregroundColor: AppColors.primaryBlack,
          elevation: 8,
          shadowColor: AppColors.primaryGold.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryGold,
          side: const BorderSide(
            color: AppColors.primaryGold,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryGold,
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.secondaryBlack,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.all(8),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.textDark,
        thickness: 1,
        space: 16,
      ),
    );
  }
}