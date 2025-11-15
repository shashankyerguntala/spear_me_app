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
    final contentList =
        (json['content'] as List<dynamic>?)
            ?.map((e) => MerchandiseModel.fromJson(e))
            .toList() ??
        [];

    return PaginatedMerchandiseModel(
      content: contentList,
      pageNumber: json['number'] ?? 0,
      pageSize: json['size'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      totalElements: json['totalElements'] ?? 0,
      last: json['last'] ?? true,
    );
  }
}
