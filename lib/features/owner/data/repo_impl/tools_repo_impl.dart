import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/owner/data/data_sources/remote_data_source/tools_data_source.dart';
import 'package:spear_me_app/features/owner/domain/entity/tools_category_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/tools_entity.dart';
import 'package:spear_me_app/features/owner/domain/repository/tools_repository.dart';

class ToolRepositoryImpl implements ToolRepository {
  final ToolDataSource dataSource;

  ToolRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, String>> addToolCategory({
    required String name,
    required String description,
  }) {
    return dataSource.addToolCategory(name: name, description: description);
  }

  @override
  Future<Either<Failure, List<ToolCategoryEntity>>> getToolCategories() {
    return dataSource.getToolCategories();
  }

  @override
  Future<Either<Failure, String>> updateToolCategory({
    required int id,
    required String name,
    required String description,
  }) {
    return dataSource.updateToolCategory(
      id: id,
      name: name,
      description: description,
    );
  }

  @override
  Future<Either<Failure, String>> deleteToolCategory(int id) {
    return dataSource.deleteToolCategory(id);
  }

  @override
  Future<Either<Failure, String>> createTool({
    required String name,
    required int categoryId,
    required String type,
    required String isExpensive,
    required int threshold,
  }) {
    return dataSource.createTool(
      name: name,
      categoryId: categoryId,
      type: type,
      isExpensive: isExpensive,
      threshold: threshold,
    );
  }

  @override
  Future<Either<Failure, String>> updateToolImage({
    required int toolId,
    required String imagePath,
  }) {
    return dataSource.updateToolImage(toolId: toolId, imagePath: imagePath);
  }

  @override
  Future<Either<Failure, String>> updateTool({
    required int toolId,
    required String name,
    required int categoryId,
    required String toolType,
    required String isExpensive,
    required int threshold,
  }) {
    return dataSource.updateTool(
      toolId: toolId,
      name: name,
      categoryId: categoryId,
      toolType: toolType,
      isExpensive: isExpensive,
      threshold: threshold,
    );
  }

  @override
  Future<Either<Failure, String>> addToolToFactory({
    required int toolId,
    required int quantity,
  }) {
    return dataSource.addToolToFactory(toolId: toolId, quantity: quantity);
  }

  @override
  @override
  Future<Either<Failure, List<ToolEntity>>> getAllTools({
    String? searchName,
    String? categoryName,
    String? type,
    int page = 0,
    int size = 10,
    String sortBy = "createdAt",
    String sortDir = "desc",
  }) async {
    try {
      final response = await dataSource.getAllTools(
        searchName: searchName,
        categoryName: categoryName,
        type: type,
        page: page,
        size: size,
        sortBy: sortBy,
        sortDir: sortDir,
      );

      return response.fold(
        (failure) => Left(failure),
        (models) => Right(models.map((m) => m).toList()),
      );
    } catch (e) {
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }
}
