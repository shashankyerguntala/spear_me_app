class ProductDetailEntity {
  final String? productName;
  final int? producedQuantity;

  const ProductDetailEntity({
    this.productName,
    this.producedQuantity,
  });

  ProductDetailEntity copyWith({
    String? productName,
    int? producedQuantity,
  }) {
    return ProductDetailEntity(
      productName: productName ?? this.productName,
      producedQuantity: producedQuantity ?? this.producedQuantity,
    );
  }

  @override
  String toString() {
    return 'ProductDetailEntity(productName: $productName, producedQuantity: $producedQuantity)';
  }
}
