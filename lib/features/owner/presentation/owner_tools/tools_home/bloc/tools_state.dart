part of 'tools_bloc.dart';

class ToolsState extends Equatable {
  final bool isLoadingCategories;
  final bool isLoadingTools;
  final bool isLoadingMore;

  final int page;
  final int pageSize;
  final bool lastPage;

  final List<ToolCategoryEntity> categories;
  final List<ToolEntity> tools;

  final String? selectedCategoryName;
  final String? searchKeyword;
  final String? sortBy;
  final String sortDir;
  final String? filter;

  final String? errorMessage;

  const ToolsState({
    this.isLoadingCategories = false,
    this.isLoadingTools = false,
    this.isLoadingMore = false,
    this.page = 0,
    this.pageSize = 10,
    this.lastPage = false,
    this.categories = const [],
    this.tools = const [],
    this.selectedCategoryName,
    this.searchKeyword,
    this.sortBy,
    this.sortDir = "desc",
    this.filter,
    this.errorMessage,
  });

  ToolsState copyWith({
    bool? isLoadingCategories,
    bool? isLoadingTools,
    bool? isLoadingMore,
    int? page,
    int? pageSize,
    bool? lastPage,
    List<ToolCategoryEntity>? categories,
    List<ToolEntity>? tools,
    String? selectedCategoryName,
    String? searchKeyword,
    String? sortBy,
    String? sortDir,
    String? filter,
    String? errorMessage,
  }) {
    return ToolsState(
      isLoadingCategories: isLoadingCategories ?? this.isLoadingCategories,
      isLoadingTools: isLoadingTools ?? this.isLoadingTools,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      lastPage: lastPage ?? this.lastPage,
      categories: categories ?? this.categories,
      tools: tools ?? this.tools,
      selectedCategoryName: selectedCategoryName ?? this.selectedCategoryName,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      sortBy: sortBy ?? this.sortBy,
      sortDir: sortDir ?? this.sortDir,
      filter: filter ?? this.filter,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoadingCategories,
    isLoadingTools,
    isLoadingMore,
    page,
    pageSize,
    lastPage,
    categories,
    tools,
    selectedCategoryName,
    searchKeyword,
    sortBy,
    sortDir,
    filter,
    errorMessage,
  ];

  factory ToolsState.initial() => const ToolsState();
}
