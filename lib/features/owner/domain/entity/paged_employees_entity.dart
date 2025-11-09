import 'package:spear_me_app/features/owner/domain/entity/employee_entity.dart';

class PagedEmployeesEntity {
  final List<EmployeeEntity> employees;
  final int page;
  final int totalPages;
  final bool isLast;

  PagedEmployeesEntity({
    required this.employees,
    required this.page,
    required this.totalPages,
    required this.isLast,
  });

  PagedEmployeesEntity copyWith({
    List<EmployeeEntity>? employees,
    int? page,
    int? totalPages,
    bool? isLast,
  }) {
    return PagedEmployeesEntity(
      employees: employees ?? this.employees,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      isLast: isLast ?? this.isLast,
    );
  }
}
