part of 'pl_products_bloc.dart';

sealed class PlProductsEvent extends Equatable {
  const PlProductsEvent();

  @override
  List<Object> get props => [];
}

final class FetchProductsPlantHead extends PlProductsEvent {}

final class UpdateProductsQuantityPlantHead extends PlProductsEvent {}

final class LowStockProductsPlantHead extends PlProductsEvent {}
