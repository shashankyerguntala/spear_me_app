import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/owner/data/data_sources/remote_data_source/products_data_source.dart';

import 'package:spear_me_app/features/owner/domain/entity/product_category_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/paged_products_entity.dart';
import 'package:spear_me_app/features/owner/domain/repository/product_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsDataSource dataSource;

  ProductsRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, String>> createCategory(
    String categoryName,
    String description,
  ) {
    return dataSource.createCategory(
      name: categoryName,
      description: description,
    );
  }

  @override
  Future<Either<Failure, String>> updateCategory(
    int categoryId,
    String categoryName,
    String description,
  ) {
    return dataSource.updateCategory(
      id: categoryId,
      name: categoryName,
      description: description,
    );
  }

  @override
  Future<Either<Failure, List<ProductCategoryEntity>>> getCategories({
    String sortBy = "categoryName",
    String sortDir = "asc",
  }) {
    return dataSource.getCategories(sortBy: sortBy, sortDir: sortDir);
  }

  @override
  Future<Either<Failure, String>> deleteCategory(int categoryId) {
    return dataSource.deleteCategory(categoryId);
  }

  @override
  Future<Either<Failure, String>> addProduct({
    required String name,
    required String description,
    required double price,
    required int rewardPts,
    required int categoryId,
    required String imagePath,
    int? threshold,
  }) {
    return dataSource.addProduct(
      name: name,
      description: description,
      price: price,
      rewardPts: rewardPts,
      categoryId: categoryId,
      threshold: threshold,
      imagePath: imagePath,
    );
  }

  @override
  Future<Either<Failure, PagedProductsEntity>> getProducts({
    String? search,
    String? categoryName,
    int page = 0,
    int size = 20,
  }) {
    return dataSource.getProducts(
      search: search,
      categoryName: categoryName,
      page: page,
      size: size,
    );
  }

  @override
  Future<Either<Failure, String>> deleteProduct(int productId) {
    return dataSource.deleteProduct(productId);
  }
}
