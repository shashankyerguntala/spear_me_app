import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spear_me_app/core/network/debouncer.dart';
import 'package:spear_me_app/features/owner/domain/entity/employee_entity.dart';
import 'package:spear_me_app/features/owner/domain/usecase/owner_usecase.dart';

part 'owner_employees_event.dart';
part 'owner_employees_state.dart';

class OwnerEmployeesBloc
    extends Bloc<OwnerEmployeesEvent, OwnerEmployeesState> {
  final OwnerUsecase usecase;

  OwnerEmployeesBloc({required this.usecase})
    : super(const OwnerEmployeesInitial()) {
    on<FetchEmployees>(
      _onFetchEmployees,
      transformer: throttleDroppable(throttleDuration),
    );
    on<LoadMoreEmployees>(
      _onLoadMoreEmployees,
      transformer: throttleDroppable(throttleDuration),
    );
    on<UpdateSearchQuery>(
      _onUpdateSearchQuery,
      transformer: debounce(debounceDuration),
    );
    on<UpdateRoleFilter>(_onUpdateRoleFilter);
    on<FireEmployee>(_onFireEmployee);
    on<ResetFilters>(_onResetFilters);
    on<SortEmployees>(_onSortEmployees);
  }

  Future<void> _onFetchEmployees(
    FetchEmployees event,
    Emitter<OwnerEmployeesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await usecase.getEmployees(
      search: state.searchQuery.trim().isEmpty
          ? null
          : state.searchQuery.trim(),
      role: state.selectedRole.isEmpty ? null : state.selectedRole,
      page: 0,
      size: 10,
      sort: state.sortBy,
      asc: state.ascending,
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (paged) => emit(
        state.copyWith(
          isLoading: false,
          employees: paged.employees,
          page: 0,
          totalPages: paged.totalPages,
          hasMoreData: (paged.page) < (paged.totalPages) - 1,
        ),
      ),
    );
  }

  Future<void> _onLoadMoreEmployees(
    LoadMoreEmployees event,
    Emitter<OwnerEmployeesState> emit,
  ) async {
    if (state.isLoadingMore || !state.hasMoreData) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = state.page + 1;

    final result = await usecase.getEmployees(
      search: state.searchQuery.trim().isEmpty
          ? null
          : state.searchQuery.trim(),
      role: state.selectedRole.isEmpty ? null : state.selectedRole,
      page: nextPage,
      size: 10,
      sort: state.sortBy,
      asc: state.ascending,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(isLoadingMore: false, errorMessage: failure.message),
      ),
      (paged) {
        final updatedEmployees = List<EmployeeEntity>.from(state.employees)
          ..addAll(paged.employees);

        emit(
          state.copyWith(
            isLoadingMore: false,
            employees: updatedEmployees,
            page: nextPage,
            totalPages: paged.totalPages,
            hasMoreData: nextPage < (paged.totalPages) - 1,
          ),
        );
      },
    );
  }

  void _onUpdateSearchQuery(
    UpdateSearchQuery event,
    Emitter<OwnerEmployeesState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query, page: 0));
    add(const FetchEmployees());
  }

  void _onUpdateRoleFilter(
    UpdateRoleFilter event,
    Emitter<OwnerEmployeesState> emit,
  ) {
    emit(state.copyWith(selectedRole: event.role, page: 0));
    add(const FetchEmployees());
  }

  Future<void> _onFireEmployee(
    FireEmployee event,
    Emitter<OwnerEmployeesState> emit,
  ) async {
    emit(state.copyWith(isFiringEmployee: true));

    final result = await usecase.deleteEmployee(event.employeeId);

    result.fold(
      (failure) => emit(
        state.copyWith(isFiringEmployee: false, errorMessage: failure.message),
      ),
      (_) {
        emit(
          state.copyWith(
            isFiringEmployee: false,
            successMessage: 'Employee removed successfully',
          ),
        );

        add(FetchEmployees());
      },
    );
  }

  void _onResetFilters(ResetFilters event, Emitter<OwnerEmployeesState> emit) {
    emit(const OwnerEmployeesInitial());
    add(const FetchEmployees());
  }

  void _onSortEmployees(
    SortEmployees event,
    Emitter<OwnerEmployeesState> emit,
  ) {
    emit(
      state.copyWith(sortBy: event.sortBy, ascending: event.ascending, page: 0),
    );
    add(const FetchEmployees());
  }
}
