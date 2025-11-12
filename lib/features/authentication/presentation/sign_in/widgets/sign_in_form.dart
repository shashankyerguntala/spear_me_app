import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';

import 'package:spear_me_app/features/common/widgets/custom_textfield.dart';

class SignInForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onPasswordVisibilityToggle;
  final VoidCallback onSubmit;
  final bool isLoading;

  const SignInForm({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onPasswordVisibilityToggle,
    required this.onSubmit,
    required this.isLoading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CustomTextField(
            controller: emailController,
            label: StringConstants.emailLabel,
            validatorMsg: StringConstants.emailEmpty,
            keyboardType: TextInputType.emailAddress, isNumber: false,
          ),
          const SizedBox(height: 16),

          CustomTextField(
             isNumber: false,
            controller: passwordController,
            label: StringConstants.passwordLabel,
            validatorMsg: StringConstants.passwordEmpty,
            obscureText: obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: ColorConstants.warning,
              ),
              onPressed: onPasswordVisibilityToggle,
            ),
          ),
          const SizedBox(height: 24),

          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  StringConstants.wantToBecomeDistributor,

                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    context.push(RoutesConstants.registerRoute);
                  },
                  child: Text(
                    StringConstants.signUpTitle,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: isLoading ? null : onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: ColorConstants.cardBg,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Text(
                      StringConstants.signInTitle.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: ColorConstants.cardBg,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
