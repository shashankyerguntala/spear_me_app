import 'package:spear_me_app/features/owner/domain/entity/tool_detail_entity.dart';

class ToolDetailModel extends ToolDetailEntity {
  const ToolDetailModel({
    super.toolName,
    super.totalQuantity,
    super.availableQuantity,
    super.issuedQuantity,
  });

  factory ToolDetailModel.fromJson(Map<String, dynamic> json) {
    return ToolDetailModel(
      toolName: json['toolName'] as String?,
      totalQuantity: (json['totalQuantity'] as num?)?.toInt(),
      availableQuantity: (json['availableQuantity'] as num?)?.toInt(),
      issuedQuantity: (json['issuedQuantity'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toJson() => {
        'toolName': toolName,
        'totalQuantity': totalQuantity,
        'availableQuantity': availableQuantity,
        'issuedQuantity': issuedQuantity,
      };
}
