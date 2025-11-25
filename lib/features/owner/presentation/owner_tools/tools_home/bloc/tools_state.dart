part of 'tools_bloc.dart';

class ToolsState extends Equatable {
  final List<ToolEntity> tools;
  final List<ToolCategoryEntity> categories;
  final bool isLoadingTools;
  final bool isLoadingCategories;
  final bool isLoadingMore;
  final bool isAddingCategory;
  final bool isUpdatingCategory;
  final bool isDeletingCategory;
  final String? errorMessage;
  final String? successMessage;
  final String? searchKeyword;
  final String? filter;
  final String? sortBy;
  final String sortDir;
  final int page;
  final int pageSize;
  final bool lastPage;
  final String? selectedCategoryName;

  const ToolsState({
    this.tools = const [],
    this.categories = const [],
    this.isLoadingTools = false,
    this.isLoadingCategories = false,
    this.isLoadingMore = false,
    this.isAddingCategory = false,
    this.isUpdatingCategory = false,
    this.isDeletingCategory = false,
    this.errorMessage,
    this.successMessage,
    this.searchKeyword,
    this.filter,
    this.sortBy,
    this.sortDir = "DESC",
    this.page = 0,
    this.pageSize = 10,
    this.lastPage = false,
    this.selectedCategoryName,
  });

  ToolsState copyWith({
    List<ToolEntity>? tools,
    List<ToolCategoryEntity>? categories,
    bool? isLoadingTools,
    bool? isLoadingCategories,
    bool? isLoadingMore,
    bool? isAddingCategory,
    bool? isUpdatingCategory,
    bool? isDeletingCategory,
    String? errorMessage,
    String? successMessage,
    String? searchKeyword,
    String? filter,
    String? sortBy,
    String? sortDir,
    int? page,
    int? pageSize,
    bool? lastPage,
    String? selectedCategoryName,
  }) {
    return ToolsState(
      tools: tools ?? this.tools,
      categories: categories ?? this.categories,
      isLoadingTools: isLoadingTools ?? this.isLoadingTools,
      isLoadingCategories: isLoadingCategories ?? this.isLoadingCategories,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isAddingCategory: isAddingCategory ?? this.isAddingCategory,
      isUpdatingCategory: isUpdatingCategory ?? this.isUpdatingCategory,
      isDeletingCategory: isDeletingCategory ?? this.isDeletingCategory,
      errorMessage: errorMessage,
      successMessage: successMessage,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      filter: filter ?? this.filter,
      sortBy: sortBy ?? this.sortBy,
      sortDir: sortDir ?? this.sortDir,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      lastPage: lastPage ?? this.lastPage,
      selectedCategoryName: selectedCategoryName ?? this.selectedCategoryName,
    );
  }

  @override
  List<Object?> get props => [
        tools,
        categories,
        isLoadingTools,
        isLoadingCategories,
        isLoadingMore,
        isAddingCategory,
        isUpdatingCategory,
        isDeletingCategory,
        errorMessage,
        successMessage,
        searchKeyword,
        filter,
        sortBy,
        sortDir,
        page,
        pageSize,
        lastPage,
        selectedCategoryName,
      ];
}