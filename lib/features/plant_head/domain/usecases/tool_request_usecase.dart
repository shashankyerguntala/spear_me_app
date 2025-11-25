import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/plant_head/domain/entity/tool_request_entity.dart';
import 'package:spear_me_app/features/plant_head/domain/repository/tool_request_repository.dart';

class RequestUseCase {
  final RequestRepository repository;

  RequestUseCase(this.repository);

  Future<Either<Failure, List<ToolRequestEntity>>> getToolRequests({
    String? searchWorker,
    String? status,
    int page = 0,
    int size = 10,
    String sortBy = 'createdAt',
    String sortDir = 'desc',
  }) async {
    return await repository.getToolRequests(
      searchWorker: searchWorker,
      status: status,
      page: page,
      size: size,
      sortBy: sortBy,
      sortDir: sortDir,
    );
  }

  Future<Either<Failure, List<RestockRequestEntity>>> getRestockRequests({
    String? searchProduct,
    String? status,
    int page = 0,
    int size = 10,
    String sortBy = 'requestedAt',
    String sortDir = 'desc',
  }) async {
    return await repository.getRestockRequests(
      searchProduct: searchProduct,
      status: status,
      page: page,
      size: size,
      sortBy: sortBy,
      sortDir: sortDir,
    );
  }

  Future<Either<Failure, void>> approveToolRequest({
    required int requestId,
  }) async {
    return await repository.handleToolRequest(
      requestId: requestId,
      approve: true,
    );
  }

  Future<Either<Failure, void>> rejectToolRequest({
    required int requestId,
    required String reason,
  }) async {
    return await repository.handleToolRequest(
      requestId: requestId,
      approve: false,
      reason: reason,
    );
  }

  Future<Either<Failure, RestockRequestEntity>> completeRestockRequest({
    required int requestId,
  }) async {
    return await repository.completeRestockRequest(requestId: requestId);
  }
}
