import 'package:dio/dio.dart';

class AppInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!options.path.contains('login') && !options.path.contains('register')) {
      // final token = await AuthLocalStorage.getToken();
      // if (token != null) {
      //   options.headers["Authorization"] = "Bearer $token";
      // }
    }

    return handler.next(options);
  }

  @override
  // ignore: always_specify_types
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }
}
