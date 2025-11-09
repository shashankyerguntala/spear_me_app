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
