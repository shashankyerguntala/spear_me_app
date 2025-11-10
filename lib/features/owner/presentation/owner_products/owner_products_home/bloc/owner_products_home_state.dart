part of 'owner_products_home_bloc.dart';

class OwnerProductsHomeState extends Equatable {
  final bool isLoading;
  final bool isDeleting;
  final List<ProductCategoryEntity> categories;
  final PagedProductsEntity? products;
  final String? error;
  final String? deleteError;
  final String? deleteSuccess;

  const OwnerProductsHomeState({
    this.isLoading = false,
    this.isDeleting = false,
    this.categories = const [],
    this.products,
    this.error,
    this.deleteError,
    this.deleteSuccess,
  });

  OwnerProductsHomeState copyWith({
    bool? isLoading,
    bool? isDeleting,
    List<ProductCategoryEntity>? categories,
    PagedProductsEntity? products,
    String? error,
    String? deleteError,
    String? deleteSuccess,
  }) {
    return OwnerProductsHomeState(
      isLoading: isLoading ?? this.isLoading,
      isDeleting: isDeleting ?? this.isDeleting,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      error: error,
      deleteError: deleteError,
      deleteSuccess: deleteSuccess,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isDeleting,
    categories,
    products,
    error,
    deleteError,
    deleteSuccess,
  ];
}
