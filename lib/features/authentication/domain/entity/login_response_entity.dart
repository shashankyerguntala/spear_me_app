class LoginResponseEntity {
  final bool success;
  final String token;
  final String message;
  final String username;
  final String role;

  const LoginResponseEntity({
    required this.success,
    required this.token,
    required this.message,
    required this.username,
    required this.role,
  });
}
