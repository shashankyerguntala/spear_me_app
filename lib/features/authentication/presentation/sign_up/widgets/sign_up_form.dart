import 'package:flutter/material.dart';

import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/features/common/widgets/custom_textfield.dart';

class SignUpForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController numberController;
  final bool obscurePassword;

  final VoidCallback onPasswordVisibilityToggle;

  final VoidCallback onSubmit;
  final bool isLoading;

  const SignUpForm({
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,

    required this.onPasswordVisibilityToggle,

    required this.onSubmit,
    required this.isLoading,
    required this.numberController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          spacing: 16,
          children: <Widget>[
            CustomTextField(
              controller: nameController,
              label: StringConstants.usernameLabel,
              validatorMsg: StringConstants.usernameEmpty,
              keyboardType: TextInputType.name,
              isNumber: false, isPhoneNumber: false,
            ),

            CustomTextField(
              controller: emailController,
              label: StringConstants.emailLabel,
              validatorMsg: StringConstants.emailEmpty,
              keyboardType: TextInputType.emailAddress,
              emailValidator: true,
              isNumber: false, isPhoneNumber: false,
            ),
            CustomTextField(
              controller: numberController,
              label: StringConstants.numberLabel,
              validatorMsg: StringConstants.passwordEmpty,
              keyboardType: TextInputType.number,
              isNumber: true, isPhoneNumber: true,
            ),
            CustomTextField(
              controller: passwordController,
              label: StringConstants.passwordLabel,
              validatorMsg: StringConstants.passwordEmpty,
              obscureText: obscurePassword,
              isNumber: false,

              suffixIcon: IconButton(
                icon: Icon(
                  obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: ColorConstants.primaryLight,
                ),
                onPressed: onPasswordVisibilityToggle,
              ), isPhoneNumber: false,
            ),

            Row(
              spacing: 4,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  StringConstants.alreadyUser,
                  style: TextStyle(fontSize: 16),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    StringConstants.signInTitle,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : onSubmit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: ColorConstants.primary,
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: ColorConstants.surface,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        StringConstants.signUpButton,
                        style: const TextStyle(
                          fontSize: 16,
                          color: ColorConstants.surface,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
