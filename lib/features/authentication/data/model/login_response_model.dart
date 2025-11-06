import 'package:spear_me_app/features/authentication/domain/entity/login_response_entity.dart';

class LoginResponseModel extends LoginResponseEntity {
  const LoginResponseModel({
    required super.success,
    required super.token,
    required super.message,
    required super.username,
    required super.role,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'] as bool,
      token: json['token'] as String,
      message: json['message'] as String,
      username: json['username'] as String,
      role: json['role'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'success': success,
      'token': token,
      'message': message,
      'username': username,
      'role': role,
    };
  }
}
