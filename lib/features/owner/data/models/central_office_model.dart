import 'package:spear_me_app/features/owner/data/models/central_officer_model.dart';
import 'package:spear_me_app/features/owner/domain/entity/central_office_entity.dart';

class CentralOfficeModel extends CentralOfficeEntity {
  CentralOfficeModel({
    required super.id,
    required super.location,
    required super.officers,
  });

  factory CentralOfficeModel.fromJson(Map<String, dynamic> json) {
    return CentralOfficeModel(
      id: json['id'],
      location: json['location'],
      officers: (json['officers'] as List<dynamic>)
          .map((officerJson) => OfficerModel.fromJson(officerJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'location': location,
      'officers': officers.map((o) => (o as OfficerModel).toJson()).toList(),
    };
  }
}
