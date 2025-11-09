import 'package:spear_me_app/features/owner/domain/entity/employee_entity.dart';

class EmployeeModel extends EmployeeEntity {
  const EmployeeModel({
    required super.id,
    required super.username,
    required super.email,
    required super.role,
    required super.isActive,
    super.img,
    super.phone,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      isActive: json['isActive'] as String,
      img: json['img'] as String?,
      phone: json['phone'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'role': role,
      'isActive': isActive,
      'img': img,
      'phone': phone,
    };
  }

  @override
  EmployeeModel copyWith({
    int? id,
    String? username,
    String? email,
    String? role,
    String? isActive,
    String? img,
    int? phone,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      img: img ?? this.img,
      phone: phone ?? this.phone,
    );
  }
}

class PagedEmployeesModel extends PagedEmployeesEntity {
  const PagedEmployeesModel({
    required super.employees,
    required super.page,
    required super.totalPages,
    required super.totalElements,
    required super.isLast,
    required super.isFirst,
  });

  factory PagedEmployeesModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    final content = data['content'] as List<dynamic>;
    final pageable = data['pageable'] as Map<String, dynamic>;

    return PagedEmployeesModel(
      employees: content
          .map((e) => EmployeeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: pageable['pageNumber'] as int,
      totalPages: data['totalPages'] as int,
      totalElements: data['totalElements'] as int,
      isLast: data['last'] as bool,
      isFirst: data['first'] as bool,
    );
  }
}