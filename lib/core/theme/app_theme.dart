import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/theme/app_text_style.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.poppins().fontFamily,
    scaffoldBackgroundColor: ColorConstants.scaffoldBg,
    primaryColor: ColorConstants.primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorConstants.primary,
      primary: ColorConstants.primary,
      secondary: ColorConstants.secondary,
      surface: ColorConstants.surface,
      error: ColorConstants.error,
      onPrimary: ColorConstants.textOnPrimary,
      onSurface: ColorConstants.textPrimary,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: ColorConstants.scaffoldBg,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextStyles.headlineMedium.copyWith(
        color: ColorConstants.textPrimary,
      ),
      iconTheme: const IconThemeData(color: ColorConstants.primary),
    ),

    textTheme: TextTheme(
      displayLarge: AppTextStyles.headlineLarge,
      displayMedium: AppTextStyles.headlineMedium,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      labelLarge: AppTextStyles.label,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: ColorConstants.primary, width: 1.5),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(color: Colors.grey[400]),
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: ColorConstants.primaryLight,
    ),
  );
}
