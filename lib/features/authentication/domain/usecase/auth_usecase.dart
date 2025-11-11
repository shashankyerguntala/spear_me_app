import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/authentication/domain/entity/login_response_entity.dart';
import 'package:spear_me_app/features/authentication/domain/repository/auth_repository.dart';

class AuthUsecase {
  final AuthRepository authRepository;

  AuthUsecase({required this.authRepository});

  Future<Either<Failure, String>> register(
    String username,
    String email,
    int number,
    String password,
  ) {
    return authRepository.register(username, email, number, password);
  }

  Future<Either<Failure, LoginResponseEntity>> login(
    String email,
    String password,
  ) {
    return authRepository.login(email, password);
  }

  Future<Either<Failure, String>> logout() {
    return authRepository.logout();
  }
}
