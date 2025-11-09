import 'package:spear_me_app/features/owner/data/models/product_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/paged_products_entity.dart';

class PagedProductsModel extends PagedProductsEntity {
  const PagedProductsModel({
    required super.products,
    required super.totalPages,
    required super.currentPage,
    required super.totalItems,
  });

  factory PagedProductsModel.fromJson(Map<String, dynamic> json) {
    final content = (json['content'] as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();

    return PagedProductsModel(
      products: content,
      totalPages: json['totalPages'],
      currentPage: json['number'],
      totalItems: json['totalElements'],
    );
  }
}
