import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/owner/domain/entity/merchandise_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/paginated_merchandise_entity.dart';

abstract class MerchandiseRepository {
  Future<Either<Failure, String>> addMerchandise({
    required String name,
    required int requiredPoints,
    required int availableQuantity,
    File? imageFile,
  });

  Future<Either<Failure, String>> updateMerchandise({
    required int id,
    required String name,
    required int requiredPoints,
    required int availableQuantity,
    File? imageFile,
  });

  Future<Either<Failure, String>> deleteMerchandise(int id);

  Future<Either<Failure, PaginatedMerchandiseEntity>> getAllMerchandise({
    required int page,
    required int size,
    String? search,
    String? role,
    String? sort,
    bool? asc,
  });

  Future<Either<Failure, MerchandiseEntity>> restockMerchandise({
    required int id,
    required int additionalQuantity,
  });
}
