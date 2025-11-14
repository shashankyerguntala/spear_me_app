import 'package:spear_me_app/features/owner/domain/entity/tool_detail_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/product_detail_entity.dart';

class FactoryDetailsEntity {
  final int? factoryId;
  final String? factoryName;
  final String? location;
  final int? totalEmployees;
  final List<ToolDetailEntity>? tools;
  final List<ProductDetailEntity>? products;

  const FactoryDetailsEntity({
    this.factoryId,
    this.factoryName,
    this.location,
    this.totalEmployees,
    this.tools,
    this.products,
  });

  FactoryDetailsEntity copyWith({
    int? factoryId,
    String? factoryName,
    String? location,
    int? totalEmployees,
    List<ToolDetailEntity>? tools,
    List<ProductDetailEntity>? products,
  }) {
    return FactoryDetailsEntity(
      factoryId: factoryId ?? this.factoryId,
      factoryName: factoryName ?? this.factoryName,
      location: location ?? this.location,
      totalEmployees: totalEmployees ?? this.totalEmployees,
      tools: tools ?? this.tools,
      products: products ?? this.products,
    );
  }

  @override
  String toString() {
    return 'FactoryDetailsEntity(factoryId: $factoryId, factoryName: $factoryName, location: $location, totalEmployees: $totalEmployees, tools: $tools, products: $products)';
  }
}
