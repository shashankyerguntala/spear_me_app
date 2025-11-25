part of 'owner_products_home_bloc.dart';

class OwnerProductsHomeState extends Equatable {
  final bool isLoading;
  final bool isLoadingCategories;
  final bool isLoadingMore;
  final bool isDeleting;
  final bool isAddingCategory;
  final bool isUpdatingCategory;
  final bool isDeletingCategory;
  
  final List<ProductCategoryEntity> categories;
  final List<ProductEntity> products;
  
  final String? error;
  final String? deleteError;
  final String? deleteSuccess;
  final String? successMessage;
  
  final String? searchKeyword;
  final String? selectedCategoryName;
  final String? sortBy;
  
  final int page;
  final int pageSize;
  final bool lastPage;

  const OwnerProductsHomeState({
    this.isLoading = false,
    this.isLoadingCategories = false,
    this.isLoadingMore = false,
    this.isDeleting = false,
    this.isAddingCategory = false,
    this.isUpdatingCategory = false,
    this.isDeletingCategory = false,
    this.categories = const [],
    this.products = const [],
    this.error,
    this.deleteError,
    this.deleteSuccess,
    this.successMessage,
    this.searchKeyword,
    this.selectedCategoryName,
    this.sortBy,
    this.page = 0,
    this.pageSize = 20,
    this.lastPage = false,
  });

  OwnerProductsHomeState copyWith({
    bool? isLoading,
    bool? isLoadingCategories,
    bool? isLoadingMore,
    bool? isDeleting,
    bool? isAddingCategory,
    bool? isUpdatingCategory,
    bool? isDeletingCategory,
    List<ProductCategoryEntity>? categories,
    List<ProductEntity>? products,
    String? error,
    String? deleteError,
    String? deleteSuccess,
    String? successMessage,
    String? searchKeyword,
    String? selectedCategoryName,
    String? sortBy,
    int? page,
    int? pageSize,
    bool? lastPage,
  }) {
    return OwnerProductsHomeState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingCategories: isLoadingCategories ?? this.isLoadingCategories,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isDeleting: isDeleting ?? this.isDeleting,
      isAddingCategory: isAddingCategory ?? this.isAddingCategory,
      isUpdatingCategory: isUpdatingCategory ?? this.isUpdatingCategory,
      isDeletingCategory: isDeletingCategory ?? this.isDeletingCategory,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      error: error,
      deleteError: deleteError,
      deleteSuccess: deleteSuccess,
      successMessage: successMessage,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      selectedCategoryName: selectedCategoryName ?? this.selectedCategoryName,
      sortBy: sortBy ?? this.sortBy,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      lastPage: lastPage ?? this.lastPage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isLoadingCategories,
        isLoadingMore,
        isDeleting,
        isAddingCategory,
        isUpdatingCategory,
        isDeletingCategory,
        categories,
        products,
        error,
        deleteError,
        deleteSuccess,
        successMessage,
        searchKeyword,
        selectedCategoryName,
        sortBy,
        page,
        pageSize,
        lastPage,
      ];
}