import 'package:spear_me_app/features/owner/domain/entity/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.rewardPts,
    required super.categoryName,
    required super.imageUrl,
    super.threshold,
    super.status,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      name: json["name"] ?? "",
      description: json["prodDescription"] ?? "",
      price: double.tryParse(json["price"].toString()) ?? 0.0,
      rewardPts: json["rewardPts"] ?? 0,
      categoryName: json["categoryName"] ?? "",
      threshold: json["threshold"],
      imageUrl: json["imageUrl"] ?? "",
      status: json["isActive"],
    );
  }
}
