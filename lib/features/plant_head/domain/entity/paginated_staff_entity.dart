import 'package:spear_me_app/features/plant_head/domain/entity/staff_entity.dart';

class PaginatedStaffEntity {
  final List<StaffEntity> content;
  final int pageNumber;
  final int pageSize;
  final int totalPages;
  final int totalElements;
  final bool last;

  const PaginatedStaffEntity({
    required this.content,
    required this.pageNumber,
    required this.pageSize,
    required this.totalPages,
    required this.totalElements,
    required this.last,
  });
}
