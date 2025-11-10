import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/plant_head/data/data_source/add_data_source.dart';
import 'package:spear_me_app/features/plant_head/domain/entity/bay_entity.dart';
import 'package:spear_me_app/features/plant_head/domain/repository/add_repository.dart';

class AddRepositoryImpl implements AddRepository {
  final AddDataSource dataSource;

  AddRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, String>> createBay({
    required int plantHeadId,
    required String bayName,
  }) async {
    final result = await dataSource.createBay(
      plantHeadId: plantHeadId,
      bayName: bayName,
    );

    return result.fold((fail) => Left(fail), (message) => Right(message));
  }

  @override
  Future<Either<Failure, String>> addChiefSupervisor({
    required String name,
    required String email,
  }) async {
    return dataSource.addEmployee(
      name: name,
      email: email,
      role: "CHIEF_SUPERVISOR",
    );
  }

  @override
  Future<Either<Failure, String>> addWorker({
    required String name,
    required String email,
    required int bayId,
  }) async {
    return dataSource.addEmployee(
      name: name,
      email: email,
      role: "WORKER",
      bayId: bayId,
    );
  }

  @override
  Future<Either<Failure, List<BayEntity>>> getBays() {
    return dataSource.getBays();
  }
}
