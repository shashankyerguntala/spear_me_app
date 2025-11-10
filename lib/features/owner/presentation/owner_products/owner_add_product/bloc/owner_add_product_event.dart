part of 'owner_add_product_bloc.dart';

abstract class OwnerAddProductEvent extends Equatable {
  const OwnerAddProductEvent();
  @override
  List<Object?> get props => [];
}

class FetchCategoriesRequested extends OwnerAddProductEvent {
  const FetchCategoriesRequested();
}

class ImageSelected extends OwnerAddProductEvent {
  final String imagePath;

  const ImageSelected(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

class CategorySelected extends OwnerAddProductEvent {
  final ProductCategoryEntity category;

  const CategorySelected(this.category);

  @override
  List<Object?> get props => [category];
}

class AddProductRequested extends OwnerAddProductEvent {
  final String name;
  final String description;
  final double price;
  final int rewardPts;
  final int categoryId;
  final int? threshold;
  final String imagePath;

  const AddProductRequested({
    required this.name,
    required this.description,
    required this.price,
    required this.rewardPts,
    required this.categoryId,
    required this.imagePath,
    this.threshold,
  });

  @override
  List<Object?> get props => [
    name,
    description,
    price,
    rewardPts,
    categoryId,
    threshold,
    imagePath,
  ];
}

// Add this event for future edit functionality
class UpdateProductRequested extends OwnerAddProductEvent {
  final int productId;
  final String name;
  final String description;
  final double price;
  final int rewardPts;
  final int categoryId;
  final int? threshold;
  final String imagePath;

  const UpdateProductRequested({
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    required this.rewardPts,
    required this.categoryId,
    required this.imagePath,
    this.threshold,
  });

  @override
  List<Object?> get props => [
    productId,
    name,
    description,
    price,
    rewardPts,
    categoryId,
    threshold,
    imagePath,
  ];
}
