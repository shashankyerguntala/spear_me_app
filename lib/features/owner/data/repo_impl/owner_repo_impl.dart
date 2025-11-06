import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/owner/data/data_sources/owner_data_source.dart';
import 'package:spear_me_app/features/owner/domain/repository/owner_repository.dart';

class OwnerRepoImpl extends OwnerRepository {
  final OwnerDataSource ownerDataSource;

  OwnerRepoImpl({required this.ownerDataSource});
  @override
  Future<Either<Failure, String>> createCentralOfficer(String name,
    String email,
    int number,) {
    return ownerDataSource.createCentralOfficer(name,email,number);
  }
  
  @override
  Future<Either<Failure, String>> createFactory(String name, String city, String address, String email) {
      return ownerDataSource.createFactory(name,email,address,city);
  }
}
