import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/assets_constants.dart';

import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/features/authentication/data/model/roles_enum.dart';
import 'package:spear_me_app/features/authentication/presentation/sign_in/bloc/sign_in_bloc.dart';
import 'package:spear_me_app/features/authentication/presentation/sign_in/widgets/sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return BlocProvider<SignInBloc>(
      create: (_) => di<SignInBloc>(),
      child: BlocConsumer<SignInBloc, SignInState>(
        listener: (BuildContext context, SignInState state) {
          if (state is SignInFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: ColorConstants.error,
              ),
            );
          } else if (state is SignInSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  StringConstants.welcomeBack,
                  style: const TextStyle(color: Colors.black),
                ),
                backgroundColor: ColorConstants.success,
              ),
            );

            if (context.mounted) {
              final roleEnum = state.role.toRoleEnum();

              if (roleEnum == RolesEnum.owner) {
                context.push(RoutesConstants.ownerHomeRoute);
              } else if (roleEnum == RolesEnum.plantHead) {
                //! navigate
                context.push(RoutesConstants.plantHeadHomeRoute);
              } else if (roleEnum == RolesEnum.plantHead) {
                // context.push(RoutesConstants.plantHeadHomeRoute);
              } else {
                //! navigate
                // context.push(RoutesConstants.defaultHomeRoute);
              }
            }
          }
        },
        builder: (BuildContext context, SignInState state) {
          final bool isLoading = state is SignInLoading;

          if (isLoading) {
            return Scaffold(
              backgroundColor: ColorConstants.scaffoldBg,
              body: Center(
                child: Lottie.asset(AssetsConstants.loginLoadingAsset),
              ),
            );
          }

          // ignore: avoid_bool_literals_in_conditional_expressions
          final bool obscurePassword = state is SignInPasswordVisibilityChanged
              ? state.isPasswordObscured
              : true;

          return Scaffold(
            backgroundColor: ColorConstants.scaffoldBg,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Column(
                    children: <Widget>[
                      Lottie.asset(AssetsConstants.loginAsset),
                      const SizedBox(height: 20),
                      Text(
                        StringConstants.welcomeBack,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.primary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        StringConstants.loginToContinue,
                        style: TextStyle(
                          fontSize: 15,
                          color: ColorConstants.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 26),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.black.withAlpha(4),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: SignInForm(
                          formKey: formKey,
                          emailController: emailController,
                          passwordController: passwordController,
                          obscurePassword: obscurePassword,
                          onPasswordVisibilityToggle: () {
                            context.read<SignInBloc>().add(ShowPasswordEvent());
                          },
                          onSubmit: () {
                            context.read<SignInBloc>().add(
                              SignInRequested(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                          },
                          isLoading: isLoading,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
