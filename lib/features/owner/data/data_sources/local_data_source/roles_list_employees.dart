import 'package:flutter/material.dart';
import 'package:spear_me_app/features/common/widgets/filter_option.dart';

// TODO(Shashank): use enums instead of strings for roles/filters
final roleOptions = const [
  FilterOption(value: '', label: 'All Roles', icon: Icons.groups),
  FilterOption(value: 'PLANT_HEAD', label: 'Plant Head', icon: Icons.factory),
  FilterOption(
    value: 'DISTRIBUTOR',
    label: 'Distributor',
    icon: Icons.local_shipping,
  ),
  FilterOption(
    value: 'CENTRAL_OFFICE',
    label: 'Central Office',
    icon: Icons.business,
  ),
  FilterOption(
    value: 'OWNER',
    label: 'Owner',
    icon: Icons.admin_panel_settings,
  ),
];
