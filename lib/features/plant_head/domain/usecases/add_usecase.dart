import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/plant_head/domain/entity/bay_entity.dart';
import 'package:spear_me_app/features/plant_head/domain/repository/add_repository.dart';

class AddUsecase {
  final AddRepository repository;

  AddUsecase(this.repository);

  Future<Either<Failure, String>> createBay({
    required int plantHeadId,
    required String bayName,
  }) {
    return repository.createBay(plantHeadId: plantHeadId, bayName: bayName);
  }

  Future<Either<Failure, String>> addChiefSupervisor({
    required String name,
    required String email,
  }) {
    return repository.addChiefSupervisor(name: name, email: email);
  }

  Future<Either<Failure, String>> addWorker({
    required String name,
    required String email,
    required int bayId,
  }) {
    return repository.addWorker(name: name, email: email, bayId: bayId);
  }

  Future<Either<Failure, List<BayEntity>>> getBays() {
    return repository.getBays();
  }
}
