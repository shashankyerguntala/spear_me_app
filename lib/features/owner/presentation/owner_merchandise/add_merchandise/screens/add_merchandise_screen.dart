import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/core/helper_functions.dart';
import 'package:spear_me_app/features/common/widgets/custom_textfield.dart';
import 'package:spear_me_app/features/owner/domain/entity/merchandise_entity.dart';
import 'package:spear_me_app/features/owner/presentation/owner_merchandise/add_merchandise/bloc/add_merchandise_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_merchandise/add_merchandise/widgets/merchandise_image_picker.dart';

class AddMerchandiseScreen extends StatefulWidget {
  final MerchandiseEntity? merchandise;

  const AddMerchandiseScreen({super.key, this.merchandise});

  @override
  State<AddMerchandiseScreen> createState() => _AddMerchandiseScreenState();
}

class _AddMerchandiseScreenState extends State<AddMerchandiseScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController pointsController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  bool get isEdit => widget.merchandise != null;

  @override
  void initState() {
    super.initState();

    if (isEdit) {
      final m = widget.merchandise!;
      nameController.text = m.name;
      pointsController.text = m.requiredPoints.toString();
      quantityController.text = m.availableQuantity.toString();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    pointsController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  void submit(BuildContext context, AddMerchandiseState state) {
    final formState = formKey.currentState;
    if (formState == null || !formState.validate()) {
      return;
    }

    if (!isEdit && state.image == null) {
      HelperFunctions.showSnackBar(
        context,
        message: StringConstants.pleaseSelectAnImage,
        isError: true,
      );
      return;
    }

    final bloc = context.read<AddMerchandiseBloc>();

    final name = nameController.text.trim();
    final points = int.parse(pointsController.text.trim());
    final qty = int.parse(quantityController.text.trim());

    if (isEdit) {
      bloc.add(
        UpdateMerchandise(
          id: widget.merchandise!.id,
          name: name,
          requiredPoints: points,
          availableQuantity: qty,
        ),
      );
    } else {
      bloc.add(
        SubmitMerchandise(
          name: name,
          requiredPoints: points,
          availableQuantity: qty,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = di<AddMerchandiseBloc>();

        if (isEdit && widget.merchandise!.imageUrl != null) {}

        return bloc;
      },
      child: BlocConsumer<AddMerchandiseBloc, AddMerchandiseState>(
        listener: (context, state) {
          if (state.success != null) {
            HelperFunctions.showSnackBar(
              context,
              message: state.success!,
              isError: false,
            );
            Navigator.pop(context);
          } else if (state.error != null) {
            HelperFunctions.showSnackBar(
              context,
              message: state.error!,
              isError: true,
            );
          }
        },

        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorConstants.surface,
            appBar: AppBar(
              backgroundColor: ColorConstants.surface,
              centerTitle: true,
              elevation: 0,
              title: Text(
                isEdit
                    ? StringConstants.editMerchandise
                    : StringConstants.addMerchandise,
              ),
            ),

            body: Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  MerchandiseImagePicker(
                    initialFile: state.image,
                    existingUrl: widget.merchandise?.imageUrl,
                    onPicked: (file) {
                      context.read<AddMerchandiseBloc>().add(
                        PickMerchandiseImage(file!),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  CustomTextField(
                    controller: nameController,
                    label: StringConstants.merchandiseName,
                    validatorMsg: StringConstants.merchandiseNameRequired,
                  ),

                  const SizedBox(height: 16),

                  CustomTextField(
                    controller: pointsController,
                    label: StringConstants.requiredPoints,
                    validatorMsg: StringConstants.requiredPointsRequired,
                    isNumber: true,
                    keyboardType: TextInputType.number,
                  ),

                  const SizedBox(height: 16),

                  CustomTextField(
                    controller: quantityController,
                    label: StringConstants.availableQuantity,
                    validatorMsg: StringConstants.availableQuantityRequired,
                    isNumber: true,
                    keyboardType: TextInputType.number,
                  ),

                  const SizedBox(height: 28),

                  ElevatedButton.icon(
                    onPressed: state.isLoading
                        ? null
                        : () => submit(context, state),
                    icon: state.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: ColorConstants.textOnPrimary,
                            ),
                          )
                        : Icon(
                            isEdit ? Icons.save_outlined : Icons.add,
                            color: ColorConstants.textOnPrimary,
                          ),
                    label: Text(
                      state.isLoading
                          ? (isEdit
                                ? StringConstants.updating
                                : StringConstants.submitting)
                          : (isEdit
                                ? StringConstants.saveChanges
                                : StringConstants.addMerchandiseButton),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.primary,
                      foregroundColor: ColorConstants.textOnPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
