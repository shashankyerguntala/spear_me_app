import 'package:flutter/material.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';

// ignore: avoid_classes_with_only_static_members
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    primaryColor: ColorConstants.primary,
    scaffoldBackgroundColor: ColorConstants.scaffoldBg,
    canvasColor: ColorConstants.cardBg,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,

    appBarTheme: AppBarTheme(
      backgroundColor: ColorConstants.scaffoldBg,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: ColorConstants.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: ColorConstants.textPrimary),
    ),

    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: ColorConstants.textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: ColorConstants.textPrimary,
      ),
      bodyMedium: TextStyle(fontSize: 14, color: ColorConstants.textSecondary),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorConstants.cardBg,
      labelStyle: TextStyle(color: ColorConstants.textSecondary),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: ColorConstants.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: ColorConstants.primary, width: 1.8),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.red),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: ColorConstants.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorConstants.cardBg,
      selectedItemColor: ColorConstants.primary,
      unselectedItemColor: ColorConstants.textSecondary,
      showUnselectedLabels: true,
      selectedIconTheme: IconThemeData(size: 28, color: ColorConstants.primary),
      unselectedIconTheme: IconThemeData(size: 24),
    ),

    dividerTheme: DividerThemeData(color: ColorConstants.border, thickness: 1),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
  );
}
