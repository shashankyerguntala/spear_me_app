import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/features/authentication/presentation/sign_up/bloc/sign_up_bloc.dart';
import 'package:spear_me_app/features/authentication/presentation/sign_up/widgets/sign_up_appbar.dart';
import 'package:spear_me_app/features/authentication/presentation/sign_up/widgets/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (_) => di<SignUpBloc>(),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (BuildContext context, SignUpState state) {
          if (state is SignUpFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: ColorConstants.error,
              ),
            );
          } else if (state is SignUpSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.msg),
                backgroundColor: ColorConstants.success,
              ),
            );
            context.go('/login');
          }
        },
        builder: (BuildContext context, SignUpState state) {
          final bool isLoading = state is SignUpLoading;
          // ignore: avoid_bool_literals_in_conditional_expressions
          final bool obscurePassword = state is SignUpPasswordVisibilityChanged
              ? state.isPasswordObscured
              : true;

          return Scaffold(
            backgroundColor: ColorConstants.scaffoldBg,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SignUpAppBar(),
                    const SizedBox(height: 24),
                    SignUpForm(
                      formKey: formKey,
                      nameController: nameController,
                      emailController: emailController,
                      passwordController: passwordController,
                      obscurePassword: obscurePassword,
                      onPasswordVisibilityToggle: () {
                        context.read<SignUpBloc>().add(ShowPasswordEvent());
                      },
                      onSubmit: () {
                        if (formKey.currentState!.validate()) {
                          context.read<SignUpBloc>().add(
                            SignUpRequested(
                              username: nameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            ),
                          );
                        }
                      },
                      isLoading: isLoading,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
