import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';

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
}
