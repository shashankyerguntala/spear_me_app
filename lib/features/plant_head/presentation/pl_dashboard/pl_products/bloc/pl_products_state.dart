part of 'pl_products_bloc.dart';

sealed class PlProductsState extends Equatable {
  const PlProductsState();

  // TODO(Shashank): implement this override in all the classes that extend the parent state class
  @override
  List<Object> get props => [];
}

final class PlProductsInitial extends PlProductsState {}

final class PlLoadingState extends PlProductsState {}

final class PlLoadedState extends PlProductsState {
  final List<ProductEntity> products;

  const PlLoadedState({required this.products});

  // TODO(Shashank): make sure to provide the props for the state
  // this way you wont run into errors in case you're doing object equality checks, state emits for the same state again and again.
  @override
  List<Object> get props => [products];
}

// TODO(Shashank): if you're creating error state, make sure to provide its UI and error message too
final class PlErrorState extends PlProductsState {
  final String message;

  const PlErrorState({required this.message});
}
