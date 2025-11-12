import 'package:spear_me_app/features/owner/domain/entity/merchandise_entity.dart';

class MerchandiseModel extends MerchandiseEntity {
  const MerchandiseModel({
    required super.id,
    required super.name,
    required super.requiredPoints,
    required super.availableQuantity,
    super.imageUrl,
  });

  factory MerchandiseModel.fromJson(Map<String, dynamic> json) {
    return MerchandiseModel(
      id: (json['id'] ?? json['merchandiseId']) as int,
      name: json['name'] ?? '',
      requiredPoints: (json['requiredPoints'] as num?)?.toInt() ?? 0,
      availableQuantity: (json['availableQuantity'] as num?)?.toInt() ?? 0,
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "requiredPoints": requiredPoints,
      "availableQuantity": availableQuantity,
      "imageUrl": imageUrl,
    };
  }
}
