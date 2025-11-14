import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/assets_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/features/common/widgets/custom_textfield.dart';
import 'package:spear_me_app/features/owner/presentation/owner_central_office/add_central_office/bloc/add_central_office_bloc.dart';

class AddCentralOffice extends StatelessWidget {
  const AddCentralOffice({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddCentralOfficeBloc(ownerUsecase: di()),
      child: const _AddCentralOfficerBody(),
    );
  }
}

class _AddCentralOfficerBody extends StatefulWidget {
  const _AddCentralOfficerBody();

  @override
  State<_AddCentralOfficerBody> createState() => _AddCentralOfficerBodyState();
}

class _AddCentralOfficerBodyState extends State<_AddCentralOfficerBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController headNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.surface,
        appBar: AppBar(
          backgroundColor: ColorConstants.surface,
          centerTitle: true,
          title: const Text(
            StringConstants.addCentralOfficer,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        body: BlocListener<AddCentralOfficeBloc, AddCentralOfficeState>(
          listener: (context, state) {
            if (state is AddCentralOfficeLoading) {
              Lottie.asset(AssetsConstants.loginLoadingAsset);
            }

            if (state is AddCentralOfficeSuccess) {
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }

            if (state is AddCentralOfficeFailure) {
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
              child: SingleChildScrollView(
                child: Column(
                  spacing: 20,
                  children: [
                    CustomTextField(
                      controller: emailController,
                      label: "Central Officer Email",
                      validatorMsg: "Email cannot be empty",
                      keyboardType: TextInputType.emailAddress,
                      isNumber: false, isPhoneNumber: false,
                    ),
                    CustomTextField(
                      controller: headNameController,
                      label: "Central Office Head Name",
                      validatorMsg: "Name cannot be empty",
                      isNumber: false, isPhoneNumber: false,
                    ),

                    CustomTextField(
                      controller: phoneController,
                      label: "Phone Number",
                      validatorMsg: "Phone cannot be empty",
                      keyboardType: TextInputType.number,
                      isNumber: true, isPhoneNumber: true,
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
                            context.read<AddCentralOfficeBloc>().add(
                              AddCentralOfficeRequested(
                                name: headNameController.text.trim(),
                                email: emailController.text.trim(),
                                phone: int.parse(phoneController.text.trim()),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          StringConstants.createCentralOffice,
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
      ),
    );
  }
}
