class StaffEntity {
  final int id;
  final String name;
  final String email;
  final String role;
  final String factoryName;
  final String? bayName;

  const StaffEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.factoryName,
    this.bayName,
  });

  StaffEntity copyWith({
    int? id,
    String? name,
    String? email,
    String? role,
    String? factoryName,
    String? bayName,
  }) {
    return StaffEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      factoryName: factoryName ?? this.factoryName,
      bayName: bayName ?? this.bayName,
    );
  }
}
