import 'package:dio/dio.dart';
import 'package:spear_me_app/core/shared_prefs/auth_local_storage.dart';

class AppInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!options.path.contains('login') && !options.path.contains('register')) {
      final token = await AuthLocalStorage.getToken();
      if (token != null) {
        options.headers["Authorization"] = "Bearer $token";
      }
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }
}
