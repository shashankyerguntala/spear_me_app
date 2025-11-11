import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/plant_head/domain/entity/paginated_staff_entity.dart';
import 'package:spear_me_app/features/plant_head/domain/repository/employee_repository.dart';

class EmployeesUsecase {
  final EmployeeRepository repository;

  EmployeesUsecase(this.repository);

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
}
