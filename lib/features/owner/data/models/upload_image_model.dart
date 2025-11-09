import 'package:spear_me_app/features/owner/domain/entity/upload_profile_image_entity.dart';

class UploadProfileImageModel extends UploadProfileImageEntity {
  const UploadProfileImageModel({
    required super.imageUrl,
    required super.message,
  });

  factory UploadProfileImageModel.fromJson(Map<String, dynamic> json) {
    return UploadProfileImageModel(
      imageUrl: json["imageUrl"] ?? "",
      message: json["message"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {"imageUrl": imageUrl, "message": message};
  }
}
