import 'package:spear_me_app/features/owner/domain/entity/central_officer_entity.dart';

class OfficerModel extends OfficerEntity {
  OfficerModel({
    required super.id,
    required super.username,
    required super.email,
    required super.role,
    required super.isActive,
  });

  factory OfficerModel.fromJson(Map<String, dynamic> json) {
    return OfficerModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      role: json['role'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'role': role,
      'isActive': isActive,
    };
  }
}
