import 'package:flutter/material.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';

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
//! create extensions 
  static Color getRoleColor(String role) {
    switch (role.toUpperCase()) {
      case 'OWNER':
        return Colors.purple;
      case 'PLANT_HEAD':
        return Colors.blue;
      case 'DISTRIBUTOR':
        return Colors.orange;
      case 'CENTRAL_OFFICE':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  static String formatRole(String role) {
    return role
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }

  static String format(String role) {
    return role
        .replaceAll('_', ' ')
        .toLowerCase()
        .split(' ')
        .map((w) => w[0].toUpperCase() + w.substring(1))
        .join(' ');
  }
}
