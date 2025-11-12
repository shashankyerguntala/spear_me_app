import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/core/helper_functions.dart';
import 'package:spear_me_app/features/owner/domain/entity/product_category_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/product_entity.dart';
import 'package:spear_me_app/features/owner/presentation/owner_products/owner_add_product/bloc/owner_add_product_bloc.dart';

class OwnerAddProducts extends StatefulWidget {
  final bool isEdit;
  final ProductEntity? product;

  const OwnerAddProducts({this.isEdit = false, this.product, super.key});

  @override
  State<OwnerAddProducts> createState() => _OwnerAddProductsState();
}

class _OwnerAddProductsState extends State<OwnerAddProducts> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  final rewardController = TextEditingController();
  final thresholdController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.isEdit && widget.product != null) {
      final product = widget.product!;
      nameController.text = product.name;
      descController.text = product.prodDescription!;
      priceController.text = product.price.toString();
      rewardController.text = product.rewardPts.toString();
      thresholdController.text = product.threshold?.toString() ?? '';
    }
  }

  int? _getCategoryIdFromName(
    List<ProductCategoryEntity> categories,
    String categoryName,
  ) {
    try {
      final category = categories.firstWhere(
        (cat) => cat.categoryName == categoryName,
      );
      return category.id;
    } catch (e) {
      return null;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    priceController.dispose();
    rewardController.dispose();
    thresholdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          OwnerAddProductBloc(usecase: di())
            ..add(const FetchCategoriesRequested()),
      child: BlocConsumer<OwnerAddProductBloc, OwnerAddProductState>(
        listener: (context, state) {
          if (state is OwnerAddProductFailure) {
            HelperFunctions.showSnackBar(
              context,
              message: state.message,
              isError: true,
            );
          }

          if (state is CategoryFetchFailure) {
            HelperFunctions.showSnackBar(
              context,
              message: state.message,
              isError: true,
            );
          }

          if (state is OwnerAddProductSuccess) {
            HelperFunctions.showSnackBar(
              context,
              message: state.message,
              isError: false,
            );
            context.go(RoutesConstants.ownerProductsRoute);
          }

          if (state is OwnerAddProductInitial &&
              !state.isFetchingCategories &&
              widget.isEdit &&
              widget.product != null &&
              state.selectedCategory == null) {
            final categoryId = _getCategoryIdFromName(
              state.categories,
              widget.product!.categoryName,
            );

            if (categoryId != null) {
              final category = state.categories.firstWhere(
                (cat) => cat.id == categoryId,
              );

              // Select the category
              context.read<OwnerAddProductBloc>().add(
                CategorySelected(category),
              );

              // Set the image if available
              context.read<OwnerAddProductBloc>().add(
                ImageSelected(widget.product!.imageUrl!),
              );
            }
          }
        },
        builder: (context, state) {
          if (state is CategoryFetchFailure) {
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.isEdit ? "Edit Product" : "Add Product"),
                backgroundColor: ColorConstants.surface,
                elevation: 0,
                centerTitle: true,
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<OwnerAddProductBloc>().add(
                          const FetchCategoriesRequested(),
                        );
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text("Retry"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.primary,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final imagePath = _getImagePath(state);
          final selectedCategory = _getSelectedCategory(state);
          final categories = _getCategories(state);
          final isFetchingCategories = _isFetchingCategories(state);
          final isLoading = state is OwnerAddProductLoading;

          return Scaffold(
            appBar: AppBar(
              title: Text(widget.isEdit ? "Edit Product" : "Add Product"),
              backgroundColor: ColorConstants.surface,
              elevation: 0,
              centerTitle: true,
            ),
            body: isFetchingCategories
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: formKey,
                      child: Column(
                        spacing: 16,
                        children: [
                          GestureDetector(
                            onTap: isLoading
                                ? null
                                : () async {
                                    final picker = ImagePicker();
                                    final file = await picker.pickImage(
                                      source: ImageSource.gallery,
                                      imageQuality: 75,
                                    );
                                    if (file != null && context.mounted) {
                                      context.read<OwnerAddProductBloc>().add(
                                        ImageSelected(file.path),
                                      );
                                    }
                                  },
                            child: Container(
                              width: double.infinity,
                              height: 160,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey.shade200,
                                image: imagePath != null
                                    ? DecorationImage(
                                        image: _getImageProvider(imagePath),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              alignment: Alignment.center,
                              child: imagePath == null
                                  ? const Icon(
                                      Icons.add_a_photo,
                                      size: 40,
                                      color: Colors.grey,
                                    )
                                  : null,
                            ),
                          ),
                          _textInput(
                            nameController,
                            "Product Name",
                            validator: _validateProductName,
                          ),
                          _textInput(
                            descController,
                            "Description",
                            maxLines: 3,
                            validator: _validateDescription,
                          ),
                          _numberInput(
                            priceController,
                            "Price",
                            isDecimal: true,
                            validator: _validatePrice,
                          ),
                          _numberInput(
                            rewardController,
                            "Reward Points",
                            validator: _validateRewardPoints,
                          ),
                          _numberInput(
                            thresholdController,
                            "Stock Threshold (optional)",
                            isRequired: false,
                            validator: _validateThreshold,
                          ),
                          DropdownButtonFormField<ProductCategoryEntity>(
                            value: selectedCategory,
                            items: categories
                                .map(
                                  (c) => DropdownMenuItem(
                                    value: c,
                                    child: Text(c.categoryName),
                                  ),
                                )
                                .toList(),
                            onChanged: isLoading
                                ? null
                                : (val) {
                                    if (val != null) {
                                      context.read<OwnerAddProductBloc>().add(
                                        CategorySelected(val),
                                      );
                                    }
                                  },
                            decoration: _decoration("Category"),
                            validator: (v) =>
                                v == null ? "Select a category" : null,
                          ),
                          const SizedBox(height: 26),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstants.primary,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                              onPressed: isLoading
                                  ? null
                                  : () => _onSubmit(
                                      context,
                                      imagePath,
                                      selectedCategory,
                                    ),
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      widget.isEdit
                                          ? "Update Product"
                                          : "Upload Product",
                                      style: const TextStyle(
                                        color: Colors.white,
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

  ImageProvider _getImageProvider(String path) {
    // Check if it's a network URL or local file path
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return NetworkImage(path);
    } else {
      return FileImage(File(path));
    }
  }

  String? _getImagePath(OwnerAddProductState state) {
    if (state is OwnerAddProductInitial) {
      return state.imagePath;
    }
    if (state is OwnerAddProductLoading) {
      return state.imagePath;
    }
    if (state is OwnerAddProductFailure) {
      return state.imagePath;
    }
    return null;
  }

  ProductCategoryEntity? _getSelectedCategory(OwnerAddProductState state) {
    if (state is OwnerAddProductInitial) {
      return state.selectedCategory;
    }
    if (state is OwnerAddProductLoading) return state.selectedCategory;
    if (state is OwnerAddProductFailure) return state.selectedCategory;
    return null;
  }

  List<ProductCategoryEntity> _getCategories(OwnerAddProductState state) {
    if (state is OwnerAddProductInitial) return state.categories;
    if (state is OwnerAddProductLoading) return state.categories;
    if (state is OwnerAddProductFailure) return state.categories;
    return [];
  }

  bool _isFetchingCategories(OwnerAddProductState state) {
    if (state is OwnerAddProductInitial) return state.isFetchingCategories;
    return false;
  }

  void _onSubmit(
    BuildContext context,
    String? imagePath,
    ProductCategoryEntity? selectedCategory,
  ) {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (imagePath == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please select an image")));
      return;
    }

    if (selectedCategory == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please select a category")));
      return;
    }

    if (widget.isEdit && widget.product != null) {
      context.read<OwnerAddProductBloc>().add(
        UpdateProductRequested(
          productId: widget.product!.id,
          name: nameController.text.trim(),
          description: descController.text.trim(),
          price: double.parse(priceController.text.trim()),
          rewardPts: int.parse(rewardController.text.trim()),
          categoryId: selectedCategory.id,
          threshold: thresholdController.text.trim().isEmpty
              ? null
              : int.tryParse(thresholdController.text.trim()),
          imagePath: imagePath,
        ),
      );
    } else {
      context.read<OwnerAddProductBloc>().add(
        AddProductRequested(
          name: nameController.text.trim(),
          description: descController.text.trim(),
          price: double.parse(priceController.text.trim()),
          rewardPts: int.parse(rewardController.text.trim()),
          categoryId: selectedCategory.id,
          threshold: thresholdController.text.trim().isEmpty
              ? null
              : int.tryParse(thresholdController.text.trim()),
          imagePath: imagePath,
        ),
      );
    }
  }

  // Validation methods
  String? _validateProductName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Product name cannot be empty";
    }
    if (value.trim().length < 3) {
      return "Product name must be at least 3 characters";
    }
    if (value.trim().length > 100) {
      return "Product name must not exceed 100 characters";
    }
    return null;
  }

  String? _validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Description cannot be empty";
    }
    if (value.trim().length < 10) {
      return "Description must be at least 10 characters";
    }
    if (value.trim().length > 500) {
      return "Description must not exceed 500 characters";
    }
    return null;
  }

  String? _validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Price cannot be empty";
    }

    final price = double.tryParse(value.trim());
    if (price == null) {
      return "Please enter a valid price";
    }

    if (price <= 0) {
      return "Price must be greater than 0";
    }

    final parts = value.trim().split('.');
    if (parts.length > 1 && parts[1].length > 2) {
      return "Price can have maximum 2 decimal places";
    }

    return null;
  }

  String? _validateRewardPoints(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Reward points cannot be empty";
    }

    final points = int.tryParse(value.trim());
    if (points == null) {
      return "Please enter a valid number";
    }

    if (points < 0) {
      return "Reward points cannot be negative";
    }

    return null;
  }

  String? _validateThreshold(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final threshold = int.tryParse(value.trim());
    if (threshold == null) {
      return "Please enter a valid number";
    }

    if (threshold < 0) {
      return "Threshold cannot be negative";
    }

    if (threshold > 100000) {
      return "Threshold is too high";
    }

    return null;
  }

  InputDecoration _decoration(String label) => InputDecoration(
    labelText: label,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    errorMaxLines: 2,
  );

  Widget _textInput(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: _decoration(label),
      validator: validator,
      textCapitalization: TextCapitalization.sentences,
    );
  }

  Widget _numberInput(
    TextEditingController controller,
    String label, {
    bool isRequired = true,
    bool isDecimal = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: _decoration(label),
      keyboardType: TextInputType.numberWithOptions(decimal: isDecimal),
      inputFormatters: [
        if (isDecimal)
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
        else
          FilteringTextInputFormatter.digitsOnly,
      ],
      validator: validator,
    );
  }
}
