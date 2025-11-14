class ToolDetailEntity {
  final String? toolName;
  final int? totalQuantity;
  final int? availableQuantity;
  final int? issuedQuantity;

  const ToolDetailEntity({
    this.toolName,
    this.totalQuantity,
    this.availableQuantity,
    this.issuedQuantity,
  });

  ToolDetailEntity copyWith({
    String? toolName,
    int? totalQuantity,
    int? availableQuantity,
    int? issuedQuantity,
  }) {
    return ToolDetailEntity(
      toolName: toolName ?? this.toolName,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      issuedQuantity: issuedQuantity ?? this.issuedQuantity,
    );
  }

  @override
  String toString() {
    return 'ToolDetailEntity(toolName: $toolName, totalQuantity: $totalQuantity, availableQuantity: $availableQuantity, issuedQuantity: $issuedQuantity)';
  }
}
