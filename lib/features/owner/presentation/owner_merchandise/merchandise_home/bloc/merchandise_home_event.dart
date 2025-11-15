part of 'merchandise_home_bloc.dart';

abstract class MerchandiseHomeEvent extends Equatable {
  const MerchandiseHomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchMerchandise extends MerchandiseHomeEvent {
  const FetchMerchandise();
}

class LoadMoreMerchandise extends MerchandiseHomeEvent {
  const LoadMoreMerchandise();
}

class UpdateSearchQuery extends MerchandiseHomeEvent {
  final String query;
  const UpdateSearchQuery(this.query);

  @override
  List<Object?> get props => [query];
}

class UpdateCategoryFilter extends MerchandiseHomeEvent {
  final String category;
  const UpdateCategoryFilter(this.category);

  @override
  List<Object?> get props => [category];
}

class SortMerchandise extends MerchandiseHomeEvent {
  final String sortBy;
  final bool ascending;

  const SortMerchandise({required this.sortBy, required this.ascending});

  @override
  List<Object?> get props => [sortBy, ascending];
}

class ResetMerchandiseFilters extends MerchandiseHomeEvent {
  const ResetMerchandiseFilters();
}
