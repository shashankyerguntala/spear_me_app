import 'package:spear_me_app/features/owner/domain/entity/product_detail_entity.dart';

class ProductDetailModel extends ProductDetailEntity {
  const ProductDetailModel({super.productName, super.producedQuantity});

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      productName: json['productName'] as String?,
      producedQuantity: (json['producedQuantity'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toJson() => {
    'productName': productName,
    'producedQuantity': producedQuantity,
  };
}
