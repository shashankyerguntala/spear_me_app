part of 'owner_add_product_bloc.dart';

abstract class OwnerAddProductState extends Equatable {
  const OwnerAddProductState();
  @override
  List<Object?> get props => [];
}

class OwnerAddProductInitial extends OwnerAddProductState {
  final List<ProductCategoryEntity> categories;
  final String? imagePath;
  final ProductCategoryEntity? selectedCategory;
  final bool isFetchingCategories;

  const OwnerAddProductInitial({
    this.categories = const [],
    this.imagePath,
    this.selectedCategory,
    this.isFetchingCategories = false,
  });

  @override
  List<Object?> get props => [
        categories,
        imagePath,
        selectedCategory,
        isFetchingCategories,
      ];

  OwnerAddProductInitial copyWith({
    List<ProductCategoryEntity>? categories,
    String? imagePath,
    ProductCategoryEntity? selectedCategory,
    bool? isFetchingCategories,
  }) {
    return OwnerAddProductInitial(
      categories: categories ?? this.categories,
      imagePath: imagePath ?? this.imagePath,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isFetchingCategories: isFetchingCategories ?? this.isFetchingCategories,
    );
  }
}

class OwnerAddProductLoading extends OwnerAddProductState {
  final List<ProductCategoryEntity> categories;
  final String? imagePath;
  final ProductCategoryEntity? selectedCategory;

  const OwnerAddProductLoading({
    required this.categories,
    this.imagePath,
    this.selectedCategory,
  });

  @override
  List<Object?> get props => [categories, imagePath, selectedCategory];
}

class OwnerAddProductSuccess extends OwnerAddProductState {
  final String message;

  const OwnerAddProductSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class OwnerAddProductFailure extends OwnerAddProductState {
  final String message;
  final List<ProductCategoryEntity> categories;
  final String? imagePath;
  final ProductCategoryEntity? selectedCategory;

  const OwnerAddProductFailure(
    this.message, {
    this.categories = const [],
    this.imagePath,
    this.selectedCategory,
  });

  @override
  List<Object?> get props => [
        message,
        categories,
        imagePath,
        selectedCategory,
      ];
}

class CategoryFetchFailure extends OwnerAddProductState {
  final String message;

  const CategoryFetchFailure(this.message);

  @override
  List<Object?> get props => [message];
}