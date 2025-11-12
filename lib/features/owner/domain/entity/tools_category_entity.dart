class ToolCategoryEntity {
  final int id;
  final String name;
  final String description;

  const ToolCategoryEntity({
    required this.id,
    required this.name,
    required this.description,
  });

  ToolCategoryEntity copyWith({
    int? id,
    String? name,
    String? description,
  }) {
    return ToolCategoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}
