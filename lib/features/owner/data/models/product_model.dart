import 'package:spear_me_app/features/owner/domain/entity/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.price,
    required super.categoryName,
    super.prodDescription,
    super.rewardPts,
    super.threshold,
    super.currentQty,
    super.imageUrl,
    super.isActive,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: (json['productId'] as num).toInt(),
      name: json['productName'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      categoryName: json['categoryName'] ?? '',
      rewardPts: (json['rewardPts'] as num?)?.toInt(),
      threshold: (json['threshold'] as num?)?.toInt(),
      currentQty: (json['currentQty'] as num?)?.toInt(),
      prodDescription: json['prodDescription'],
      imageUrl: json['imageUrl'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() => {
    'productId': id,
    'productName': name,
    'prodDescription': prodDescription,
    'price': price,
    'rewardPts': rewardPts,
    'categoryName': categoryName,
    'threshold': threshold,
    'currentQty': currentQty,
    'imageUrl': imageUrl,
    'isActive': isActive,
  };
}
