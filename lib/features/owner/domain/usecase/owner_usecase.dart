import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
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
}
