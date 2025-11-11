import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/constants/api_constants.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/core/network/dio_client.dart';
import 'package:spear_me_app/features/plant_head/data/model/paginated_staff_model.dart';
import 'package:spear_me_app/features/plant_head/domain/entity/paginated_staff_entity.dart';

class GetDataSource {
  final DioClient client;

  GetDataSource(this.client);

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
}
