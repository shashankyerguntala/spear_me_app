import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/assets_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/features/common/widgets/custom_textfield.dart';
import 'package:spear_me_app/features/owner/data/data_sources/local_data_source/city_list.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/add_factory/bloc/add_factory_bloc.dart';

class AddFactoryScreen extends StatelessWidget {
  const AddFactoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<AddFactoryBloc>(),
      child: const _AddFactoryBody(),
    );
  }
}

class _AddFactoryBody extends StatefulWidget {
  const _AddFactoryBody();

  @override
  State<_AddFactoryBody> createState() => _AddFactoryBodyState();
}

class _AddFactoryBodyState extends State<_AddFactoryBody> {
  final bool shoeCreatePlantHead = false;
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>(); //! make the form validations in bloc
  String? selectedCity;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController plantHeadEmailController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.surface,
        appBar: AppBar(
          backgroundColor: ColorConstants.surface,
          centerTitle: true,
          title: const Text(
            StringConstants.addFactory,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        body: BlocListener<AddFactoryBloc, AddFactoryState>(
          listener: (context, state) {
            if (state is AddFactoryLoading) {
              Lottie.asset(AssetsConstants.loginLoadingAsset);
            }

            if (state is AddFactorySuccess) {
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }

            if (state is AddFactoryFailure) {
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
                      controller: nameController,
                      label: "Factory Name",
                      validatorMsg: "Factory name cannot be empty",
                      isNumber: false,
                      isPhoneNumber: false,
                    ),
                    DropdownButtonFormField<String>(
                      dropdownColor: ColorConstants.cardBg,
                      value: selectedCity,
                      items: locations
                          .map(
                            (city) => DropdownMenuItem(
                              value: city,
                              child: Text(city),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        selectedCity = value;
                        cityController.text = value ?? "";
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        focusColor: ColorConstants.primary,
                        labelText: "City",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? "City cannot be empty"
                          : null,
                    ),

                    CustomTextField(
                      controller: addressController,
                      label: "Address",
                      validatorMsg: "Address cannot be empty",
                      isNumber: false,
                      isPhoneNumber: false,
                    ),
                    CustomTextField(
                      controller: plantHeadEmailController,
                      label: "Plant Head Email",
                      validatorMsg: "Email cannot be empty",
                      keyboardType: TextInputType.emailAddress,
                      isNumber: false,
                      isPhoneNumber: false,
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

                            context.read<AddFactoryBloc>().add(
                              AddFactoryRequested(
                                name: nameController.text.trim(),
                                city: cityController.text.trim(),
                                address: addressController.text.trim(),
                                email: plantHeadEmailController.text.trim(),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          StringConstants.createFactory,
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
        floatingActionButton: BlocBuilder<AddFactoryBloc, AddFactoryState>(
          builder: (context, state) {
            if (state is AddFactoryFailure && state.allowAddPlantHead == true) {
              return FloatingActionButton.extended(
                backgroundColor: ColorConstants.primary,
                onPressed: () {
                  context.push(RoutesConstants.createPlantHead);
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  "Create Plant Head",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
