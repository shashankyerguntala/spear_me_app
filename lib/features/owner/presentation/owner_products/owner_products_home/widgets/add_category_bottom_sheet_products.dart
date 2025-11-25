import 'package:flutter/material.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/features/common/widgets/custom_textfield.dart';
import 'package:spear_me_app/features/owner/domain/entity/product_category_entity.dart';

class AddCategoryBottomSheetProducts extends StatefulWidget {
  final Function(String name, String description) onSubmit;
  final bool isLoading;
  final ProductCategoryEntity? category;

  const AddCategoryBottomSheetProducts({
    required this.onSubmit,
    this.isLoading = false,
    this.category,
    super.key,
  });

  @override
  State<AddCategoryBottomSheetProducts> createState() =>
      _AddCategoryBottomSheetState();
}

class _AddCategoryBottomSheetState
    extends State<AddCategoryBottomSheetProducts> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.category?.categoryName ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.category?.description ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(
        _nameController.text.trim(),
        _descriptionController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.category != null;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isEdit ? "Edit Category" : "Add Category",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _nameController,
              label: "Category Name",
              validatorMsg: "Please enter category name",
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _descriptionController,
              label: "Description",
              validatorMsg: "Please enter description",
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: widget.isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: widget.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        isEdit ? "Update Category" : "Add Category",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
