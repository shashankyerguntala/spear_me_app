import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/constants/api_constants.dart';
import 'package:spear_me_app/core/network/dio_client.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/plant_head/data/model/bay_model.dart';

import 'package:spear_me_app/features/plant_head/domain/entity/bay_entity.dart';

class AddDataSource {
  final DioClient dioClient;

  AddDataSource(this.dioClient);

  //! CREATE BAY
  Future<Either<Failure, String>> createBay({
    required int plantHeadId,
    required String bayName,
  }) async {
    final response = await dioClient.postRequest(
      ApiConstants.plantHeadCreateBay,

      data: {"bayName": bayName},
    );

    return response.fold((fail) => Left(fail), (data) {
      if (data["success"] == true) {
        return Right(data['message']);
      } else {
        return Left(Failure(data["message"]));
      }
    });
  }

  //!  ADD EMPLOYEE
  Future<Either<Failure, String>> addEmployee({
    required String name,
    required String email,
    required String role,
    int? bayId,
  }) async {
    final payload = {
      "name": name,
      "email": email,
      "role": role,
      if (bayId != null) "bayId": bayId,
    };

    final response = await dioClient.postRequest(
      ApiConstants.plantHeadCreateEmployee,
      data: payload,
    );

    return response.fold((fail) => Left(fail), (data) {
      if (data["success"] == true) {
        return Right(data['message']);
      } else {
        return Left(Failure(data["message"]));
      }
    });
  }

  //! GET BAYS
  Future<Either<Failure, List<BayEntity>>> getBays() async {
    final response = await dioClient.getRequest(ApiConstants.plantHeadGetBays);

    return response.fold((fail) => Left(fail), (data) {
      if (data["success"] == true) {
        final list = (data["data"] as List)
            .map((e) => BayModel.fromJson(e))
            .toList();
        return Right(list);
      } else {
        return Left(Failure(data["message"]));
      }
    });
  }
}
