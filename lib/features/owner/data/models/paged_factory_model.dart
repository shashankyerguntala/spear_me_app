import 'package:spear_me_app/features/owner/data/models/factory_model.dart';
import 'package:spear_me_app/features/owner/domain/entity/paged_factories_entity.dart';

class PagedFactoriesModel extends PagedFactoriesEntity {
  PagedFactoriesModel({
    required super.factories,
    required super.page,
    required super.totalPages,
    required super.isLast,
  });

  factory PagedFactoriesModel.fromJson(Map<String, dynamic> json) {
    return PagedFactoriesModel(
      factories: (json['content'] as List)
          .map((e) => FactoryModel.fromJson(e))
          .toList(),
      page: json['number'],
      totalPages: json['totalPages'],
      isLast: json['last'],
    );
  }
}
