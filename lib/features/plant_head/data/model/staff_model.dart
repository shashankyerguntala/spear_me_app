import 'package:spear_me_app/features/plant_head/domain/entity/staff_entity.dart';

class StaffModel extends StaffEntity {
  const StaffModel({
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    required super.factoryName,
    super.bayName,
  });

  factory StaffModel.fromJson(Map<String, dynamic> json) {
    return StaffModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      role: json["role"],
      factoryName: json["factoryName"],
      bayName: json["bayName"],
    );
  }
}
