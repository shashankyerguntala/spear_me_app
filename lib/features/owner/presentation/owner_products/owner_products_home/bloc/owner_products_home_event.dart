part of 'owner_products_home_bloc.dart';

abstract class OwnerProductsHomeEvent extends Equatable {
  const OwnerProductsHomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchProductCategories extends OwnerProductsHomeEvent {}

class FetchProducts extends OwnerProductsHomeEvent {
  final String? categoryName;

  const FetchProducts({this.categoryName});

  @override
  List<Object?> get props => [categoryName];
}

class SearchProducts extends OwnerProductsHomeEvent {
  final String query;

  const SearchProducts(this.query);

  @override
  List<Object?> get props => [query];
}

class SortProducts extends OwnerProductsHomeEvent {
  final String sortBy;

  const SortProducts({required this.sortBy});

  @override
  List<Object?> get props => [sortBy];
}

class FilterByCategory extends OwnerProductsHomeEvent {
  final String? categoryName;

  const FilterByCategory(this.categoryName);

  @override
  List<Object?> get props => [categoryName];
}

class LoadMoreProducts extends OwnerProductsHomeEvent {}

class AddCategoryEvent extends OwnerProductsHomeEvent {
  final String name;
  final String description;

  const AddCategoryEvent({required this.name, required this.description});

  @override
  List<Object?> get props => [name, description];
}

class UpdateCategoryEvent extends OwnerProductsHomeEvent {
  final int id;
  final String name;
  final String description;

  const UpdateCategoryEvent({
    required this.id,
    required this.name,
    required this.description,
  });

  @override
  List<Object?> get props => [id, name, description];
}

class DeleteCategoryEvent extends OwnerProductsHomeEvent {
  final int categoryId;

  const DeleteCategoryEvent(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class DeleteProduct extends OwnerProductsHomeEvent {
  final int productId;

  const DeleteProduct(this.productId);

  @override
  List<Object?> get props => [productId];
}
