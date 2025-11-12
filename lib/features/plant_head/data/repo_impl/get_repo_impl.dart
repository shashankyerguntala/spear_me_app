import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/owner/domain/entity/product_entity.dart';
import 'package:spear_me_app/features/plant_head/data/data_source/get_data_source.dart';
import 'package:spear_me_app/features/plant_head/domain/entity/paginated_staff_entity.dart';
import 'package:spear_me_app/features/plant_head/domain/repository/get_repository.dart';

class GetRepoImpl implements GetRepository {
  final GetDataSource dataSource;

  GetRepoImpl(this.dataSource);

  @override
  Future<Either<Failure, PaginatedStaffEntity>> getEmployees({
    required int page,
    required int size,
    String? keyword,
    String? roleStr,
  }) {
    return dataSource.getEmployees(
      page: page,
      size: size,
      keyword: keyword,
      roleStr: roleStr,
    );
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() {
    return dataSource.getProducts();
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getLowStockProducts() {
    return dataSource.getLowStockProducts();
  }
}
