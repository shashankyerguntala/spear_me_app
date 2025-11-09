part of 'owner_employees_bloc.dart';

abstract class OwnerEmployeesEvent extends Equatable {
  const OwnerEmployeesEvent();

  @override
  List<Object?> get props => [];
}

class FetchEmployees extends OwnerEmployeesEvent {
  final String? search;
  final String? role;
  final int? factoryId;
  final int page;
  final int size;
  final String? sortBy;
  final String? sortDirection;

  const FetchEmployees({
    this.search,
    this.role,
    this.factoryId,
    this.page = 0,
    this.size = 20,
    this.sortBy,
    this.sortDirection,
  });

  @override
  List<Object?> get props =>
      [search, role, factoryId, page, size, sortBy, sortDirection];
}

class ResetFilters extends OwnerEmployeesEvent {
  const ResetFilters();
}
