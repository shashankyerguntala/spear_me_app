part of 'owner_factories_bloc.dart';

final class OwnerFactoriesState extends Equatable {
  final bool isLoading;
  final bool isLoadingMore;

  final List<FactoryEntity> factories;
  final int page;
  final int totalPages;
  final bool hasMoreData;

  final String searchQuery;
  final String selectedFilter;
  final String sortBy;
  final bool ascending;

  final String? errorMessage;

  const OwnerFactoriesState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.factories = const [],
    this.page = 0,
    this.totalPages = 1,
    this.hasMoreData = false,
    this.searchQuery = "",
    this.selectedFilter = "",
    this.sortBy = "",
    this.ascending = true,
    this.errorMessage,
  });

  OwnerFactoriesState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    List<FactoryEntity>? factories,
    int? page,
    int? totalPages,
    bool? hasMoreData,
    String? searchQuery,
    String? selectedFilter,
    String? sortBy,
    bool? ascending,
    String? errorMessage,
  }) {
    return OwnerFactoriesState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      factories: factories ?? this.factories,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      sortBy: sortBy ?? this.sortBy,
      ascending: ascending ?? this.ascending,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isLoadingMore,
    factories,
    page,
    totalPages,
    hasMoreData,
    searchQuery,
    selectedFilter,
    sortBy,
    ascending,
    errorMessage,
  ];
}

final class OwnerFactoriesInitial extends OwnerFactoriesState {
  const OwnerFactoriesInitial();
}
