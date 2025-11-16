import 'package:flutter/material.dart';
import 'package:spear_me_app/features/common/widgets/filter_option.dart';

final sortOptionsFactory = const [
  FilterOption(value: 'asc', label: 'Asc (A → Z)', icon: Icons.arrow_upward),
  FilterOption(
    value: 'desc',
    label: 'Desc (Z → A)',
    icon: Icons.arrow_downward,
  ),
];
