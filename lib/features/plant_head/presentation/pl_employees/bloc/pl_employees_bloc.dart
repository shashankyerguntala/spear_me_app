import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:spear_me_app/features/plant_head/domain/entity/staff_entity.dart';
import 'package:spear_me_app/features/plant_head/domain/entity/paginated_staff_entity.dart';
import 'package:spear_me_app/features/plant_head/domain/usecases/get_usecase.dart';
part 'pl_employees_event.dart';
part 'pl_employees_state.dart';

class PlEmployeesBloc extends Bloc<PlEmployeesEvent, PlEmployeesState> {
  final GetUsecase usecase;

  PlEmployeesBloc(this.usecase) : super(const PlEmployeesState()) {
    on<FetchEmployees>(_onFetchEmployees);
    on<SearchEmployees>(_onSearchEmployees);
    on<SelectRole>(_onSelectRole);
    on<LoadMoreEmployees>(_onLoadMoreEmployees);
  }

  Future<void> _onFetchEmployees(
    FetchEmployees event, 
    Emitter<PlEmployeesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, page: 0));

    final result = await usecase.getEmployees(
      page: 0,
      size: state.pageSize,
      keyword: state.searchKeyword?.trim().isEmpty == true
          ? null
          : state.searchKeyword?.trim(),
      roleStr: state.roleFilter == 'ALL' ? null : state.roleFilter,
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (PaginatedStaffEntity data) => emit(
        state.copyWith(
          isLoading: false,
          employees: data.content,
          page: data.pageNumber,
          lastPage: data.last,
          totalPages: data.totalPages,
          totalElements: data.totalElements,
        ),
      ),
    );
  }

  Future<void> _onSearchEmployees(
    SearchEmployees event,
    Emitter<PlEmployeesState> emit,
  ) async {
    emit(state.copyWith(searchKeyword: event.keyword));
    add(FetchEmployees());
  }

  Future<void> _onSelectRole(
    SelectRole event,
    Emitter<PlEmployeesState> emit,
  ) async {
    emit(state.copyWith(roleFilter: event.role));
    add(FetchEmployees());
  }

  Future<void> _onLoadMoreEmployees(
    LoadMoreEmployees event,
    Emitter<PlEmployeesState> emit,
  ) async {
    if (state.lastPage || state.isLoadingMore || state.isLoading) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));
    final nextPage = state.page + 1;

    final result = await usecase.getEmployees(
      page: nextPage,
      size: state.pageSize,
      keyword: state.searchKeyword?.trim().isEmpty == true
          ? null
          : state.searchKeyword?.trim(),
      roleStr: state.roleFilter == 'ALL' ? null : state.roleFilter,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(isLoadingMore: false, errorMessage: failure.message),
      ),
      (PaginatedStaffEntity data) => emit(
        state.copyWith(
          isLoadingMore: false,
          employees: [...state.employees, ...data.content],
          page: data.pageNumber,
          lastPage: data.last,
          totalPages: data.totalPages,
          totalElements: data.totalElements,
        ),
      ),
    );
  }
}
