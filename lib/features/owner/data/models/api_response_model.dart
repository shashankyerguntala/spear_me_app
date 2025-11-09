import 'package:spear_me_app/features/owner/domain/entity/api_response_entity.dart';

class ApiResponseModel<T> extends ApiResponseEntity {
  ApiResponseModel({
    required super.success,
    required super.message,
    required super.data,
  });

  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,

    // ignore: avoid_annotating_with_dynamic
    T Function(dynamic) dataParser,
  ) {
    return ApiResponseModel<T>(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: dataParser(json['data']),
    );
  }
}
