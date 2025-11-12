import 'package:spear_me_app/features/owner/domain/entity/tools_entity.dart';

class ToolModel extends ToolEntity {
  const ToolModel({
    required super.id,
    required super.name,
    super.categoryName,
    super.type,
    super.isExpensive,
    super.threshold,
    super.image,
  });

  factory ToolModel.fromJson(Map<String, dynamic> json) {
    return ToolModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] ?? '',
      categoryName: json['categoryName'],
      type: json['type'],
      isExpensive: json['isExpensive'],
      threshold: (json['threshold'] as num?)?.toInt(),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'categoryName': categoryName,
    'type': type,
    'isExpensive': isExpensive,
    'threshold': threshold,
    'image': image,
  };
}
