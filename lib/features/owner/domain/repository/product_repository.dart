import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/owner/domain/entity/product_category_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/paged_products_entity.dart';

abstract class ProductsRepository {
  Future<Either<Failure, String>> createCategory(
    String categoryName,
    String description,
  );

  Future<Either<Failure, String>> updateCategory(
    int categoryId,
    String categoryName,
    String description,
  );

  Future<Either<Failure, List<ProductCategoryEntity>>> getCategories({
    String sortBy,
    String sortDir,
  });

  Future<Either<Failure, String>> deleteCategory(int categoryId);

  Future<Either<Failure, String>> addProduct({
    required String name,
    required String description,
    required double price,
    required int rewardPts,
    required int categoryId,
    required String imagePath, int? threshold,
  });

  Future<Either<Failure, PagedProductsEntity>> getProducts({
    String? search,
    String? categoryName,
    int page,
    int size,
  });

  Future<Either<Failure, String>> deleteProduct(int productId);
}
