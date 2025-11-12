import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/constants/api_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/core/network/dio_client.dart';
import 'package:spear_me_app/features/owner/data/models/api_response_model.dart';
import 'package:spear_me_app/features/owner/data/models/product_model.dart';
import 'package:spear_me_app/features/owner/domain/entity/product_entity.dart';
import 'package:spear_me_app/features/plant_head/data/model/paginated_staff_model.dart';
import 'package:spear_me_app/features/plant_head/domain/entity/paginated_staff_entity.dart';

class GetDataSource {
  final DioClient client;

  GetDataSource(this.client);
  //! get employees
  Future<Either<Failure, PaginatedStaffEntity>> getEmployees({
    required int page,
    required int size,
    required String? keyword,
    required String? roleStr,
  }) async {
    final response = await client.getRequest(
      ApiConstants.plantHeadGetEmployees,
      queryParameters: {
        "page": page,
        "size": size,
        "keyword": keyword?.trim().isNotEmpty == true ? keyword!.trim() : null,
        "roleStr": roleStr?.trim().isNotEmpty == true ? roleStr!.trim() : null,
      },
    );

    return response.fold((failure) => Left(failure), (data) {
      if (data["success"] == true) {
        return Right(PaginatedStaffModel.fromJson(data["data"]));
      } else {
        return Left(Failure(data["message"]));
      }
    });
  }

  //! get products
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    final response = await client.getRequest(ApiConstants.plantHeadGetProducts);

    return response.fold((failure) => Left(failure), (json) {
      if (json['success'] == true && json['data'] != null) {
        final List<dynamic> dataList = json['data'] as List<dynamic>;

        final products = dataList
            .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList();

        return Right(products);
      } else {
        return Left(
          Failure(json['message'] ?? StringConstants.failedToFetchProducts),
        );
      }
    });
  }

  //! get low stock products
  Future<Either<Failure, List<ProductEntity>>> getLowStockProducts() async {
    final response = await client.getRequest(
      ApiConstants.plantHeadGetLowStockProducts,
    );

    return response.fold((failure) => Left(failure), (json) {
      if (json['success'] == true && json['data'] != null) {
        final List<dynamic> dataList = json['data'] as List<dynamic>;

        final products = dataList
            .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList();

        return Right(products);
      } else {
        return Left(
          Failure(json['message'] ?? StringConstants.failedToFetchProducts),
        );
      }
    });
  }
}
