// import 'package:dio/dio.dart';
// import 'package:spear_me_app/core/constants/api_constants.dart';

// class DioClient {
//   final Dio dio;

//   DioClient()
//     : dio = Dio(
//         BaseOptions(
//           baseUrl: ApiConstants.baseUrl,
//           connectTimeout: const Duration(seconds: 8),
//           receiveTimeout: const Duration(seconds: 8),
//           headers: {"Content-Type": "application/json"},
//         ),
//       ) {
//     dio.interceptors.add(AppInterceptor());
//   }
//   //! Learn to Use reponse parser
//   Future<Either<Failure, dynamic>> getRequest(
//     String endpoint, {
//     Map<String, dynamic>? query,
//   }) async {
//     try {
//       final response = await dio.get(
//         endpoint,
//         queryParameters: query,
//         options: Options(validateStatus: (status) => true),
//       );
//       return Right(response.data);
//     } on DioException catch (e) {
//       return Left(ErrorHandler.handle(e));
//     }
//   }

//   Future<Either<Failure, dynamic>> postRequest(
//     String endpoint, {
//     Map<String, dynamic>? data,
//   }) async {
//     try {
//       final response = await dio.post(
//         endpoint,
//         data: data,
//         options: Options(validateStatus: (status) => true),
//       );
//       return Right(response.data);
//     } on DioException catch (e) {
//       return Left(ErrorHandler.handle(e));
//     }
//   }

//   Future<Either<Failure, dynamic>> putRequest(
//     String endpoint, {
//     Map<String, dynamic>? data,
//   }) async {
//     try {
//       final response = await dio.put(
//         endpoint,
//         data: data,
//         options: Options(validateStatus: (status) => true),
//       );
//       return Right(response.data);
//     } on DioException catch (e) {
//       return Left(ErrorHandler.handle(e));
//     }
//   }

//   Future<Either<Failure, dynamic>> deleteRequest(String endpoint) async {
//     try {
//       final response = await dio.delete(
//         endpoint,
//         options: Options(validateStatus: (status) => true),
//       );
//       return Right(response.data);
//     } on DioException catch (e) {
//       return Left(ErrorHandler.handle(e));
//     }
//   }
// }
