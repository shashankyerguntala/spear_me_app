part of 'merchandise_home_bloc.dart';

class MerchandiseHomeState extends Equatable {
  final bool isLoading;
  final bool isLoadingMore;
  final List<MerchandiseEntity> items;
  final String? errorMessage;
  final String? successMessage;
  final String searchQuery;
  final String selectedCategory;
  final int page;
  final int totalPages;
  final bool hasMoreData;
  final String sortBy;
  final bool ascending;

  const MerchandiseHomeState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.items = const [],
    this.errorMessage,
    this.successMessage,
    this.searchQuery = '',
    this.selectedCategory = '',
    this.page = 0,
    this.totalPages = 1,
    this.hasMoreData = false,
    this.sortBy = 'name',
    this.ascending = true,
  });

  MerchandiseHomeState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    List<MerchandiseEntity>? items,
    String? errorMessage,
    String? successMessage,
    String? searchQuery,
    String? selectedCategory,
    int? page,
    int? totalPages,
    bool? hasMoreData,
    String? sortBy,
    bool? ascending,
  }) {
    return MerchandiseHomeState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      items: items ?? this.items,
      errorMessage: errorMessage,
      successMessage: successMessage,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      sortBy: sortBy ?? this.sortBy,
      ascending: ascending ?? this.ascending,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isLoadingMore,
    items,
    errorMessage,
    successMessage,
    searchQuery,
    selectedCategory,
    page,
    totalPages,
    hasMoreData,
    sortBy,
    ascending,
  ];

  // TODO(Shashank): why this way?
  factory MerchandiseHomeState.initial() {
    return MerchandiseHomeState();
  }
}
