part of 'owner_employees_bloc.dart';

abstract class OwnerEmployeesState extends Equatable {
  const OwnerEmployeesState();

  @override
  List<Object?> get props => [];
}

class OwnerEmployeesInitial extends OwnerEmployeesState {}

class OwnerEmployeesLoading extends OwnerEmployeesState {}

class OwnerEmployeesFailure extends OwnerEmployeesState {
  final String message;
  const OwnerEmployeesFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class OwnerEmployeesLoaded extends OwnerEmployeesState {
  final List<EmployeeEntity> employees;
  final int page;

  const OwnerEmployeesLoaded({required this.employees, required this.page});

  @override
  List<Object?> get props => [employees, page];
}
