import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/constants/api_constants.dart';
import 'package:spear_me_app/core/network/dio_client.dart';
import 'package:spear_me_app/core/network/failure.dart';

class OwnerDataSource {
  final DioClient dioClient;

  OwnerDataSource({required this.dioClient});

  //! create central officer
  Future<Either<Failure, String>> createCentralOfficer(
    String name,
    String email,
    int number,
  ) async {
    final Either<Failure, Map<String, dynamic>> response = await dioClient
        .postRequest(
          ApiConstants.createCentralOfficer,
          data: {
            "centralOfficerEmail": email,
            "centralOfficeHeadName": name,
            "phone": number,
          },
        );

    return response.fold((fail) => Left(fail), (data) {
      final message = data['message'];
      if (data['success'] == true) {
        return Right(message);
      } else {
        return Left(Failure(message));
      }
    });
  }

  //! create factory
  Future<Either<Failure, String>> createFactory(
    String name,
    String city,
    String address,
    String email,
  ) async {
    final Either<Failure, Map<String, dynamic>> response = await dioClient
        .postRequest(
          ApiConstants.createFactory,
          data: {
            "name": name,
            "city": city,
            "address": address,
            "centralOfficeId": 1,
            "plantHeadEmail": email,
          },
        );

    return response.fold((fail) => Left(fail), (data) {
      final message = data['message'];
      if (data['success'] == true) {
        return Right(message);
      } else {
        return Left(Failure(message));
      }
    });
  }
}
