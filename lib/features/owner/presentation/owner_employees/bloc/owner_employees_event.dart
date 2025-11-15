part of 'owner_employees_bloc.dart';

abstract class OwnerEmployeesEvent extends Equatable {
  const OwnerEmployeesEvent();

  @override
  List<Object?> get props => [];
}

class FetchEmployees extends OwnerEmployeesEvent {
  const FetchEmployees();
}

class LoadMoreEmployees extends OwnerEmployeesEvent {
  const LoadMoreEmployees();
}

class UpdateSearchQuery extends OwnerEmployeesEvent {
  final String query;

  const UpdateSearchQuery({required this.query});

  @override
  List<Object?> get props => [query];
}

class UpdateRoleFilter extends OwnerEmployeesEvent {
  final String role;

  const UpdateRoleFilter({required this.role});

  @override
  List<Object?> get props => [role];
}

class FireEmployee extends OwnerEmployeesEvent {
  final int employeeId;

  const FireEmployee(this.employeeId);

  @override
  List<Object?> get props => [employeeId];
}

class ResetFilters extends OwnerEmployeesEvent {
  const ResetFilters();
}

class SortEmployees extends OwnerEmployeesEvent {
  final String sortBy;
  final bool ascending;

  const SortEmployees({
    required this.sortBy,
    required this.ascending,
  });

  @override
  List<Object?> get props => [sortBy, ascending];
}