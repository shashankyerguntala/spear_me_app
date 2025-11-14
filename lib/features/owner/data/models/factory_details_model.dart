import 'package:spear_me_app/features/owner/domain/entity/factory_details_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/tool_detail_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/product_detail_entity.dart';

class FactoryDetailsModel extends FactoryDetailsEntity {
  const FactoryDetailsModel({
    super.factoryId,
    super.factoryName,
    super.location,
    super.totalEmployees,
    super.tools,
    super.products,
  });

  factory FactoryDetailsModel.fromJson(Map<String, dynamic> json) {
    return FactoryDetailsModel(
      factoryId: (json['factoryId'] as num?)?.toInt(),
      factoryName: json['factoryName'] as String?,
      location: json['location'] as String?,
      totalEmployees: (json['totalEmployees'] as num?)?.toInt(),
      tools: (json['tools'] as List<dynamic>?)
              ?.map((e) => ToolDetailEntity(
                    toolName: e['toolName'] as String?,
                    totalQuantity: (e['totalQuantity'] as num?)?.toInt(),
                    availableQuantity: (e['availableQuantity'] as num?)?.toInt(),
                    issuedQuantity: (e['issuedQuantity'] as num?)?.toInt(),
                  ))
              .toList() ??
          [],
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => ProductDetailEntity(
                    productName: e['productName'] as String?,
                    producedQuantity: (e['producedQuantity'] as num?)?.toInt(),
                  ))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'factoryId': factoryId,
        'factoryName': factoryName,
        'location': location,
        'totalEmployees': totalEmployees,
        'tools': tools
                ?.map((tool) => {
                      'toolName': tool.toolName,
                      'totalQuantity': tool.totalQuantity,
                      'availableQuantity': tool.availableQuantity,
                      'issuedQuantity': tool.issuedQuantity,
                    })
                .toList() ??
            [],
        'products': products
                ?.map((product) => {
                      'productName': product.productName,
                      'producedQuantity': product.producedQuantity,
                    })
                .toList() ??
            [],
      };
}
