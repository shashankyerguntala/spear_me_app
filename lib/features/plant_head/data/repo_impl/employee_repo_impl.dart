import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/plant_head/data/data_source/get_data_source.dart';
import 'package:spear_me_app/features/plant_head/domain/entity/paginated_staff_entity.dart';
import 'package:spear_me_app/features/plant_head/domain/repository/employee_repository.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final GetDataSource dataSource;

  EmployeeRepositoryImpl(this.dataSource);

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
}
