import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/authentication/domain/entity/login_response_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> register(
    String username,
    String email,
    int number,
    String password,
  );
  Future<Either<Failure, LoginResponseEntity>> login(
    String email,
    String password,
  );
  Future<Either<Failure, String>> logout();
}
