part of 'pl_employees_bloc.dart';

class PlEmployeesState extends Equatable {
  final bool isLoading;
  final bool isLoadingMore;
  final List<StaffEntity> employees;

  final int page;
  final int pageSize;
  final bool lastPage;
  final int? totalPages;
  final int? totalElements;

  final String? searchKeyword;
  final String roleFilter;

  final String? errorMessage;

  const PlEmployeesState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.employees = const [],
    this.page = 0,
    this.pageSize = 10,
    this.lastPage = false,
    this.totalPages,
    this.totalElements,
    this.searchKeyword,
    this.roleFilter = 'ALL',
    this.errorMessage,
  });

  PlEmployeesState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    List<StaffEntity>? employees,
    int? page,
    int? pageSize,
    bool? lastPage,
    int? totalPages,
    int? totalElements,
    String? searchKeyword,
    String? roleFilter,
    String? errorMessage,
  }) {
    return PlEmployeesState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      employees: employees ?? this.employees,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      lastPage: lastPage ?? this.lastPage,
      totalPages: totalPages ?? this.totalPages,
      totalElements: totalElements ?? this.totalElements,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      roleFilter: roleFilter ?? this.roleFilter,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isLoadingMore,
    employees,
    page,
    pageSize,
    lastPage,
    totalPages,
    totalElements,
    searchKeyword,
    roleFilter,
    errorMessage,
  ];
}
