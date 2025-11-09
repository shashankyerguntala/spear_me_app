import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/owner/domain/entity/product_category_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/paged_products_entity.dart';
import 'package:spear_me_app/features/owner/domain/repository/product_repository.dart';

class ProductsUsecase {
  final ProductsRepository repo;

  ProductsUsecase(this.repo);

  Future<Either<Failure, String>> createCategory(
    String categoryName,
    String description,
  ) {
    return repo.createCategory(categoryName, description);
  }

  Future<Either<Failure, String>> updateCategory(
    int id,
    String categoryName,
    String description,
  ) {
    return repo.updateCategory(id, categoryName, description);
  }

  Future<Either<Failure, List<ProductCategoryEntity>>> getCategories() {
    return repo.getCategories();
  }

  Future<Either<Failure, String>> deleteCategory(int id) {
    return repo.deleteCategory(id);
  }

  Future<Either<Failure, String>> addProduct({
    required String name,
    required String description,
    required double price,
    required int rewardPts,
    required int categoryId,
    required String imagePath,
    int? threshold,
  }) {
    return repo.addProduct(
      name: name,
      description: description,
      price: price,
      rewardPts: rewardPts,
      categoryId: categoryId,
      threshold: threshold,
      imagePath: imagePath,
    );
  }

  Future<Either<Failure, PagedProductsEntity>> getProducts({
    String? search,
    String? categoryName,
    int page = 0,
    int size = 20,
  }) {
    return repo.getProducts(
      search: search,
      categoryName: categoryName,
      page: page,
      size: size,
    );
  }

  Future<Either<Failure, String>> deleteProduct(int productId) {
    return repo.deleteProduct(productId);
  }
}
