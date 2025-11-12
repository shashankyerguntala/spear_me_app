import 'package:spear_me_app/features/owner/domain/entity/tools_category_entity.dart';

class ToolCategoryModel extends ToolCategoryEntity {
  const ToolCategoryModel({
    required super.id,
    required super.name,
    required super.description,
  });

  factory ToolCategoryModel.fromJson(Map<String, dynamic> json) {
    return ToolCategoryModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
  };
}
