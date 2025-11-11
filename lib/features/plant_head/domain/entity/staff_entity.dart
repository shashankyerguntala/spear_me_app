class StaffEntity {
  final int id;
  final String name;
  final String email;
  final String role;
  final String factoryName;
  final String? bayName;
  final String? img;

  const StaffEntity({
    required this.img,
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
    String? img,
  }) {
    return StaffEntity(
      img: img ?? this.img,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      factoryName: factoryName ?? this.factoryName,
      bayName: bayName ?? this.bayName,
    );
  }

  StaffEntity toEntity() {
    return StaffEntity(
      id: id,
      name: name,
      email: email,
      role: role,
      factoryName: factoryName,
      bayName: bayName,
      img: img,
    );
  }
}
