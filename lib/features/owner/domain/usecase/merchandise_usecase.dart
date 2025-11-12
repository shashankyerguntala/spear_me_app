import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/owner/domain/entity/merchandise_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/paginated_merchandise_entity.dart';
import 'package:spear_me_app/features/owner/domain/repository/merchandise_repository.dart';

class MerchandiseUsecase {
  final MerchandiseRepository repository;

  MerchandiseUsecase(this.repository);

  Future<Either<Failure, MerchandiseEntity>> add({
    required String name,
    required int requiredPoints,
    required int availableQuantity,
    File? imageFile,
  }) {
    return repository.addMerchandise(
      name: name,
      requiredPoints: requiredPoints,
      availableQuantity: availableQuantity,
      imageFile: imageFile,
    );
  }

  Future<Either<Failure, MerchandiseEntity>> update({
    required int id,
    required String name,
    required int requiredPoints,
    required int availableQuantity,
    File? imageFile,
  }) {
    return repository.updateMerchandise(
      id: id,
      name: name,
      requiredPoints: requiredPoints,
      availableQuantity: availableQuantity,
      imageFile: imageFile,
    );
  }

  Future<Either<Failure, String>> delete(int id) {
    return repository.deleteMerchandise(id);
  }

  Future<Either<Failure, PaginatedMerchandiseEntity>> getAll({
    int page = 0,
    int size = 10,
  }) {
    return repository.getAllMerchandise(page: page, size: size);
  }

  Future<Either<Failure, MerchandiseEntity>> restock({
    required int id,
    required int additionalQuantity,
  }) {
    return repository.restockMerchandise(
      id: id,
      additionalQuantity: additionalQuantity,
    );
  }
}
