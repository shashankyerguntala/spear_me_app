import 'package:spear_me_app/features/owner/data/models/product_model.dart';
import 'package:spear_me_app/features/owner/domain/entity/paged_products_entity.dart';

class PagedProductsModel extends PagedProductsEntity {
  const PagedProductsModel({
    required super.content,
    required super.totalElements,
    required super.totalPages,
    required super.last,
    required super.size,
    required super.number,
    required super.numberOfElements,
    required super.first,
    required super.empty,
  });

  factory PagedProductsModel.fromJson(Map<String, dynamic> json) {
    final List<ProductModel> items = (json['content'] as List<dynamic>? ?? [])
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return PagedProductsModel(
      content: items,
      totalElements: (json['totalElements'] as num?)?.toInt() ?? 0,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
      last: json['last'] as bool? ?? false,
      size: (json['size'] as num?)?.toInt() ?? items.length,
      number: (json['number'] as num?)?.toInt() ?? 0,
      numberOfElements:
          (json['numberOfElements'] as num?)?.toInt() ?? items.length,
      first: json['first'] as bool? ?? (json['number'] == 0),
      empty: json['empty'] as bool? ?? items.isEmpty,
    );
  }

  Map<String, dynamic> toJson() => {
    'content': content.map((e) => (e as ProductModel).toJson()).toList(),
    'totalElements': totalElements,
    'totalPages': totalPages,
    'last': last,
    'size': size,
    'number': number,
    'numberOfElements': numberOfElements,
    'first': first,
    'empty': empty,
  };
}
