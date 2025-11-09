import 'package:spear_me_app/features/owner/domain/entity/product_category_entity.dart';

class ProductCategoryModel extends ProductCategoryEntity {
  const ProductCategoryModel({
    required super.id,
    required super.categoryName,
    required super.description,
  });

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductCategoryModel(
      id: json['id'],
      categoryName: json['categoryName'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "categoryName": categoryName, "description": description};
  }
}
