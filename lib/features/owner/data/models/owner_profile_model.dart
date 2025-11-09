import 'package:spear_me_app/features/owner/domain/entity/owner_entity.dart';

class OwnerProfileModel extends OwnerProfileEntity {
  const OwnerProfileModel({
    required super.username,
    required super.email,
    required super.role,
    super.phone,
    super.imageUrl,
  });

  factory OwnerProfileModel.fromJson(Map<String, dynamic> json) {
    return OwnerProfileModel(
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      role: json['role'] ?? '',
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "phone": phone,
      "role": role,
      "imageUrl": imageUrl,
    };
  }
}
