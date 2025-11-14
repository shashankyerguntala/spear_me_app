import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/owner/domain/entity/central_office_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/factory_details_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/owner_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/paged_employees_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/paged_factories_entity.dart';

abstract class OwnerRepository {
  Future<Either<Failure, String>> createCentralOfficer(
    String name,
    String email,
    int number,
  );
  Future<Either<Failure, String>> createFactory(
    String name,
    String city,
    String address,
    String email,
  );

  Future<Either<Failure, List<CentralOfficeEntity>>> getCentralOffice();

  Future<Either<Failure, PagedFactoriesEntity>> getFactories({
    required String search,
    required int page,
    required int size,
    required String sort,
  });

  Future<Either<Failure, PagedEmployeesEntity>> getEmployees({
    required int page,
    required int size,
    String? search,
    String? role,
  });

  Future<Either<Failure, OwnerProfileEntity>> getOwnerProfile();
  Future<Either<Failure, String>> createPlantHead({
    required String username,
    required String email,
  });

  Future<Either<Failure, String>> uploadProfileImage(String filePath);

  Future<Either<Failure, FactoryDetailsEntity>> getFactoryDetails(
    int factoryId,
  );
  Future<Either<Failure, String>> deleteEmployee(int employeeId);
}
