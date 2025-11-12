import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/owner/domain/entity/product_entity.dart';
import 'package:spear_me_app/features/plant_head/domain/entity/paginated_staff_entity.dart';
import 'package:spear_me_app/features/plant_head/domain/repository/get_repository.dart';

class GetUsecase {
  final GetRepository repository;

  GetUsecase(this.repository);

  Future<Either<Failure, PaginatedStaffEntity>> getEmployees({
    required int page,
    required int size,
    String? keyword,
    String? roleStr,
  }) {
    return repository.getEmployees(
      page: page,
      size: size,
      keyword: keyword,
      roleStr: roleStr,
    );
  }

  Future<Either<Failure, List<ProductEntity>>> getProducts() {
    return repository.getProducts();
  }

  Future<Either<Failure, List<ProductEntity>>> getLowStockProducts() {
    return repository.getLowStockProducts();
  }
}
