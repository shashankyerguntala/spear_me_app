part of 'pl_products_bloc.dart';

sealed class PlProductsState extends Equatable {
  const PlProductsState();

  @override
  List<Object> get props => [];
}

final class PlProductsInitial extends PlProductsState {}

final class PlLoadingState extends PlProductsState {}

final class PlLoadedState extends PlProductsState {
  final List<ProductEntity> products;

  const PlLoadedState({required this.products});
}

final class PlErrorState extends PlProductsState {
  final String message;

  const PlErrorState({required this.message});
}
