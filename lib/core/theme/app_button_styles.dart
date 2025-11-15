import 'package:flutter/material.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';

class AppButtonStyles {
  static ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: ColorConstants.primary,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
  );

  static ButtonStyle secondaryButton = OutlinedButton.styleFrom(
    side: BorderSide(color: ColorConstants.primary, width: 1.5),
    foregroundColor: ColorConstants.primary,
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
  );

  static ButtonStyle dangerButton = ElevatedButton.styleFrom(
    backgroundColor: Colors.red.shade600,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );
}
