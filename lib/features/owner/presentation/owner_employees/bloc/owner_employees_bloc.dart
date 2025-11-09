import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spear_me_app/features/owner/domain/entity/employee_entity.dart';
import 'package:spear_me_app/features/owner/domain/usecase/owner_usecase.dart';
part 'owner_employees_event.dart';
part 'owner_employees_state.dart';

class OwnerEmployeesBloc
    extends Bloc<OwnerEmployeesEvent, OwnerEmployeesState> {
  final OwnerUsecase usecase;
  OwnerEmployeesBloc({required this.usecase}) : super(OwnerEmployeesInitial()) {
    on<FetchEmployees>(onFetchEmployees);
    on<ResetFilters>(onResetFilters);
  }

  Future<void> onFetchEmployees(
    FetchEmployees event,
    Emitter<OwnerEmployeesState> emit,
  ) async {
    emit(OwnerEmployeesLoading());

    final result = await usecase.getEmployees(
      search: event.search,
      role: event.role,
      page: event.page,
      size: event.size,
    );

    result.fold(
      (failure) => emit(OwnerEmployeesFailure(failure.message)),
      (paged) => emit(
        OwnerEmployeesLoaded(employees: paged.employees, page: paged.page),
      ),
    );
  }

  Future<void> onResetFilters(
    ResetFilters event,
    Emitter<OwnerEmployeesState> emit,
  ) async {
    add(const FetchEmployees());
  }
}
