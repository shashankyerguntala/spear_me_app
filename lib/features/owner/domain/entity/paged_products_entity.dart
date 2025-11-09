import 'package:equatable/equatable.dart';
import 'package:spear_me_app/features/owner/domain/entity/product_entity.dart';

class PagedProductsEntity extends Equatable {
  final List<ProductEntity> products;
  final int totalPages;
  final int currentPage;
  final int totalItems;

  const PagedProductsEntity({
    required this.products,
    required this.totalPages,
    required this.currentPage,
    required this.totalItems,
  });

  @override
  List<Object?> get props => [products, totalPages, currentPage, totalItems];
}
