import 'package:spear_me_app/features/plant_head/domain/entity/bay_entity.dart';

class BayModel extends BayEntity {
  const BayModel({
    required super.id,
    required super.bayName,
    required super.factoryId,
  });

  factory BayModel.fromJson(Map<String, dynamic> json) {
    return BayModel(
      id: json["bayId"] ?? json["id"],
      bayName: json["bayName"] ?? "",
      factoryId: json["factoryId"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "bayId": id,
      "bayName": bayName,
      "factoryId": factoryId,
    };
  }
}
