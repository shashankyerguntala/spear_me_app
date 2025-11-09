import 'package:spear_me_app/features/owner/domain/entity/central_officer_entity.dart';

class CentralOfficeEntity {
  final int id;
  final String location;
  final List<OfficerEntity> officers;

  CentralOfficeEntity({
    required this.id,
    required this.location,
    required this.officers,
  });
}
