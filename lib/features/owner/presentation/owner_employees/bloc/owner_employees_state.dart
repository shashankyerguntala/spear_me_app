part of 'owner_employees_bloc.dart';

class OwnerEmployeesState extends Equatable {
  final List<EmployeeEntity> employees;
  final bool isLoading;
  final bool isLoadingMore;
  final bool isFiringEmployee;
  final String? errorMessage;
  final String? successMessage;
  final String searchQuery;
  final String selectedRole;
  final String sortBy;
  final bool ascending;
  final int page;
  final int totalPages;
  final bool hasMoreData;

  const OwnerEmployeesState({
    this.employees = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isFiringEmployee = false,
    this.errorMessage,
    this.successMessage,
    this.searchQuery = '',
    this.selectedRole = '',
    this.sortBy = 'name',
    this.ascending = true,
    this.page = 0,
    this.totalPages = 1,
    this.hasMoreData = false,
  });

  OwnerEmployeesState copyWith({
    List<EmployeeEntity>? employees,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isFiringEmployee,
    String? errorMessage,
    String? successMessage,
    String? searchQuery,
    String? selectedRole,
    String? sortBy,
    bool? ascending,
    int? page,
    int? totalPages,
    bool? hasMoreData,
  }) {
    return OwnerEmployeesState(
      employees: employees ?? this.employees,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isFiringEmployee: isFiringEmployee ?? this.isFiringEmployee,
      errorMessage: errorMessage,
      successMessage: successMessage,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedRole: selectedRole ?? this.selectedRole,
      sortBy: sortBy ?? this.sortBy,
      ascending: ascending ?? this.ascending,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      hasMoreData: hasMoreData ?? this.hasMoreData,
    );
  }

  @override
  List<Object?> get props => [
        employees,
        isLoading,
        isLoadingMore,
        isFiringEmployee,
        errorMessage,
        successMessage,
        searchQuery,
        selectedRole,
        sortBy,
        ascending,
        page,
        totalPages,
        hasMoreData,
      ];
}

class OwnerEmployeesInitial extends OwnerEmployeesState {
  const OwnerEmployeesInitial();
}