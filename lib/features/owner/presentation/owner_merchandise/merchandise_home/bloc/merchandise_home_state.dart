part of 'merchandise_home_bloc.dart';

class MerchandiseHomeState extends Equatable {
  final bool isLoading;
  final bool isLoadingMore;
  final bool lastPage;
  final String? errorMessage;
  final List<MerchandiseEntity> items;
  final int page;
  final int totalPages;

  const MerchandiseHomeState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.lastPage = false,
    this.errorMessage,
    this.items = const [],
    this.page = 0,
    this.totalPages = 1,
  });

  MerchandiseHomeState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    bool? lastPage,
    String? errorMessage,
    List<MerchandiseEntity>? items,
    int? page,
    int? totalPages,
  }) {
    return MerchandiseHomeState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      lastPage: lastPage ?? this.lastPage,
      errorMessage: errorMessage,
      items: items ?? this.items,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isLoadingMore,
    lastPage,
    errorMessage,
    items,
    page,
    totalPages,
  ];
}
