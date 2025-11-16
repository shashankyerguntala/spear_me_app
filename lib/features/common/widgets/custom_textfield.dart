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
  final bool isPhoneNumber;
  final Widget? suffixIcon;
  final bool isNumber;
  final bool? isStrongPass;

  const CustomTextField({
    required this.controller,
    required this.label,
    required this.validatorMsg,
    this.isPhoneNumber = false,
    this.isNumber = false,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.emailValidator = false,

    this.suffixIcon,

    super.key,
    this.isStrongPass = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: isPhoneNumber && isNumber
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ]
          : <TextInputFormatter>[],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: isPhoneNumber
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
        if (value == null || value.trim().isEmpty) {
          return validatorMsg;
        }

        final input = value.trim();

        if (label.toLowerCase().contains('email')) {
          final emailRegex = RegExp(StringConstants.emailRegex);
          if (!emailRegex.hasMatch(input)) {
            return StringConstants.validEmail;
          }
        } else if (label.toLowerCase().contains('password')) {
          if (input.length < 6) {
            return StringConstants.passwordShort;
          }

          if (isStrongPass == true) {
            final strongPasswordRegex = RegExp(StringConstants.passwordRegex);
            if (!strongPasswordRegex.hasMatch(input)) {
              return StringConstants.strongPassword;
            }
          }
        } else if (label.toLowerCase().contains('username')) {
          if (input.length < 4) {
            return StringConstants.usernameFourCharacters;
          }
        } else if (isNumber) {
          final numValue = num.tryParse(input);
          if (numValue == null) {
            return StringConstants.validNumber;
          }
          if (numValue < 0) {
            return StringConstants.negativeNumbersNotAllowed;
          }
        }

        return null;
      },
    );
  }
}
