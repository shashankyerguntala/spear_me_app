class MerchandiseEntity {
  final int id;
  final String name;
  final int requiredPoints;
  final int availableQuantity;
  final String? imageUrl;

  const MerchandiseEntity({
    required this.id,
    required this.name,
    required this.requiredPoints,
    required this.availableQuantity,
    this.imageUrl,
  });

  MerchandiseEntity copyWith({
    int? id,
    String? name,
    int? requiredPoints,
    int? availableQuantity,
    String? imageUrl,
  }) {
    return MerchandiseEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      requiredPoints: requiredPoints ?? this.requiredPoints,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
