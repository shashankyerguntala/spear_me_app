part of 'owner_factories_bloc.dart';

abstract class OwnerFactoriesState extends Equatable {
  const OwnerFactoriesState();
  @override
  List<Object?> get props => [];
}

class OwnerFactoriesLoading extends OwnerFactoriesState {}

class OwnerFactoriesFailure extends OwnerFactoriesState {
  final String message;
  const OwnerFactoriesFailure(this.message);
}

class OwnerFactoriesLoaded extends OwnerFactoriesState {
  final List<FactoryEntity> factories;
  final int page;
  final int totalPages;
  final String appliedSearch;
  final String appliedSort;

  const OwnerFactoriesLoaded({
    required this.factories,
    required this.page,
    required this.totalPages,
    required this.appliedSearch,
    required this.appliedSort,
  });
}
