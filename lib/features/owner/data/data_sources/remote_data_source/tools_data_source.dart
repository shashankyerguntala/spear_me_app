import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:spear_me_app/core/constants/api_constants.dart';
import 'package:spear_me_app/core/network/dio_client.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/owner/data/models/tools_category_model.dart';
import 'package:spear_me_app/features/owner/data/models/tools_model.dart';
import 'package:spear_me_app/features/owner/domain/entity/tools_entity.dart';

class ToolDataSource {
  final DioClient client;

  ToolDataSource(this.client);

  //!  Add Tool Category
  Future<Either<Failure, String>> addToolCategory({
    required String name,
    required String description,
  }) async {
    final response = await client.postRequest(
      ApiConstants.toolsCreateCategory,
      data: {"name": name, "description": description},
    );

    return response.fold(
      (fail) => Left(fail),
      (data) => data["success"] == true
          ? Right(data["message"])
          : Left(Failure(data["message"] ?? "Unknown error")),
    );
  }

  //!  Get All Tool Categories
  Future<Either<Failure, List<ToolCategoryModel>>> getToolCategories() async {
    final response = await client.getRequest(ApiConstants.toolsGetCategory);

    return response.fold((fail) => Left(fail), (data) {
      if (data["success"] == true && data["data"] != null) {
        final list = (data["data"] as List)
            .map((e) => ToolCategoryModel.fromJson(e))
            .toList();
        return Right(list);
      } else {
        return Left(Failure(data["message"] ?? "Failed to fetch categories"));
      }
    });
  }

  //!  Update Tool Category
  Future<Either<Failure, String>> updateToolCategory({
    required int id,
    required String name,
    required String description,
  }) async {
    final response = await client.postRequest(
      "${ApiConstants.updateCategory}/$id",
      data: {"name": name, "description": description},
    );

    return response.fold(
      (fail) => Left(fail),
      (data) => data["success"] == true
          ? Right(data["message"])
          : Left(Failure(data["message"] ?? "Failed to update category")),
    );
  }

  //! Delete Tool Category
  Future<Either<Failure, String>> deleteToolCategory(int id) async {
    final response = await client.deleteRequest(
      "${ApiConstants.deleteToolCategory}/$id",
    );

    return response.fold(
      (fail) => Left(fail),
      (data) => data["success"] == true
          ? Right(data["message"] ?? "Deleted successfully")
          : Left(Failure(data["message"] ?? "Failed to delete category")),
    );
  }

  //! Create Tool
  Future<Either<Failure, String>> createTool({
    required String name,
    required int categoryId,
    required String type,
    required String isExpensive,
    required int threshold,
  }) async {
    final response = await client.postRequest(
      ApiConstants.createTool,
      data: {
        "name": name,
        "categoryId": categoryId,
        "type": type,
        "isExpensive": isExpensive,
        "threshold": threshold,
      },
    );

    return response.fold(
      (fail) => Left(fail),
      (data) => data["success"] == true
          ? Right(data["message"])
          : Left(Failure(data["message"] ?? "Failed to create tool")),
    );
  }

  //! Update Tool Image
  Future<Either<Failure, String>> updateToolImage({
    required int toolId,
    required String imagePath,
  }) async {
    final formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(imagePath),
    });

    final response = await client.postRequest(
      ApiConstants.updateToolImage,
      data: formData,
      isMultipart: true,
    );

    return response.fold(
      (fail) => Left(fail),
      (data) => data["success"] == true
          ? Right(data["message"])
          : Left(Failure(data["message"] ?? "Failed to update image")),
    );
  }

  //! Update Tool Details
  Future<Either<Failure, String>> updateTool({
    required int toolId,
    required String name,
    required int categoryId,
    required String toolType,
    required String isExpensive,
    required int threshold,
  }) async {
    final response = await client.postRequest(
      "${ApiConstants.updateTool}/$toolId",
      data: {
        "name": name,
        "categoryId": categoryId,
        "toolType": toolType,
        "isExpensive": isExpensive,
        "threshold": threshold,
      },
    );

    return response.fold(
      (fail) => Left(fail),
      (data) => data["success"] == true
          ? Right(data["message"])
          : Left(Failure(data["message"] ?? "Failed to update tool")),
    );
  }

  //!. Add Tool Quantity (Factory Stock)
  Future<Either<Failure, String>> addToolToFactory({
    required int toolId,
    required int quantity,
  }) async {
    final response = await client.postRequest(
      ApiConstants.addToolToFactoryStock,
      data: {"toolId": toolId, "quantity": quantity},
    );

    return response.fold(
      (fail) => Left(fail),
      (data) => data["success"] == true
          ? Right(data["message"])
          : Left(Failure(data["message"])),
    );
  }

  //! get all tools

  Future<Either<Failure, List<ToolEntity>>> getAllTools({
  String? searchName,
  String? categoryName,
  String? type,
  int page = 0,
  int size = 10,
  String sortBy = "createdAt",
  String sortDir = "desc",
}) async {
  final query = {
    "page": "$page",
    "size": "$size",
    "sortBy": sortBy,
    "sortDir": sortDir,
    if (searchName != null && searchName.isNotEmpty) "searchName": searchName,
    if (categoryName != null && categoryName.isNotEmpty)
        "categoryName": categoryName,
    if (type != null && type.isNotEmpty) "type": type,
  };

  final result = await client.getRequest(
    ApiConstants.getAllTools,
    queryParameters: query,
  );

  return result.fold(
    (fail) => Left(fail),
    (json) {
      final List<dynamic> data = json["data"] ?? [];
      final tools = data.map((e) => ToolModel.fromJson(e)).toList();
      return Right(tools);
    },
  );
}

}
