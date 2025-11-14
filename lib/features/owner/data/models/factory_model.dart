import 'package:spear_me_app/features/owner/domain/entity/factory_entity.dart';

class FactoryModel extends FactoryEntity {
  FactoryModel({
    required super.name,
    required super.city,
    required super.address,
    required super.plantHeadEmail,
    required super.factoryId,
  });

  factory FactoryModel.fromJson(Map<String, dynamic> json) {
    return FactoryModel(
      name: json['name'] ?? '',
      city: json['city'] ?? '',
      address: json['address'] ?? '',
      plantHeadEmail: json['plantHeadEmail'] ?? '',
      factoryId: json['factoryId'],
    );
  }
}
