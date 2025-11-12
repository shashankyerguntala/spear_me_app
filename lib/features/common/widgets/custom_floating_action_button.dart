import 'package:flutter/material.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData icon;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CustomFloatingActionButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon = Icons.add,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: backgroundColor ?? ColorConstants.owner,
      foregroundColor: foregroundColor ?? ColorConstants.surface,
      icon: Icon(icon, color: foregroundColor ?? ColorConstants.surface),
      label: Text(
        label,
        style: TextStyle(
          color: foregroundColor ?? ColorConstants.surface,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
