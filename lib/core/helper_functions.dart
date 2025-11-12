import 'package:flutter/material.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';

// ignore: avoid_classes_with_only_static_members
class HelperFunctions {
  static void showSnackBar(
    BuildContext context, {
    required String message,
    required bool isError,
  }) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          backgroundColor: isError
              ? ColorConstants.error
              : ColorConstants.success,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(12),
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          duration: const Duration(seconds: 2),
        ),
      );
  }
}
