import 'package:flutter/material.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';

class CustomForm extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String validatorMsg;
  final Function(String)? onChanged;
  const CustomForm({
    required this.label,
    required this.controller,
    required this.validatorMsg,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: (String? value) {
        if (value == null && value!.isEmpty) {
          return validatorMsg;
        }
        return null;
      },
      decoration: InputDecoration(
        label: Text(label),
        labelStyle: TextStyle(color: ColorConstants.transparent),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ColorConstants.error),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ColorConstants.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ColorConstants.border),
        ),
      ),
    );
  }
}
