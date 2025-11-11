import 'package:spear_me_app/features/plant_head/data/model/staff_model.dart';
import 'package:spear_me_app/features/plant_head/domain/entity/paginated_staff_entity.dart';

class PaginatedStaffModel extends PaginatedStaffEntity {
  PaginatedStaffModel({
    required super.content,
    required super.pageNumber,
    required super.pageSize,
    required super.totalPages,
    required super.totalElements,
    required super.last,
  });
  factory PaginatedStaffModel.fromJson(Map<String, dynamic> json) {
    return PaginatedStaffModel(
      content: (json['content'] as List? ?? [])
          .map((e) => StaffModel.fromJson(e))
          .toList(),
      pageNumber: json['number'] ?? 0,
      pageSize: json['size'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      totalElements: json['totalElements'] ?? 0,
      last: json['last'] ?? true,
    );
  }
}
