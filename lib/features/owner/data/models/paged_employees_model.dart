import 'package:spear_me_app/features/owner/data/models/employee_model.dart';
import 'package:spear_me_app/features/owner/domain/entity/paged_employees_entity.dart';

class PagedEmployeesModel extends PagedEmployeesEntity {
  PagedEmployeesModel({
    required super.employees,
    required super.page,
    required super.totalPages,
    required super.isLast,
  });

  factory PagedEmployeesModel.fromJson(Map<String, dynamic> json) {
    return PagedEmployeesModel(
      employees: (json['content'] as List)
          .map((e) => EmployeeModel.fromJson(e))
          .toList(),
      page: json['number'],
      totalPages: json['totalPages'],
      isLast: json['last'],
    );
  }
}
