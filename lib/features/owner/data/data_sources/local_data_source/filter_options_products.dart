import 'package:flutter/material.dart';
import 'package:spear_me_app/features/common/widgets/filter_option.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';

final toolsFilters = const [
  FilterOption(
    value: StringConstants.all,
    label: StringConstants.all,
    icon: Icons.filter_list,
  ),
  FilterOption(
    value: StringConstants.perishable,
    label: StringConstants.perishable,
    icon: Icons.local_florist,
  ),
  FilterOption(
    value: StringConstants.nonPerishable,
    label: StringConstants.nonPerishable,
    icon: Icons.inventory_2_outlined,
  ),
  FilterOption(
    value: StringConstants.expensive,
    label: StringConstants.expensive,
    icon: Icons.currency_rupee,
  ),
];
