import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/plant_head/data/data_source/tool_request_data_source.dart';
import 'package:spear_me_app/features/plant_head/domain/entity/tool_request_entity.dart';
import 'package:spear_me_app/features/plant_head/domain/repository/tool_request_repository.dart';

class RequestRepositoryImpl implements RequestRepository {
  final RequestRemoteDataSource remoteDataSource;

  RequestRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<ToolRequestEntity>>> getToolRequests({
    String? searchWorker,
    String? status,
    int page = 0,
    int size = 10,
    String sortBy = 'createdAt',
    String sortDir = 'desc',
  }) async {
    return await remoteDataSource.getToolRequests(
      searchWorker: searchWorker,
      status: status,
      page: page,
      size: size,
      sortBy: sortBy,
      sortDir: sortDir,
    );
  }

  @override
  Future<Either<Failure, List<RestockRequestEntity>>> getRestockRequests({
    String? searchProduct,
    String? status,
    int page = 0,
    int size = 10,
    String sortBy = 'requestedAt',
    String sortDir = 'desc',
  }) async {
    return await remoteDataSource.getRestockRequests(
      searchProduct: searchProduct,
      status: status,
      page: page,
      size: size,
      sortBy: sortBy,
      sortDir: sortDir,
    );
  }

  @override
  Future<Either<Failure, void>> handleToolRequest({
    required int requestId,
    required bool approve,
    String? reason,
  }) async {
    return await remoteDataSource.handleToolRequest(
      requestId: requestId,
      approve: approve,
      reason: reason,
    );
  }

  @override
  Future<Either<Failure, RestockRequestEntity>> completeRestockRequest({
    required int requestId,
  }) async {
    return await remoteDataSource.completeRestockRequest(requestId: requestId);
  }
}
