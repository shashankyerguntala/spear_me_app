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

  // TODO(Shashank): you are folding the response twice, once in data source, once in bloc
  // return response directly in data source, and fold it in bloc.

    return response.fold((fail) => Left(fail), (data) {
      if (data["success"] == true) {
        return Right(data['message']);
      } else {
        return Left(Failure(data["message"]));
      }
    });
  }

  // do something like this below, add a response parser here
  
  //   @override
  // Future<Either<Failure, ReportAnIssueResponseModel>> reportAnIssue({
  //   required final ReportAnIssueRequestModel reportAnIssueRequest,
  // }) async {
  //   return _httpApiClient.request<ReportAnIssueResponseModel>(
  //     url: DataSourceConstantsMainUrl.raiseTicket,
  //     method: HttpMethod.post,
  //     data: reportAnIssueRequest.toJson(),
  //     responseParser: (final Map<String, dynamic> json) =>
  //         ReportAnIssueResponseModel.fromJson(json['data']),
  //   );
  // }

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
