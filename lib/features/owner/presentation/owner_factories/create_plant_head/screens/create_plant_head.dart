import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/assets_constants.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/features/common/widgets/custom_textfield.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/create_plant_head/bloc/create_plant_head_bloc.dart';

class CreatePlantHeadScreen extends StatelessWidget {
  const CreatePlantHeadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<CreatePlantHeadBloc>(),
      child: const _CreatePlantHeadBody(),
    );
  }
}

class _CreatePlantHeadBody extends StatefulWidget {
  const _CreatePlantHeadBody();

  @override
  State<_CreatePlantHeadBody> createState() => _CreatePlantHeadBodyState();
}

class _CreatePlantHeadBodyState extends State<_CreatePlantHeadBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.surface,
        appBar: AppBar(
          backgroundColor: ColorConstants.surface,
          centerTitle: true,
          title: const Text(
            "Create Plant Head",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        body: BlocListener<CreatePlantHeadBloc, CreatePlantHeadState>(
          listener: (context, state) {
            if (state is CreatePlantHeadLoading) {
              Lottie.asset(AssetsConstants.loginLoadingAsset);
            }

            if (state is CreatePlantHeadSuccess) {
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }

            if (state is CreatePlantHeadFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                spacing: 20,
                children: [
                  CustomTextField(
                    controller: usernameController,
                    label: "Username",
                    validatorMsg: "Username cannot be empty",
                    isNumber: false,
                  ),
                  CustomTextField(
                    controller: emailController,
                    label: "Email",
                    validatorMsg: "Email cannot be empty",
                    keyboardType: TextInputType.emailAddress,
                    isNumber: false,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          context.read<CreatePlantHeadBloc>().add(
                            CreatePlantHeadRequested(
                              username: usernameController.text.trim(),
                              email: emailController.text.trim(),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Create Plant Head",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
