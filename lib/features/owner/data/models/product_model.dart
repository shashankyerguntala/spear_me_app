import 'package:spear_me_app/features/owner/domain/entity/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.prodDescription,
    required super.price,
    required super.rewardPts,
    required super.categoryName,
    required super.imageUrl,
    super.threshold,
    super.isActive,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] ?? '',
      prodDescription: json['prodDescription'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      rewardPts: (json['rewardPts'] as num?)?.toInt() ?? 0,
      categoryName: json['categoryName'] ?? '',
      threshold: (json['threshold'] as num?)?.toInt(),
      imageUrl: json['imageUrl'] ?? '',
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'prodDescription': prodDescription,
    'price': price,
    'rewardPts': rewardPts,
    'categoryName': categoryName,
    'threshold': threshold,
    'imageUrl': imageUrl,
    'isActive': isActive,
  };
}
