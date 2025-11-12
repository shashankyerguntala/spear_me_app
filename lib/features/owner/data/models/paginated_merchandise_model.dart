import 'package:spear_me_app/features/owner/data/models/merchandise_model.dart';
import 'package:spear_me_app/features/owner/domain/entity/paginated_merchandise_entity.dart';

class PaginatedMerchandiseModel extends PaginatedMerchandiseEntity {
  PaginatedMerchandiseModel({
    required super.content,
    required super.pageNumber,
    required super.pageSize,
    required super.totalPages,
    required super.totalElements,
    required super.last,
  });

  factory PaginatedMerchandiseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final contentList = (data['content'] as List<dynamic>)
        .map((e) => MerchandiseModel.fromJson(e))
        .toList();

    return PaginatedMerchandiseModel(
      content: contentList,
      pageNumber: data['number'] ?? 0,
      pageSize: data['size'] ?? 0,
      totalPages: data['totalPages'] ?? 0,
      totalElements: data['totalElements'] ?? 0,
      last: data['last'] ?? true,
    );
  }
}
