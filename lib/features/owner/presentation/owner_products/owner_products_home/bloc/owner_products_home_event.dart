part of 'owner_products_home_bloc.dart';

abstract class OwnerProductsHomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchProductCategories extends OwnerProductsHomeEvent {}

class FetchProducts extends OwnerProductsHomeEvent {
  final String? search;
  final String? categoryName;
  final int page;

  FetchProducts({this.search, this.categoryName, this.page = 0});

  @override
  List<Object?> get props => [search, categoryName, page];
}

class DeleteProduct extends OwnerProductsHomeEvent {
  final int productId;

  DeleteProduct(this.productId);

  @override
  List<Object?> get props => [productId];
}
