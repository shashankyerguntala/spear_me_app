import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/assets_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/core/helper_functions.dart';
import 'package:spear_me_app/features/authentication/data/model/roles_enum.dart';
import 'package:spear_me_app/features/authentication/presentation/sign_in/bloc/sign_in_bloc.dart';
import 'package:spear_me_app/features/authentication/presentation/sign_in/screens/loading_screen.dart';
import 'package:spear_me_app/features/authentication/presentation/sign_in/widgets/sign_in_form.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInBloc>(
      create: (_) => di<SignInBloc>(),
      child: BlocConsumer<SignInBloc, SignInState>(
        buildWhen: (previous, current) => current is! SignInSuccess,

        listener: (context, state) {
          if (state is SignInSuccess) {
            HelperFunctions.showSnackBar(
              context,
              message: StringConstants.welcomeBack,
              isError: false,
            );

            if (context.mounted) {
              final roleEnum = state.role.toRoleEnum();

              final route = switch (roleEnum) {
                RolesEnum.owner => RoutesConstants.ownerHomeRoute,
                RolesEnum.plantHead => RoutesConstants.plantHeadHomeRoute,
                _ => RoutesConstants.loginRoute,
              };

              context.go(route);
            }
          } else if (state is SignInFailure) {
            HelperFunctions.showSnackBar(
              context,
              message: state.message,
              isError: true,
            );
          }
        },

        builder: (context, state) {
          final bool isLoading = state is SignInLoading;
          // ignore: avoid_bool_literals_in_conditional_expressions
          final bool obscurePassword = state is SignInPasswordVisibilityChanged
              ? state.isPasswordObscured
              : true;

          return Scaffold(
            backgroundColor: ColorConstants.scaffoldBg,
            body: SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
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
                                context.read<SignInBloc>().add(
                                  ShowPasswordEvent(),
                                );
                              },
                              onSubmit: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<SignInBloc>().add(
                                    SignInRequested(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ),
                                  );
                                }
                              },
                              isLoading: isLoading,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  if (isLoading) LoadingScreen(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
