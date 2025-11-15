import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:spear_me_app/core/constants/api_constants.dart';
import 'package:spear_me_app/core/network/dio_client.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/owner/data/models/api_response_model.dart';
import 'package:spear_me_app/features/owner/data/models/merchandise_model.dart';
import 'package:spear_me_app/features/owner/data/models/paginated_merchandise_model.dart';
import 'package:spear_me_app/features/owner/domain/entity/merchandise_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/paginated_merchandise_entity.dart';

class MerchandiseDataSource {
  final DioClient client;

  MerchandiseDataSource(this.client);

  //! add merchandise
  Future<Either<Failure, String>> addMerchandise({
    required String name,
    required int requiredPoints,
    required int availableQuantity,
    File? imageFile,
  }) async {
    final formData = FormData.fromMap({
      "name": name,
      "requiredPoints": requiredPoints,
      "availableQuantity": availableQuantity,
      if (imageFile != null)
        "image": await MultipartFile.fromFile(imageFile.path),
    });

    final response = await client.postRequest(
      ApiConstants.addMerchandise,
      data: formData,
      isMultipart: true,
    );

    return response.fold((fail) => Left(fail), (data) {
      if (data["success"] == true) {
        return Right(data["message"]);
      } else {
        return Left(Failure(data["message"] ?? "Failed to add merchandise"));
      }
    });
  }

  //! update merchandise
  Future<Either<Failure, String>> updateMerchandise({
    required int id,
    required String name,
    required int requiredPoints,
    required int availableQuantity,
    File? imageFile,
  }) async {
    final formData = FormData.fromMap({
      "name": name,
      "requiredPoints": requiredPoints,
      "availableQuantity": availableQuantity,
      if (imageFile != null)
        "image": await MultipartFile.fromFile(imageFile.path),
    });

    final response = await client.postRequest(
      "${ApiConstants.updateMerchandise}/$id",
      data: formData,
      isMultipart: true,
    );

    return response.fold((fail) => Left(fail), (data) {
      if (data["success"] == true) {
        return Right(data["message"]);
      } else {
        return Left(Failure(data["message"]));
      }
    });
  }

  //! delete merchandise
  Future<Either<Failure, String>> deleteMerchandise(int id) async {
    final response = await client.deleteRequest(
      "${ApiConstants.deleteMerchandise}/$id",
    );

    return response.fold((fail) => Left(fail), (data) {
      if (data["success"] == true) {
        return Right(data["message"] ?? "Merchandise deleted successfully");
      } else {
        return Left(Failure(data["message"] ?? "Failed to delete merchandise"));
      }
    });
  }

  //! get all merchandise
  Future<Either<Failure, PaginatedMerchandiseEntity>> getAllMerchandise({
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

    final result = await client.getRequest(
      ApiConstants.getAllMerchandise,
      queryParameters: queryParameters,
    );

    return result.fold((failure) => left(failure), (data) {
      final parsed = ApiResponseModel<PaginatedMerchandiseEntity>.fromJson(
        data,
        (obj) => PaginatedMerchandiseModel.fromJson(obj),
      );
      return right(parsed.data);
    });
  }

  //! restock merchandise

  Future<Either<Failure, MerchandiseEntity>> restockMerchandise({
    required int id,
    required int additionalQuantity,
  }) async {
    final response = await client.postRequest(
      "${ApiConstants.restockMerchandise}/$id",
      queryParameters: {"additionalQuantity": additionalQuantity},
    );

    return response.fold((fail) => Left(fail), (data) {
      if (data["success"] == true && data["data"] != null) {
        return Right(MerchandiseModel.fromJson(data["data"]));
      } else {
        return Left(
          Failure(data["message"] ?? "Failed to restock merchandise"),
        );
      }
    });
  }
}
