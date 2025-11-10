import 'package:spear_me_app/features/owner/domain/entity/product_entity.dart';

class PagedProductsEntity {
  /// Match API naming to avoid confusion in UI:
  final List<ProductEntity> content;

  // Common Spring-page fields present in your API:
  final int totalElements;
  final int totalPages;
  final bool last;
  final int size;
  final int number; // current page index
  final int numberOfElements;
  final bool first;
  final bool empty;

  const PagedProductsEntity({
    required this.content,
    required this.totalElements,
    required this.totalPages,
    required this.last,
    required this.size,
    required this.number,
    required this.numberOfElements,
    required this.first,
    required this.empty,
  });

  PagedProductsEntity copyWith({
    List<ProductEntity>? content,
    int? totalElements,
    int? totalPages,
    bool? last,
    int? size,
    int? number,
    int? numberOfElements,
    bool? first,
    bool? empty,
  }) {
    return PagedProductsEntity(
      content: content ?? this.content,
      totalElements: totalElements ?? this.totalElements,
      totalPages: totalPages ?? this.totalPages,
      last: last ?? this.last,
      size: size ?? this.size,
      number: number ?? this.number,
      numberOfElements: numberOfElements ?? this.numberOfElements,
      first: first ?? this.first,
      empty: empty ?? this.empty,
    );
  }

  List<ProductEntity> get products => content;
}
