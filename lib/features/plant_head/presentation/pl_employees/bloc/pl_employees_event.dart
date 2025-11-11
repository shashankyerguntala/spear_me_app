part of 'pl_employees_bloc.dart';

abstract class PlEmployeesEvent extends Equatable {
  const PlEmployeesEvent();
  @override
  List<Object?> get props => const [];
}

class FetchEmployees extends PlEmployeesEvent {
  const FetchEmployees();
}

class SearchEmployees extends PlEmployeesEvent {
  final String keyword;
  const SearchEmployees(this.keyword);

  @override
  List<Object?> get props => [keyword];
}

class SelectRole extends PlEmployeesEvent {
  final String role;
  const SelectRole(this.role);

  @override
  List<Object?> get props => [role];
}

class LoadMoreEmployees extends PlEmployeesEvent {
  const LoadMoreEmployees();
}
