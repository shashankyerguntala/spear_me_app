// product_entity.dart
class ProductEntity {
  final int id;
  final String name;
  final String prodDescription;
  final double price;
  final int rewardPts;
  final String categoryName;
  final int? threshold;
  final String imageUrl;
  final String? isActive;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.prodDescription,
    required this.price,
    required this.rewardPts,
    required this.categoryName,
    required this.imageUrl,
    this.threshold,
    this.isActive,
  });

  ProductEntity copyWith({
    int? id,
    String? name,
    String? prodDescription,
    double? price,
    int? rewardPts,
    String? categoryName,
    int? threshold,
    String? imageUrl,
    String? isActive,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      prodDescription: prodDescription ?? this.prodDescription,
      price: price ?? this.price,
      rewardPts: rewardPts ?? this.rewardPts,
      categoryName: categoryName ?? this.categoryName,
      threshold: threshold ?? this.threshold,
      imageUrl: imageUrl ?? this.imageUrl,
      isActive: isActive ?? this.isActive,
    );
  }
}

// paged_products_entity.dart

