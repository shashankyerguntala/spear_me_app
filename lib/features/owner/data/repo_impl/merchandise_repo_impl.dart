import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/owner/data/data_sources/remote_data_source/merchandise_data_source.dart';
import 'package:spear_me_app/features/owner/domain/entity/merchandise_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/paginated_merchandise_entity.dart';
import 'package:spear_me_app/features/owner/domain/repository/merchandise_repository.dart';

class MerchandiseRepositoryImpl implements MerchandiseRepository {
  final MerchandiseDataSource dataSource;

  MerchandiseRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, String>> addMerchandise({
    required String name,
    required int requiredPoints,
    required int availableQuantity,
    File? imageFile,
  }) {
    return dataSource.addMerchandise(
      name: name,
      requiredPoints: requiredPoints,
      availableQuantity: availableQuantity,
      imageFile: imageFile,
    );
  }

  @override
  Future<Either<Failure, String>> updateMerchandise({
    required int id,
    required String name,
    required int requiredPoints,
    required int availableQuantity,
    File? imageFile,
  }) {
    return dataSource.updateMerchandise(
      id: id,
      name: name,
      requiredPoints: requiredPoints,
      availableQuantity: availableQuantity,
      imageFile: imageFile,
    );
  }

  @override
  Future<Either<Failure, String>> deleteMerchandise(int id) {
    return dataSource.deleteMerchandise(id);
  }

  @override
  Future<Either<Failure, PaginatedMerchandiseEntity>> getAllMerchandise({
    required int page,
    required int size,
    String? search,
    String? role,
    String? sort,
    bool? asc,
  }) {
    return dataSource.getAllMerchandise(
      page: page,
      size: size,
      search: search,
      role: role,
      sort: sort,
      ascending: asc,
    );
  }

  @override
  Future<Either<Failure, MerchandiseEntity>> restockMerchandise({
    required int id,
    required int additionalQuantity,
  }) {
    return dataSource.restockMerchandise(
      id: id,
      additionalQuantity: additionalQuantity,
    );
  }
}
