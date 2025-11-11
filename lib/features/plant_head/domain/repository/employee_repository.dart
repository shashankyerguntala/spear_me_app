import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/plant_head/domain/entity/paginated_staff_entity.dart';

abstract class EmployeeRepository {
  Future<Either<Failure, PaginatedStaffEntity>> getEmployees({
    required int page,
    required int size,
    String? keyword,
    String? roleStr,
  });
}
