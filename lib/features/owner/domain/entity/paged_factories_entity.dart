import 'package:spear_me_app/features/owner/domain/entity/factory_entity.dart';

class PagedFactoriesEntity {
  final List<FactoryEntity> factories;
  final int page;
  final int totalPages;
  final bool isLast;

  PagedFactoriesEntity({
    required this.factories,
    required this.page,
    required this.totalPages,
    required this.isLast,
  });

  PagedFactoriesEntity copyWith({
    List<FactoryEntity>? factories,
    int? page,
    int? totalPages,
    bool? isLast,
  }) {
    return PagedFactoriesEntity(
      factories: factories ?? this.factories,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      isLast: isLast ?? this.isLast,
    );
  }
}
