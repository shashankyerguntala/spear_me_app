// owner_factories_event.dart
part of 'owner_factories_bloc.dart';

abstract class OwnerFactoriesEvent extends Equatable {
  const OwnerFactoriesEvent();
  @override
  List<Object?> get props => [];
}

class FetchFactories extends OwnerFactoriesEvent {
  final String search;
  final int page;
  final int size;
  final String sort;

  const FetchFactories({
    this.search = "",
    this.page = 0,
    this.size = 5,
    this.sort = "name,asc",
  });
}
