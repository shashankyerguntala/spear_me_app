import 'package:equatable/equatable.dart';

class EmployeeEntity extends Equatable {
  final int id;
  final String username;
  final String email;
  final String role;
  final String isActive;
  final String? img;
  final int? phone;

  const EmployeeEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    required this.isActive,
    this.img,
    this.phone,
  });

  EmployeeEntity copyWith({
    int? id,
    String? username,
    String? email,
    String? role,
    String? isActive,
    String? img,
    int? phone,
  }) {
    return EmployeeEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      img: img ?? this.img,
      phone: phone ?? this.phone,
    );
  }

  @override
  List<Object?> get props => [id, username, email, role, isActive, img, phone];
}

class PagedEmployeesEntity extends Equatable {
  final List<EmployeeEntity> employees;
  final int page;
  final int totalPages;
  final int totalElements;
  final bool isLast;
  final bool isFirst;

  const PagedEmployeesEntity({
    required this.employees,
    required this.page,
    required this.totalPages,
    required this.totalElements,
    required this.isLast,
    required this.isFirst,
  });

  @override
  List<Object?> get props =>
      [employees, page, totalPages, totalElements, isLast, isFirst];
}