import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/authentication/data/data_source/auth_data_source.dart';
import 'package:spear_me_app/features/authentication/domain/entity/login_response_entity.dart';
import 'package:spear_me_app/features/authentication/domain/repository/auth_repository.dart';

class AuthRepoImpl extends AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepoImpl({required this.authDataSource});

  @override
  Future<Either<Failure, LoginResponseEntity>> login(
    String email,
    String password,
  ) async {
    return await authDataSource.login(email, password);
  }

  @override
  Future<Either<Failure, String>> register(
    String username,
    String email,
    int number,
    String password,
  ) async {
    return await authDataSource.register(username, email, password, number);
  }

  @override
  Future<Either<Failure, String>> logout() {
    return authDataSource.logout();
  }
}
