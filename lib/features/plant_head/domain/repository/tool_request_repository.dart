// features/plant_head/domain/repository/request_repository.dart
import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/plant_head/domain/entity/tool_request_entity.dart';

abstract class RequestRepository {
  Future<Either<Failure, List<ToolRequestEntity>>> getToolRequests({
    String? searchWorker,
    String? status,
    int page = 0,
    int size = 10,
    String sortBy = 'createdAt',
    String sortDir = 'desc',
  });

  Future<Either<Failure, List<RestockRequestEntity>>> getRestockRequests({
    String? searchProduct,
    String? status,
    int page = 0,
    int size = 10,
    String sortBy = 'requestedAt',
    String sortDir = 'desc',
  });

  Future<Either<Failure, void>> handleToolRequest({
    required int requestId,
    required bool approve,
    String? reason,
  });

  Future<Either<Failure, RestockRequestEntity>> completeRestockRequest({
    required int requestId,
  });
}
