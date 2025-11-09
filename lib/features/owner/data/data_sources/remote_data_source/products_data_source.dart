import 'package:dartz/dartz.dart';

import 'package:spear_me_app/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:spear_me_app/core/network/dio_client.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/owner/data/models/paged_products_model.dart';
import 'package:spear_me_app/features/owner/data/models/product_category_model.dart';
import 'package:spear_me_app/features/owner/domain/entity/paged_products_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/product_category_entity.dart';

class ProductsDataSource {
  final DioClient dioClient;

  ProductsDataSource(this.dioClient);

  //! CREATE PRODUCT CATEGORY
  Future<Either<Failure, String>> createCategory({
    required String name,
    required String description,
  }) async {
    final response = await dioClient.postRequest(
      ApiConstants.createProductCategory,
      data: {"categoryName": name, "description": description},
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

  //! 14. UPDATE PRODUCT CATEGORY
  Future<Either<Failure, String>> updateCategory({
    required int id,
    required String name,
    required String description,
  }) async {
    final response = await dioClient.putRequest(
      "${ApiConstants.updateProductCategory}/$id",
      data: {"categoryName": name, "description": description},
    );

    return response.fold((fail) => Left(fail), (data) {
      final message = data['message'];
      return data['success'] == true ? Right(message) : Left(Failure(message));
    });
  }

  //! GET PRODUCT CATEGORIES
  Future<Either<Failure, List<ProductCategoryEntity>>> getCategories({
    String sortBy = "categoryName",
    String sortDir = "asc",
  }) async {
    final response = await dioClient.getRequest(
      ApiConstants.getProductCategory,
      queryParameters: {"sortBy": sortBy, "sortDir": sortDir},
    );

    return response.fold((fail) => Left(fail), (data) {
      final list = (data['data'] as List)
          .map((e) => ProductCategoryModel.fromJson(e))
          .toList();
      return Right(list);
    });
  }

  //! DELETE CATEGORY
  Future<Either<Failure, String>> deleteCategory(int id) async {
    final response = await dioClient.deleteRequest(
      "${ApiConstants.deleteProductCategory}/$id",
    );

    return response.fold(
      (fail) => Left(fail),
      (data) => data['success'] == true
          ? Right(data['message'])
          : Left(Failure(data['message'])),
    );
  }

  //!  UPLOAD PRODUCT
  Future<Either<Failure, String>> addProduct({
    required String name,
    required String description,
    required double price,
    required int rewardPts,
    required int categoryId,
    required int? threshold,
    required String imagePath,
  }) async {
    final formData = FormData.fromMap({
      "name": name,
      "prodDescription": description,
      "price": price.toString(),
      "rewardPts": rewardPts.toString(),
      "categoryId": categoryId.toString(),
      if (threshold != null) "threshold": threshold.toString(),
      "image": await MultipartFile.fromFile(imagePath),
    });

    final response = await dioClient.uploadRequest(
      ApiConstants.uploadProduct,
      formData: formData,
    );

    return response.fold((fail) => Left(fail), (data) {
      if (data['success'] != true) {
        return Left(Failure(data["message"]));
      }
      return Right(data['message']);
    });
  }

  //! 18. GET PRODUCTS (SEARCH + FILTER + PAGINATION)
  Future<Either<Failure, PagedProductsEntity>> getProducts({
    String? search,
    String? categoryName,
    int page = 0,
    int size = 20,
  }) async {
    final query = {
      "page": "$page",
      "size": "$size",
      if (search != null && search.isNotEmpty) "search": search,
      if (categoryName != null && categoryName.isNotEmpty)
        "categoryName": categoryName,
    };

    final response = await dioClient.getRequest(
      ApiConstants.getProducts,
      queryParameters: query,
    );

    return response.fold(
      (fail) => Left(fail),
      (data) => Right(PagedProductsModel.fromJson(data['data'])),
    );
  }

  //! DELETE PRODUCT
  Future<Either<Failure, String>> deleteProduct(int productId) async {
    final response = await dioClient.deleteRequest(
      "${ApiConstants.deleteProduct}/$productId",
    );

    return response.fold(
      (fail) => Left(fail),
      (data) => Right(data['message']),
    );
  }
}
