import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/owner/domain/entity/tools_category_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/tools_entity.dart';
import 'package:spear_me_app/features/owner/domain/repository/tools_repository.dart';

class ToolUsecase {
  final ToolRepository repo;

  ToolUsecase(this.repo);

  //! add category
  Future<Either<Failure, String>> addCategory({
    required String name,
    required String description,
  }) => repo.addToolCategory(name: name, description: description);

  //! get categories
  Future<Either<Failure, List<ToolCategoryEntity>>> getCategories() =>
      repo.getToolCategories();

  Future<Either<Failure, String>> updateCategory({
    required int id,
    required String name,
    required String description,
  }) => repo.updateToolCategory(id: id, name: name, description: description);

  Future<Either<Failure, String>> deleteCategory(int id) =>
      repo.deleteToolCategory(id);

  Future<Either<Failure, String>> createTool({
    required String name,
    required int categoryId,
    required String type,
    required String isExpensive,
    required int threshold,
  }) => repo.createTool(
    name: name,
    categoryId: categoryId,
    type: type,
    isExpensive: isExpensive,
    threshold: threshold,
  );

  Future<Either<Failure, String>> updateToolImage({
    required int toolId,
    required String imagePath,
  }) => repo.updateToolImage(toolId: toolId, imagePath: imagePath);

  Future<Either<Failure, String>> updateTool({
    required int toolId,
    required String name,
    required int categoryId,
    required String toolType,
    required String isExpensive,
    required int threshold,
  }) => repo.updateTool(
    toolId: toolId,
    name: name,
    categoryId: categoryId,
    toolType: toolType,
    isExpensive: isExpensive,
    threshold: threshold,
  );

  Future<Either<Failure, String>> addToolToFactory({
    required int toolId,
    required int quantity,
  }) => repo.addToolToFactory(toolId: toolId, quantity: quantity);

  //! get all tools
  Future<Either<Failure, List<ToolEntity>>> getAllTools({
    String? searchName,
    String? categoryName,
    String? type,
    int page = 0,
    int size = 20,
    String sortBy = "createdAt",
    String sortDir = "desc",
  }) {
    return repo.getAllTools(
      searchName: searchName,
      categoryName: categoryName,
      type: type,
      page: page,
      size: size,
      sortBy: sortBy,
      sortDir: sortDir,
    );
  }
}
