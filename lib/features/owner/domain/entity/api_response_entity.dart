// TODO(Shashank): you can also extend your entities to Equatable class because you're using it in blocs too.

class ApiResponseEntity<T> {
  final bool success;
  final String message;
  final T data;

  ApiResponseEntity({
    required this.success,
    required this.message,
    required this.data,
  });
}
