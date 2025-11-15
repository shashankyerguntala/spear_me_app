import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/owner/data/data_sources/remote_data_source/owner_data_source.dart';
import 'package:spear_me_app/features/owner/domain/entity/central_office_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/factory_details_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/owner_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/paged_employees_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/paged_factories_entity.dart';
import 'package:spear_me_app/features/owner/domain/repository/owner_repository.dart';

class OwnerRepoImpl extends OwnerRepository {
  final OwnerDataSource ownerDataSource;

  OwnerRepoImpl({required this.ownerDataSource});
  @override
  Future<Either<Failure, String>> createCentralOfficer(
    String name,
    String email,
    int number,
  ) {
    return ownerDataSource.createCentralOfficer(name, email, number);
  }

  @override
  Future<Either<Failure, String>> createFactory(
    String name,
    String city,
    String address,
    String email,
  ) {
    return ownerDataSource.createFactory(name, email, address, city);
  }

  @override
  Future<Either<Failure, List<CentralOfficeEntity>>> getCentralOffice() {
    return ownerDataSource.getCentralOffice();
  }

  @override
  Future<Either<Failure, PagedFactoriesEntity>> getFactories({
    required String search,
    required int page,
    required int size,
    required String sort,
  }) {
    return ownerDataSource.getFactories(
      search: search,
      page: page,
      size: size,
      sort: sort,
    );
  }

  @override
  Future<Either<Failure, PagedEmployeesEntity>> getEmployees({
    required int page,
    required int size,
    String? search,
    String? role,
    String? sort,
    bool? asc,
  }) {
    return ownerDataSource.getEmployees(
      page: page,
      size: size,
      search: search,
      role: role,
      sort: sort,
      ascending: asc,
    );
  }

  @override
  Future<Either<Failure, OwnerProfileEntity>> getOwnerProfile() {
    return ownerDataSource.getProfile();
  }

  @override
  Future<Either<Failure, String>> createPlantHead({
    required String username,
    required String email,
  }) {
    return ownerDataSource.createPlantHead(username: username, email: email);
  }

  @override
  Future<Either<Failure, String>> uploadProfileImage(String filePath) {
    return ownerDataSource.uploadProfileImage(filePath);
  }

  @override
  Future<Either<Failure, FactoryDetailsEntity>> getFactoryDetails(
    int factoryId,
  ) {
    return ownerDataSource.getFactoryDetails(factoryId: factoryId);
  }

  @override
  Future<Either<Failure, String>> deleteEmployee(int employeeId) {
    return ownerDataSource.deleteEmployee(employeeId: employeeId);
  }
}
