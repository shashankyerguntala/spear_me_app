import 'package:equatable/equatable.dart';

class ProductCategoryEntity extends Equatable {
  final int id;
  final String categoryName;
  final String description;

  const ProductCategoryEntity({
    required this.id,
    required this.categoryName,
    required this.description,
  });

  ProductCategoryEntity copyWith({
    int? id,
    String? categoryName,
    String? description,
  }) {
    return ProductCategoryEntity(
      id: id ?? this.id,
      categoryName: categoryName ?? this.categoryName,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [id, categoryName, description];
}
