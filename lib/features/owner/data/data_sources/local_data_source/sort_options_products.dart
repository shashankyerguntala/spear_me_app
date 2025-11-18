import 'package:flutter/material.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/features/common/widgets/filter_option.dart';

final toolsSort = const [
  FilterOption(
    value: "createdAt",
    label: StringConstants.dateAdded,
    icon: Icons.calendar_month,
  ),
  FilterOption(
    value: "name",
    label: StringConstants.sortName,
    icon: Icons.sort_by_alpha,
  ),
  FilterOption(
    value: "threshold",
    label: StringConstants.sortThreshold,
    icon: Icons.speed,
  ),
];
