import 'package:equatable/equatable.dart';

class ToolRequestEntity extends Equatable {
  final int requestId;
  final List<String> toolNames;
  final String workerName;
  final List<int> quantities;
  final String status;
  final String? rejectionReason;
  final String createdAt;

  const ToolRequestEntity({
    required this.requestId,
    required this.toolNames,
    required this.workerName,
    required this.quantities,
    required this.status,
    required this.createdAt,
    this.rejectionReason,
  });

  @override
  List<Object?> get props => [
    requestId,
    toolNames,
    workerName,
    quantities,
    status,
    rejectionReason,
    createdAt,
  ];
}

class RestockRequestEntity extends Equatable {
  final int id;
  final int factoryId;
  final String factoryName;
  final int productId;
  final String productName;
  final int qtyRequested;
  final String status;
  final String requestedAt;
  final int requestedByUserId;
  final String requestedByUserName;
  final int managerUserId;
  final String managerUserName;
  final String? completedAt;

  const RestockRequestEntity({
    required this.id,
    required this.factoryId,
    required this.factoryName,
    required this.productId,
    required this.productName,
    required this.qtyRequested,
    required this.status,
    required this.requestedAt,
    required this.requestedByUserId,
    required this.requestedByUserName,
    required this.managerUserId,
    required this.managerUserName,
    this.completedAt,
  });

  @override
  List<Object?> get props => [
    id,
    factoryId,
    factoryName,
    productId,
    productName,
    qtyRequested,
    status,
    requestedAt,
    requestedByUserId,
    requestedByUserName,
    managerUserId,
    managerUserName,
    completedAt,
  ];
}
