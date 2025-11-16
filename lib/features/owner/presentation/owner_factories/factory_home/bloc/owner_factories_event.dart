part of 'owner_factories_bloc.dart';

abstract class OwnerFactoriesEvent extends Equatable {
  const OwnerFactoriesEvent();
  @override
  List<Object?> get props => [];
}

class FetchFactories extends OwnerFactoriesEvent {
  const FetchFactories();
}

class LoadMoreFactories extends OwnerFactoriesEvent {
  const LoadMoreFactories();
}

class UpdateFactorySearch extends OwnerFactoriesEvent {
  final String query;
  const UpdateFactorySearch(this.query);

  @override
  List<Object?> get props => [query];
}

class UpdateFactorySort extends OwnerFactoriesEvent {
  final String sortBy;
  final bool ascending;
  const UpdateFactorySort({required this.sortBy, required this.ascending});

  @override
  List<Object?> get props => [sortBy, ascending];
}

class UpdateFactoryFilter extends OwnerFactoriesEvent {
  final String filter;
  const UpdateFactoryFilter(this.filter);

  @override
  List<Object?> get props => [filter];
}

class ResetFactoryFilters extends OwnerFactoriesEvent {
  const ResetFactoryFilters();
}
