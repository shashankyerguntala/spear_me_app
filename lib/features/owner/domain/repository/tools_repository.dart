import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/owner/domain/entity/tools_category_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/tools_entity.dart';

abstract class ToolRepository {
  // 🔹 Category
  Future<Either<Failure, String>> addToolCategory({
    required String name,
    required String description,
  });

  Future<Either<Failure, List<ToolCategoryEntity>>> getToolCategories();

  Future<Either<Failure, String>> updateToolCategory({
    required int id,
    required String name,
    required String description,
  });

  Future<Either<Failure, String>> deleteToolCategory(int id);

  // 🔹 Tool
  Future<Either<Failure, String>> createTool({
    required String name,
    required int categoryId,
    required String type,
    required String isExpensive,
    required int threshold,
  });

  Future<Either<Failure, String>> updateToolImage({
    required int toolId,
    required String imagePath,
  });

  Future<Either<Failure, String>> updateTool({
    required int toolId,
    required String name,
    required int categoryId,
    required String toolType,
    required String isExpensive,
    required int threshold,
  });

  Future<Either<Failure, String>> addToolToFactory({
    required int toolId,
    required int quantity,
  });
  Future<Either<Failure, List<ToolEntity>>> getAllTools({
    String? searchName,
    String? categoryName,
    String? type,
    int page,
    int size,
    String sortBy,
    String sortDir,
  });
}
