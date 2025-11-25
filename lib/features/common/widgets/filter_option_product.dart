import 'package:flutter/material.dart';
import 'package:spear_me_app/features/common/widgets/filter_option.dart';

final List<FilterOption> productsFilters = [
  const FilterOption(value: 'All', label: 'All Products', icon: Icons.apps),
];

final List<FilterOption> productsSort = [
  const FilterOption(
    value: 'createdAt',
    label: 'Latest',
    icon: Icons.new_releases,
  ),
  const FilterOption(
    value: 'name',
    label: 'Name (A-Z)',
    icon: Icons.sort_by_alpha,
  ),
  const FilterOption(
    value: 'price_low',
    label: 'Price: Low to High',
    icon: Icons.arrow_upward,
  ),
  const FilterOption(
    value: 'price_high',
    label: 'Price: High to Low',
    icon: Icons.arrow_downward,
  ),
  const FilterOption(
    value: 'points_low',
    label: 'Points: Low to High',
    icon: Icons.star_border,
  ),
  const FilterOption(
    value: 'points_high',
    label: 'Points: High to Low',
    icon: Icons.star,
  ),
];
