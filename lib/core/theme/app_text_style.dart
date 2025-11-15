import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';

class AppTextStyles {
  static final TextStyle headlineLarge = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: ColorConstants.textPrimary,
  );

  static final TextStyle headlineMedium = GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: ColorConstants.textPrimary,
  );

  static final TextStyle bodyLarge = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: ColorConstants.textPrimary,
  );

  static final TextStyle bodyMedium = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: ColorConstants.textSecondary,
  );

  static final TextStyle label = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: ColorConstants.textSecondary,
  );
}
