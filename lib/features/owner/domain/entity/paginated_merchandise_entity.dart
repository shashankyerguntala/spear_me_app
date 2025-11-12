import 'package:spear_me_app/features/owner/domain/entity/merchandise_entity.dart';

class PaginatedMerchandiseEntity {
  final List<MerchandiseEntity> content;
  final int pageNumber;
  final int pageSize;
  final int totalPages;
  final int totalElements;
  final bool last;

  const PaginatedMerchandiseEntity({
    required this.content,
    required this.pageNumber,
    required this.pageSize,
    required this.totalPages,
    required this.totalElements,
    required this.last,
  });

  PaginatedMerchandiseEntity copyWith({
    List<MerchandiseEntity>? content,
    int? pageNumber,
    int? pageSize,
    int? totalPages,
    int? totalElements,
    bool? last,
  }) {
    return PaginatedMerchandiseEntity(
      content: content ?? this.content,
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize ?? this.pageSize,
      totalPages: totalPages ?? this.totalPages,
      totalElements: totalElements ?? this.totalElements,
      last: last ?? this.last,
    );
  }
}
