import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/core/helper_functions.dart';
import 'package:spear_me_app/features/common/widgets/custom_textfield.dart';
import 'package:spear_me_app/features/owner/presentation/owner_merchandise/add_merchandise/bloc/add_merchandise_bloc.dart';

class AddMerchandiseScreen extends StatefulWidget {
  const AddMerchandiseScreen({super.key});

  @override
  State<AddMerchandiseScreen> createState() => _AddMerchandiseScreenState();
}

class _AddMerchandiseScreenState extends State<AddMerchandiseScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController pointsController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  File? _selectedImage;

  @override
  void dispose() {
    nameController.dispose();
    pointsController.dispose();
    qtyController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );
    if (file != null) {
      setState(() => _selectedImage = File(file.path));
    }
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_selectedImage == null) {
      HelperFunctions.showSnackBar(
        context,
        message: StringConstants.pleaseSelectAnImage,
        isError: true,
      );
      return;
    }

    context.read<AddMerchandiseBloc>().add(
      SubmitMerchandise(
        name: nameController.text.trim(),
        requiredPoints: int.parse(pointsController.text),
        availableQuantity: int.parse(qtyController.text),
        imagePath: _selectedImage!.path,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<AddMerchandiseBloc>(),
      child: BlocConsumer<AddMerchandiseBloc, AddMerchandiseState>(
        listener: (context, state) {
          if (state is AddMerchandiseSuccess) {
            HelperFunctions.showSnackBar(
              context,
              message: state.message,
              isError: false,
            );
            Navigator.pop(context);
          } else if (state is AddMerchandiseFailure) {
            HelperFunctions.showSnackBar(
              context,
              message: state.error,
              isError: true,
            );
          }
        },
        builder: (context, state) {
          final bool isLoading = state is AddMerchandiseLoading;

          return Scaffold(
            backgroundColor: ColorConstants.surface,
            appBar: AppBar(
              title: const Text(StringConstants.addMerchandise),
              centerTitle: true,
              backgroundColor: ColorConstants.surface,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorConstants.cardBg,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: ColorConstants.border),
                        ),
                        child: _selectedImage == null
                            ? const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image_outlined,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "Tap to upload image",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.file(
                                  _selectedImage!,
                                  width: double.infinity,
                                  height: 160,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    CustomTextField(
                      controller: nameController,
                      label: "Merchandise Name",
                      validatorMsg: "Please enter merchandise name",
                      isNumber: false,
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: pointsController,
                      label: "Required Points",
                      validatorMsg: "Please enter required points",
                      isNumber: false,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: qtyController,
                      label: "Available Quantity",
                      validatorMsg: "Please enter available quantity",
                      isNumber: false,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 28),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: isLoading ? null : () => _submit(context),
                        icon: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.save),
                        label: Text(
                          isLoading ? "Submitting..." : "Add Merchandise",
                          style: const TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
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
