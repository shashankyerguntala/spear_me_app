class OwnerProfileEntity {
  final String username;
  final String email;
  final int? phone;
  final String role;
  final String? imageUrl;

  const OwnerProfileEntity({
    required this.username,
    required this.email,
    required this.role,
    this.phone,
    this.imageUrl,
  });

  OwnerProfileEntity copyWith({
    String? username,
    String? email,
    int? phone,
    String? role,
    String? imageUrl,
  }) {
    return OwnerProfileEntity(
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
