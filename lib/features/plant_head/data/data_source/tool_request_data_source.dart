// features/plant_head/data/datasource/request_remote_datasource.dart
import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/dio_client.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/plant_head/data/model/tool_request_model.dart';


abstract class RequestRemoteDataSource {
  Future<Either<Failure, List<ToolRequestModel>>> getToolRequests({
    String? searchWorker,
    String? status,
    int page = 0,
    int size = 10,
    String sortBy = 'createdAt',
    String sortDir = 'desc',
  });

  Future<Either<Failure, List<RestockRequestModel>>> getRestockRequests({
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

  Future<Either<Failure, RestockRequestModel>> completeRestockRequest({
    required int requestId,
  });
}

class RequestRemoteDataSourceImpl implements RequestRemoteDataSource {
  final DioClient dioClient;

  RequestRemoteDataSourceImpl(this.dioClient);

  @override
  Future<Either<Failure, List<ToolRequestModel>>> getToolRequests({
    String? searchWorker,
    String? status,
    int page = 0,
    int size = 10,
    String sortBy = 'createdAt',
    String sortDir = 'desc',
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'size': size,
      'sortBy': sortBy,
      'sortDir': sortDir,
    };

    if (searchWorker != null && searchWorker.isNotEmpty) {
      queryParams['searchWorker'] = searchWorker;
    }

    if (status != null && status.isNotEmpty) {
      queryParams['status'] = status;
    }

    final result = await dioClient.getRequest(
      '/api/tool/pending',
      queryParameters: queryParams,
    );

    return result.fold(
      (failure) => Left(failure),
      (response) {
        try {
          final data = response['data'] as List;
          final requests = data
              .map((json) => ToolRequestModel.fromJson(json as Map<String, dynamic>))
              .toList();
          return Right(requests);

        } catch (e) {
          return Left(Failure('Failed to parse tool requests: $e'));
        }
      },
    );
  }

  @override
  Future<Either<Failure, List<RestockRequestModel>>> getRestockRequests({
    String? searchProduct,
    String? status,
    int page = 0,
    int size = 10,
    String sortBy = 'requestedAt',
    String sortDir = 'desc',
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'size': size,
      'sortBy': sortBy,
      'sortDir': sortDir,
    };

    if (searchProduct != null && searchProduct.isNotEmpty) {
      queryParams['searchProduct'] = searchProduct;
    }

    if (status != null && status.isNotEmpty) {
      queryParams['status'] = status;
    }

    final result = await dioClient.getRequest(
      '/api/products/restock-requests',
      queryParameters: queryParams,
    );

    return result.fold(
      (failure) => Left(failure),
      (response) {
        try {
          final data = response['data'] as List;
          final requests = data
              .map((json) => RestockRequestModel.fromJson(json as Map<String, dynamic>))
              .toList();
          return Right(requests);
        } catch (e) {
          return Left(Failure('Failed to parse restock requests: $e'));
        }
      },
    );
  }

  @override
  Future<Either<Failure, void>> handleToolRequest({
    required int requestId,
    required bool approve,
    String? reason,
  }) async {
    final queryParams = <String, dynamic>{
      'approve': approve,
    };

    if (!approve && reason != null && reason.isNotEmpty) {
      queryParams['reason'] = reason;
    }

    final result = await dioClient.postRequest(
      '/api/tool/handle/$requestId',
      queryParameters: queryParams,
    );

    return result.fold(
      (failure) => Left(failure),
      (response) => const Right(null),
    );
  }

  @override
  Future<Either<Failure, RestockRequestModel>> completeRestockRequest({
    required int requestId,
  }) async {
    final result = await dioClient.putRequest(
      '/api/products/restock-request/$requestId/complete',
    );

    return result.fold(
      (failure) => Left(failure),
      (response) {
        try {
          final data = response['data'] as Map<String, dynamic>;
          return Right(RestockRequestModel.fromJson(data));
        } catch (e) {
          return Left(Failure('Failed to parse restock request: $e'));
        }
      },
    );
  }
}