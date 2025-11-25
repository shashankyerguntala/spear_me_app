import 'package:spear_me_app/features/plant_head/domain/entity/tool_request_entity.dart';

class ToolRequestModel extends ToolRequestEntity {
  const ToolRequestModel({
    required super.requestId,
    required super.toolNames,
    required super.workerName,
    required super.quantities,
    required super.status,
    required super.createdAt, super.rejectionReason,
  });

  factory ToolRequestModel.fromJson(Map<String, dynamic> json) {
    return ToolRequestModel(
      requestId: json['requestId'] as int,
      toolNames: List<String>.from(json['toolNames'] as List),
      workerName: json['workerName'] as String,
      quantities: List<int>.from(json['quantities'] as List),
      status: json['status'] as String,
      rejectionReason: json['rejectionReason'] as String?,
      createdAt: json['createdAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requestId': requestId,
      'toolNames': toolNames,
      'workerName': workerName,
      'quantities': quantities,
      'status': status,
      'rejectionReason': rejectionReason,
      'createdAt': createdAt,
    };
  }
}

class RestockRequestModel extends RestockRequestEntity {
  const RestockRequestModel({
    required super.id,
    required super.factoryId,
    required super.factoryName,
    required super.productId,
    required super.productName,
    required super.qtyRequested,
    required super.status,
    required super.requestedAt,
    required super.requestedByUserId,
    required super.requestedByUserName,
    required super.managerUserId,
    required super.managerUserName,
    super.completedAt,
  });

  factory RestockRequestModel.fromJson(Map<String, dynamic> json) {
    return RestockRequestModel(
      id: json['id'] as int,
      factoryId: json['factoryId'] as int,
      factoryName: json['factoryName'] as String,
      productId: json['productId'] as int,
      productName: json['productName'] as String,
      qtyRequested: json['qtyRequested'] as int,
      status: json['status'] as String,
      requestedAt: json['requestedAt'] as String,
      requestedByUserId: json['requestedByUserId'] as int,
      requestedByUserName: json['requestedByUserName'] as String,
      managerUserId: json['managerUserId'] as int,
      managerUserName: json['managerUserName'] as String,
      completedAt: json['completedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'factoryId': factoryId,
      'factoryName': factoryName,
      'productId': productId,
      'productName': productName,
      'qtyRequested': qtyRequested,
      'status': status,
      'requestedAt': requestedAt,
      'requestedByUserId': requestedByUserId,
      'requestedByUserName': requestedByUserName,
      'managerUserId': managerUserId,
      'managerUserName': managerUserName,
      'completedAt': completedAt,
    };
  }
}
