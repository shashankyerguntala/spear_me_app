import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:spear_me_app/core/constants/api_constants.dart';
import 'package:spear_me_app/core/network/dio_client.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/owner/data/models/api_response_model.dart';
import 'package:spear_me_app/features/owner/data/models/central_office_model.dart';
import 'package:spear_me_app/features/owner/data/models/factory_details_model.dart';
import 'package:spear_me_app/features/owner/data/models/owner_data_model.dart';
import 'package:spear_me_app/features/owner/data/models/paged_employees_model.dart';
import 'package:spear_me_app/features/owner/data/models/paged_factory_model.dart';
import 'package:spear_me_app/features/owner/domain/entity/central_office_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/owner_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/paged_employees_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/paged_factories_entity.dart';

class OwnerDataSource {
  final DioClient dioClient;
  OwnerDataSource({required this.dioClient});

  //! use debouncer for search calls
  //! create CO
  Future<Either<Failure, String>> createCentralOfficer(
    String name,
    String email,
    int number,
  ) async {
    final Either<Failure, dynamic> response = await dioClient.postRequest(
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
    final Either<Failure, dynamic> response = await dioClient.postRequest(
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

  //! get central office
  Future<Either<Failure, List<CentralOfficeEntity>>> getCentralOffice() async {
    final response = await dioClient.getRequest(ApiConstants.getCentralOffice);
    return response.fold((fail) => left(fail), (json) {
      final ApiResponseModel<List<CentralOfficeEntity>> apiResponse =
          ApiResponseModel<List<CentralOfficeEntity>>.fromJson(
            json,
            (data) => (data as List)
                .map((e) => CentralOfficeModel.fromJson(e))
                .toList(),
          );
      return Right(apiResponse.data);
    });
  }

  //! get factories
  Future<Either<Failure, PagedFactoriesEntity>> getFactories({
    required String search,
    required int page,
    required int size,
    required String sort,
  }) async {
    final result = await dioClient.getRequest(
      ApiConstants.getFactories,
      queryParameters: {
        "search": search,
        "page": page,
        "size": size,
        "sort": sort,
      },
    );

    return result.fold((failure) => left(failure), (data) {
      final parsed = ApiResponseModel<PagedFactoriesEntity>.fromJson(
        data,
        (obj) => PagedFactoriesModel.fromJson(obj),
      );
      return right(parsed.data);
    });
  }

  //! get employees

  Future<Either<Failure, PagedEmployeesEntity>> getEmployees({
    required int page,
    required int size,
    String? search,
    String? role,
    String? sort,
    bool? ascending,
  }) async {
    final queryParameters = {
      "search": search,
      "role": role,
      "page": page,
      "size": size,
      if (sort != null) "sort": sort,
      if (ascending != null) "asc": ascending.toString(),
    };

    final result = await dioClient.getRequest(
      ApiConstants.getEmployees,
      queryParameters: queryParameters,
    );

    return result.fold((failure) => left(failure), (data) {
      final parsed = ApiResponseModel<PagedEmployeesEntity>.fromJson(
        data,
        (obj) => PagedEmployeesModel.fromJson(obj),
      );
      return right(parsed.data);
    });
  }

  //! get profile
  Future<Either<Failure, OwnerProfileEntity>> getProfile() async {
    final result = await dioClient.getRequest(ApiConstants.getProfile);
    return result.fold((failure) => left(failure), (data) {
      final parsed = ApiResponseModel<OwnerProfileEntity>.fromJson(
        data,
        (obj) => OwnerProfileModel.fromJson(obj),
      );
      return right(parsed.data);
    });
  }

  //! create plant head
  Future<Either<Failure, String>> createPlantHead({
    required String username,
    required String email,
  }) async {
    final result = await dioClient.postRequest(
      ApiConstants.createPlantHead,
      data: {"username": username, "email": email},
    );

    return result.fold((fail) => Left(fail), (data) {
      final message = data['message'] ?? "Something went wrong";

      if (data['success'] == true) {
        return Right(message);
      } else {
        return Left(Failure(message));
      }
    });
  }

  //! upload image
  Future<Either<Failure, String>> uploadProfileImage(String filePath) async {
    final formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(filePath),
    });

    final result = await dioClient.uploadRequest(
      ApiConstants.uploadProfileImage,
      formData: formData,
    );

    return result.fold((fail) => Left(fail), (data) {
      final message = data['message'] ?? 'Image uploaded successfully';
      return Right(message);
    });
  }

  //! get factory details
  Future<Either<Failure, FactoryDetailsModel>> getFactoryDetails({
    required int factoryId,
  }) async {
    final result = await dioClient.getRequest(
      ApiConstants.factoryDetails,
      queryParameters: {'factoryId': factoryId},
    );

    return result.fold((failure) => Left(failure), (data) {
      final parsed = ApiResponseModel<FactoryDetailsModel>.fromJson(
        data,
        (obj) => FactoryDetailsModel.fromJson(obj),
      );
      return Right(parsed.data);
    });
  }

  //! delete employee
  Future<Either<Failure, String>> deleteEmployee({
    required int employeeId,
  }) async {
    final result = await dioClient.deleteRequest(
      '${ApiConstants.deleteEmployee}/$employeeId',
    );

    return result.fold((fail) => Left(fail), (data) {
      final message = data['message'];

      if (data['success'] == true) {
        return Right(message);
      } else {
        return Left(Failure(message));
      }
    });
  }
}
