import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/features/common/widgets/custom_textfield.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/create_plant_head/bloc/create_plant_head_bloc.dart';

class CreatePlantHeadScreen extends StatelessWidget {
  const CreatePlantHeadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<CreatePlantHeadBloc>(),
      child: const CreatePlantHeadBody(),
    );
  }
}

class CreatePlantHeadBody extends StatefulWidget {
  const CreatePlantHeadBody({super.key});

  @override
  State<CreatePlantHeadBody> createState() => CreatePlantHeadBodyState();
}

class CreatePlantHeadBodyState extends State<CreatePlantHeadBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.surface,

        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorConstants.surface,
          title: const Text(
            StringConstants.createPlantHeadTitle,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        body: BlocListener<CreatePlantHeadBloc, CreatePlantHeadState>(
          listener: (context, state) {
            if (state is CreatePlantHeadSuccess) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
              Navigator.pop(context);
            }

            if (state is CreatePlantHeadFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: ColorConstants.error,
                ),
              );
            }
          },

          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: usernameController,
                    label: StringConstants.usernameLabel,
                    validatorMsg: StringConstants.usernameCannotBeEmpty,
                  ),

                  const SizedBox(height: 20),

                  CustomTextField(
                    controller: emailController,
                    label: StringConstants.emailLabel,
                    validatorMsg: StringConstants.emailCannotBeEmpty,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 28),

                  BlocBuilder<CreatePlantHeadBloc, CreatePlantHeadState>(
                    builder: (context, state) {
                      final loading = state is CreatePlantHeadLoading;

                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.primary,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: loading
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    FocusScope.of(context).unfocus();

                                    context.read<CreatePlantHeadBloc>().add(
                                      CreatePlantHeadRequested(
                                        username: usernameController.text
                                            .trim(),
                                        email: emailController.text.trim(),
                                      ),
                                    );
                                  }
                                },
                          child: loading
                              ? const SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(
                                    color: ColorConstants.textOnPrimary,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  StringConstants.createPlantHeadTitle,
                                  style: TextStyle(
                                    color: ColorConstants.textOnPrimary,
                                  ),
                                ),
                        ),
                      );
                    },
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
