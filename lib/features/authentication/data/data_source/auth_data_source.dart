import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/constants/api_constants.dart';
import 'package:spear_me_app/core/network/dio_client.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/authentication/data/model/login_response_model.dart';
import 'package:spear_me_app/features/authentication/domain/entity/login_response_entity.dart';

class AuthDataSource {
  final DioClient dioClient;

  AuthDataSource({required this.dioClient});
  //! register

  Future<Either<Failure, String>> register(
    String username,
    String email,
    String password,
    int phoneNumber,
  ) async {
    final Either<Failure, dynamic> result = await dioClient.postRequest(
      ApiConstants.register,
      data: <String, dynamic>{
        "username": username,
        "email": email,
        "password": password,
        "phone": phoneNumber,
      },
    );

    return result.fold((Failure fail) => Left(fail), (data) {
      final String message = data['message'];

      return Right(message);
    });
  }

  //! login

  Future<Either<Failure, LoginResponseEntity>> login(
    String email,
    String password,
  ) async {
    final Either<Failure, dynamic> result = await dioClient.postRequest(
      ApiConstants.login,
      data: <String, dynamic>{"email": email, "password": password},
    );

    return result.fold((Failure fail) => Left(fail), (data) {
      final LoginResponseModel response = LoginResponseModel.fromJson(data);

      return Right(response);
    });
  }

  //! logout
  Future<Either<Failure, String>> logout() async {
    final Either<Failure, dynamic> result = await dioClient.postRequest(
      ApiConstants.logout,
    );

    return result.fold((Failure fail) => Left(fail), (data) {
      final String message = data['message'];

      return Right(message);
    });
  }
}
