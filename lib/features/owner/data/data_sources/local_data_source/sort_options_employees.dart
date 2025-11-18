import 'package:flutter/material.dart';
import 'package:spear_me_app/features/common/widgets/filter_option.dart';

// TODO(Shashank): use enums instead of strings for sort options
final sortOptions = const [
  FilterOption(value: 'name', label: 'Name', icon: Icons.sort_by_alpha),
  FilterOption(value: 'role', label: 'Role', icon: Icons.badge),
  FilterOption(value: 'id', label: 'ID', icon: Icons.numbers),
];
