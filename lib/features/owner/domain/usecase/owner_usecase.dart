import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/owner/domain/entity/central_office_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/owner_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/paged_employees_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/paged_factories_entity.dart';
import 'package:spear_me_app/features/owner/domain/repository/owner_repository.dart';

class OwnerUsecase {
  final OwnerRepository ownerRepository;

  OwnerUsecase({required this.ownerRepository});

  //! create officer
  Future<Either<Failure, String>> createCentralOfficer(
    String name,
    String email,
    int number,
  ) {
    return ownerRepository.createCentralOfficer(name, email, number);
  }

  //! create factory
  Future<Either<Failure, String>> createFactory(
    String name,
    String city,
    String address,
    String email,
  ) {
    return ownerRepository.createFactory(name, email, address, city);
  }

  //! get CO
  Future<Either<Failure, List<CentralOfficeEntity>>> getCentralOffice() {
    return ownerRepository.getCentralOffice();
  }

  //! get factories
  Future<Either<Failure, PagedFactoriesEntity>> getFactories(
    String search,
    int page, {
    int size = 3,
    String sort = "name,asc",
  }) {
    return ownerRepository.getFactories(
      search: search,
      page: page,
      size: size,
      sort: sort,
    );
  }

  Future<Either<Failure, PagedEmployeesEntity>> getEmployees({
    required int page,
    required int size,

    String? search,
    String? role,
  }) {
    return ownerRepository.getEmployees(
      search: search,
      role: role,
      page: page,
      size: size,
    );
  }

  Future<Either<Failure, OwnerProfileEntity>> getOwnerProfile() {
    return ownerRepository.getOwnerProfile();
  }

  Future<Either<Failure, String>> createPlantHead({
    required String username,
    required String email,
  }) {
    return ownerRepository.createPlantHead(username: username, email: email);
  }

  Future<Either<Failure, String>> uploadProfileImage(String filePath) {
    return ownerRepository.uploadProfileImage(filePath);
  }
}
