import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/features/common/widgets/custom_floating_action_button.dart';
import 'package:spear_me_app/features/common/widgets/custom_textfield.dart';
import 'package:spear_me_app/features/owner/domain/entity/factory_entity.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/add_factory/bloc/add_factory_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/add_factory/widgets/city_drop_down.dart';

class AddFactoryScreen extends StatelessWidget {
  final bool isEdit;
  final FactoryEntity? factory;

  const AddFactoryScreen({required this.isEdit, this.factory, super.key});

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
  final FactoryEntity? factory;

  const _AddFactoryBody({required this.isEdit, this.factory});

  @override
  State<_AddFactoryBody> createState() => _AddFactoryBodyState();
}

class _AddFactoryBodyState extends State<_AddFactoryBody> {
  final formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController addressController;
  late final TextEditingController emailController;

  String? selectedCity;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: widget.isEdit ? widget.factory?.name ?? "" : "",
    );

    selectedCity = widget.isEdit ? widget.factory?.city : null;

    addressController = TextEditingController(
      text: widget.isEdit ? widget.factory?.address ?? "" : "",
    );

    emailController = TextEditingController(
      text: widget.isEdit ? widget.factory?.plantHeadEmail ?? "" : "",
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.isEdit
        ? StringConstants.editFactory
        : StringConstants.addFactory;

    final buttonText = widget.isEdit
        ? StringConstants.editFactory
        : StringConstants.createFactory;

    return Scaffold(
      backgroundColor: ColorConstants.surface,

      appBar: AppBar(
        backgroundColor: ColorConstants.surface,
        centerTitle: true,
        title: Text(title),
      ),

      body: BlocListener<AddFactoryBloc, AddFactoryState>(
        listener: (context, state) {
          if (state is AddFactorySuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.pop(context);
          }

          if (state is AddFactoryFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: ColorConstants.error,
              ),
            );
          }
        },

        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              CustomTextField(
                controller: nameController,
                label: StringConstants.factoryName,
                validatorMsg: StringConstants.factoryNameCannnotBeEmpty,
              ),

              const SizedBox(height: 16),

              CityDropdown(
                initialCity: selectedCity,
                onCityChanged: (value) => selectedCity = value,
              ),

              const SizedBox(height: 16),

              CustomTextField(
                controller: addressController,
                label: StringConstants.address,
                validatorMsg: StringConstants.addressCannotBeEmpty,
              ),

              const SizedBox(height: 16),

              CustomTextField(
                controller: emailController,
                label: StringConstants.plantHeadEmail,
                validatorMsg: StringConstants.plantHeadEmailCannotBeEmpty,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 24),

              BlocBuilder<AddFactoryBloc, AddFactoryState>(
                builder: (context, state) {
                  final isLoading = state is AddFactoryLoading;

                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              buttonText,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
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
      floatingActionButton: !widget.isEdit
          ? CustomFloatingActionButton(
              label: StringConstants.createPlantHead,
              onPressed: () => context.push(
                '${RoutesConstants.ownerFactoriesRoute}/${RoutesConstants.createPlantHead}',
              ),
            )
          : null,
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

    final bloc = context.read<AddFactoryBloc>();

    if (widget.isEdit) {
      bloc.add(
        UpdateFactoryRequested(
          factoryId: widget.factory!.factoryId,
          name: name,
          city: city,
          address: address,
          email: email,
        ),
      );
    } else {
      bloc.add(
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
