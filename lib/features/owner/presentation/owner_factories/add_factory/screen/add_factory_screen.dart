import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/assets_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/features/common/widgets/custom_floating_action_button.dart';
import 'package:spear_me_app/features/common/widgets/custom_textfield.dart';
import 'package:spear_me_app/features/owner/data/data_sources/local_data_source/city_list_factory.dart';
import 'package:spear_me_app/features/owner/domain/entity/factory_details_entity.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/add_factory/bloc/add_factory_bloc.dart';

class AddFactoryScreen extends StatelessWidget {
  final bool isEdit;
  final FactoryDetailsEntity? factory;

  const AddFactoryScreen({required this.isEdit, super.key, this.factory});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<AddFactoryBloc>(),
      child: _AddFactoryBody(isEdit: isEdit, factory: factory),
    );
  }
}

class _AddFactoryBody extends StatefulWidget {
  final bool isEdit;
  final FactoryDetailsEntity? factory;

  const _AddFactoryBody({required this.isEdit, this.factory});

  @override
  State<_AddFactoryBody> createState() => _AddFactoryBodyState();
}

class _AddFactoryBodyState extends State<_AddFactoryBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController emailController;

  String? selectedCity;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: widget.isEdit ? widget.factory?.factoryName ?? "" : "",
    );

    addressController = TextEditingController(
      text: widget.isEdit ? widget.factory?.location ?? "" : "",
    );

//! pass the email when lavanya gives the email in factory details 
    emailController = TextEditingController(text: widget.isEdit ? "" : "");

    selectedCity = widget.isEdit ? widget.factory?.location : null;
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.isEdit
        ? StringConstants.editFactory
        : StringConstants.addFactory;

    final actionText = widget.isEdit
        ? StringConstants.editFactory
        : StringConstants.createFactory;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.surface,

        appBar: AppBar(
          backgroundColor: ColorConstants.surface,
          centerTitle: true,
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        body: BlocListener<AddFactoryBloc, AddFactoryState>(
          listener: (context, state) {
            if (state is AddFactoryLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => Center(
                  child: Lottie.asset(AssetsConstants.loginLoadingAsset),
                ),
              );
            }

            if (state is AddFactorySuccess) {
              Navigator.pop(context); // close loader
              Navigator.pop(context); // go back
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }

            if (state is AddFactoryFailure) {
              Navigator.pop(context);
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
              child: SingleChildScrollView(
                child: Column(
                  spacing: 20,
                  children: [
                    CustomTextField(
                      controller: nameController,
                      label: StringConstants.factoryName,
                      validatorMsg: StringConstants.factoryNameCannnotBeEmpty,
                    ),

                    DropdownButtonFormField<String>(
                      value: selectedCity,
                      dropdownColor: ColorConstants.cardBg,
                      items: locations
                          .map(
                            (city) => DropdownMenuItem(
                              value: city,
                              child: Text(city),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() => selectedCity = value);
                      },
                      decoration: InputDecoration(
                        labelText: StringConstants.city,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? StringConstants.cityRequired
                          : null,
                    ),

                    CustomTextField(
                      controller: addressController,
                      label: StringConstants.address,
                      validatorMsg: StringConstants.addressCannotBeEmpty,
                    ),

                    CustomTextField(
                      controller: emailController,
                      label: StringConstants.plantHeadEmail,
                      validatorMsg: StringConstants.plantHeadEmailCannotBeEmpty,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: _submit,
                        child: Text(
                          actionText,
                          style: const TextStyle(
                            color: ColorConstants.textOnPrimary,
                          ),
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
            if (!widget.isEdit &&
                state is AddFactoryFailure &&
                state.allowAddPlantHead == true) {
              return CustomFloatingActionButton(
                label: StringConstants.createPlantHead,
                onPressed: () => context.push(RoutesConstants.createPlantHead),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _submit() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final name = nameController.text.trim();
    final city = selectedCity!;
    final address = addressController.text.trim();
    final email = emailController.text.trim();

    if (widget.isEdit) {
      context.read<AddFactoryBloc>().add(
        UpdateFactoryRequested(
          factoryId: widget.factory!.factoryId!,
          name: name,
          city: city,
          address: address,
          email: email,
        ),
      );
    } else {
      context.read<AddFactoryBloc>().add(
        AddFactoryRequested(
          name: name,
          city: city,
          address: address,
          email: email,
        ),
      );
    }
  }
}
