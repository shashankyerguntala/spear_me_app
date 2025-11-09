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
    final data = json['data'] ?? json;

    return OwnerProfileModel(
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'],
      role: data['role'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
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
