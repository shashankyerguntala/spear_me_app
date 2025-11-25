import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:spear_me_app/core/constants/api_constants.dart';
import 'package:spear_me_app/core/network/error_handler.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/core/network/interceptor.dart';

class DioClient {
  final Dio dio;

  DioClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          headers: {'Content-Type': 'application/json'},
        ),
      ) {
    dio.interceptors.add(AppInterceptor());
  }

  Either<Failure, dynamic> _handleResponse(Response response) {
    final data = response.data;

    if (data is Map && data.containsKey('success')) {
      final success = data['success'] == true;

      if (!success) {
        return Left(Failure(data['message'] ?? 'Unknown server error'));
      }

      return Right(data);
    }

    return Right(data);
  }

  Future<Either<Failure, dynamic>> getRequest(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(validateStatus: (_) => true),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  Future<Either<Failure, dynamic>> postRequest(
    String endpoint, {
    data,
    Map<String, dynamic>? queryParameters,
    bool isMultipart = false,
  }) async {
    try {
      final response = await dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: isMultipart
            ? Options(
                contentType: 'multipart/form-data',
                validateStatus: (_) => true,
              )
            : Options(validateStatus: (_) => true),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  Future<Either<Failure, dynamic>> putRequest(String endpoint, {data}) async {
    try {
      final response = await dio.put(
        endpoint,
        data: data,
        options: Options(validateStatus: (_) => true),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  Future<Either<Failure, dynamic>> deleteRequest(String endpoint) async {
    try {
      final response = await dio.delete(
        endpoint,
        options: Options(validateStatus: (_) => true),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  Future<Either<Failure, dynamic>> uploadRequest(
    String endpoint, {
    required FormData formData,
  }) async {
    try {
      final response = await dio.post(
        endpoint,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          validateStatus: (_) => true,
        ),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
