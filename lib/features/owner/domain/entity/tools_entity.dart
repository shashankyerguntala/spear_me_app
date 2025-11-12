class ToolEntity {
  final int id;
  final String name;
  final String? categoryName;
  final String? type;
  final String? isExpensive;
  final int? threshold;
  final String? image;

  const ToolEntity({
    required this.id,
    required this.name,
    this.categoryName,
    this.type,
    this.isExpensive,
    this.threshold,
    this.image,
  });

  ToolEntity copyWith({
    int? id,
    String? name,
    String? categoryName,
    String? type,
    String? isExpensive,
    int? threshold,
    String? image,
  }) {
    return ToolEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryName: categoryName ?? this.categoryName,
      type: type ?? this.type,
      isExpensive: isExpensive ?? this.isExpensive,
      threshold: threshold ?? this.threshold,
      image: image ?? this.image,
    );
  }
}
