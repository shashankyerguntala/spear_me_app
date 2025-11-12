import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/core/helper_functions.dart';
import 'package:spear_me_app/features/common/widgets/custom_textfield.dart';
import 'package:spear_me_app/features/owner/presentation/owner_tools/add_tools/bloc/add_tools_bloc.dart';

class AddToolsScreen extends StatelessWidget {
  const AddToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<AddToolsBloc>()..add(FetchToolCategories()),
      child: const _AddToolsBody(),
    );
  }
}

class _AddToolsBody extends StatefulWidget {
  const _AddToolsBody();

  @override
  State<_AddToolsBody> createState() => _AddToolsBodyState();
}

class _AddToolsBodyState extends State<_AddToolsBody> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _thresholdController = TextEditingController();

  int? _selectedCategoryId;
  String _selectedType = "PERISHABLE";
  String _isExpensive = "NO";

  @override
  void dispose() {
    _nameController.dispose();
    _thresholdController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedCategoryId == null) {
      HelperFunctions.showSnackBar(
        context,
        message: "Please select a category",
        isError: true,
      );
      return;
    }

    context.read<AddToolsBloc>().add(
      CreateTool(
        name: _nameController.text.trim(),
        categoryId: _selectedCategoryId!,
        type: _selectedType,
        isExpensive: _isExpensive,
        threshold: int.tryParse(_thresholdController.text.trim()) ?? 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddToolsBloc, AddToolsState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          HelperFunctions.showSnackBar(
            context,
            message: state.errorMessage!,
            isError: true,
          );
        }

        if (state.successMessage != null) {
          HelperFunctions.showSnackBar(
            context,
            message: state.successMessage!,
            isError: false,
          );
          Navigator.pop(context, true);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorConstants.surface,
          appBar: AppBar(
            title: const Text("Add Tool"),
            centerTitle: true,
            elevation: 0,
            backgroundColor: ColorConstants.surface,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 16,
                children: [
                  CustomTextField(
                    controller: _nameController,
                    label: "Tool Name",
                    validatorMsg: "Please enter tool name",
                    isNumber: false,
                  ),

                  DropdownButtonFormField<int>(
                    value: _selectedCategoryId,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: "Category",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    items: state.categories
                        .map(
                          (c) => DropdownMenuItem<int>(
                            value: c.id,
                            child: Text(c.name),
                          ),
                        )
                        .toList(),
                    onChanged: (val) => setState(() {
                      _selectedCategoryId = val;
                    }),
                  ),

                  DropdownButtonFormField<String>(
                    value: _selectedType,
                    decoration: InputDecoration(
                      labelText: "Tool Type",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: "PERISHABLE",
                        child: Text("Perishable"),
                      ),
                      DropdownMenuItem(
                        value: "NON-PERISHABLE",
                        child: Text("Non-Perishable"),
                      ),
                    ],
                    onChanged: (val) => setState(() {
                      _selectedType = val!;
                    }),
                  ),

                  DropdownButtonFormField<String>(
                    value: _isExpensive,
                    decoration: InputDecoration(
                      labelText: "Is Expensive",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(value: "YES", child: Text("Yes")),
                      DropdownMenuItem(value: "NO", child: Text("No")),
                    ],
                    onChanged: (val) => setState(() {
                      _isExpensive = val!;
                    }),
                  ),

                  CustomTextField(
                    controller: _thresholdController,
                    label: "Threshold Quantity",
                    validatorMsg: "Enter valid threshold value",
                    isNumber: true,
                    keyboardType: TextInputType.number,
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: state.isSubmitting
                          ? null
                          : () => _submit(context),
                      icon: state.isSubmitting
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.add),
                      label: Text(
                        state.isSubmitting ? "Adding..." : "Add Tool",
                        style: const TextStyle(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.primary,
                        foregroundColor: Colors.white,
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
    );
  }
}
