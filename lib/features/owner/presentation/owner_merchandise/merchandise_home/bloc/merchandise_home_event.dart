part of 'merchandise_home_bloc.dart';

abstract class MerchandiseHomeEvent extends Equatable {
  const MerchandiseHomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchMerchandise extends MerchandiseHomeEvent {
  final String? search;
  final String? filter;
  final String? sort;
  final bool isLoadMore;

  const FetchMerchandise({
    this.search,
    this.filter,
    this.sort,
    this.isLoadMore = false,
  });

  @override
  List<Object?> get props => [search, filter, sort, isLoadMore];
}
