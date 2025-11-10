class BayEntity {
  final int id;
  final String bayName;
  final int factoryId;

  const BayEntity({
    required this.id,
    required this.bayName,
    required this.factoryId,
  });

  BayEntity copyWith({int? id, String? bayName, int? factoryId}) {
    return BayEntity(
      id: id ?? this.id,
      bayName: bayName ?? this.bayName,
      factoryId: factoryId ?? this.factoryId,
    );
  }
}
