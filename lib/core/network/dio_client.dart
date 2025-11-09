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
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
          headers: <String, dynamic>{'Content-Type': 'application/json'},
        ),
      ) {
    dio.interceptors.add(AppInterceptor());
  }

  //! Learn to Use reponse parser
  Future<Either<Failure, dynamic>> getRequest(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response response = await dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(validateStatus: (int? status) => true),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> postRequest(
    String endpoint, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final Response response = await dio.post(
        endpoint,
        data: data,
        options: Options(validateStatus: (int? status) => true),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  Future<Either<Failure, dynamic>> putRequest(
    String endpoint, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final Response response = await dio.put(
        endpoint,
        data: data,
        options: Options(validateStatus: (int? status) => true),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  Future<Either<Failure, dynamic>> deleteRequest(String endpoint) async {
    try {
      final Response response = await dio.delete(
        endpoint,
        options: Options(validateStatus: (int? status) => true),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  Future<Either<Failure, dynamic>> uploadRequest(
    String endpoint, {
    required FormData formData,
  }) async {
    try {
      final Response response = await dio.post(
        endpoint,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          validateStatus: (int? status) => true,
        ),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
