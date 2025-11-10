import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/plant_head/domain/entity/bay_entity.dart';

abstract class AddRepository {
  Future<Either<Failure, String>> createBay({
    required int plantHeadId,
    required String bayName,
  });

  Future<Either<Failure, String>> addChiefSupervisor({
    required String name,
    required String email,
  });

  Future<Either<Failure, String>> addWorker({
    required String name,
    required String email,
    required int bayId,
  });
  Future<Either<Failure, List<BayEntity>>> getBays();
}
