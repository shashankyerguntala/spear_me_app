class ProductEntity {
  final int id;
  final String name;
  final String? prodDescription;
  final double price;
  final int? rewardPts;
  final String categoryName;
  final int? threshold;
  final int? currentQty;
  final String? imageUrl;
  final String? isActive;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.categoryName,
    this.prodDescription,
    this.rewardPts,
    this.threshold,
    this.currentQty,
    this.imageUrl,
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
    int? currentQty,
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
      currentQty: currentQty ?? this.currentQty,
      imageUrl: imageUrl ?? this.imageUrl,
      isActive: isActive ?? this.isActive,
    );
  }
}
