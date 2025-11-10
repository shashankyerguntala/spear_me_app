import 'package:flutter/material.dart';
import 'package:flutter/src/services/text_formatter.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String validatorMsg;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool emailValidator;
  final bool isNumber;
  final Widget? suffixIcon;

  const CustomTextField({
    required this.controller,
    required this.label,
    required this.validatorMsg,
    required this.isNumber,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.emailValidator = false,

    this.suffixIcon,

    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: isNumber
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ]
          : <TextInputFormatter>[],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: isNumber
            ? SizedBox(
                width: 60,
                child: Row(
                  spacing: 12,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      StringConstants.nineOne,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),

                    Container(
                      width: 1.2,
                      height: 20,
                      color: ColorConstants.border,
                    ),
                  ],
                ),
              )
            : null,
        labelText: label,
        labelStyle: const TextStyle(color: ColorConstants.textPrimary),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorConstants.error),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorConstants.primary),
          borderRadius: BorderRadius.circular(16),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorConstants.border),
        ),
        filled: true,
        fillColor: ColorConstants.cardBg,
        suffixIcon: suffixIcon,
      ),

      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return validatorMsg;
        }
        if (label == StringConstants.usernameLabel && value.length < 4) {
          return StringConstants.usernameShort;
        }
        if (label == StringConstants.passwordLabel && value.length < 6) {
          return StringConstants.passwordShort;
        }

        return null;
      },
    );
  }
}
