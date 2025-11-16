import 'package:flutter/material.dart';
import 'package:spear_me_app/features/common/widgets/filter_drop_down.dart';
import 'package:spear_me_app/features/common/widgets/filter_option.dart';

class FilterSortSection extends StatelessWidget {
  final String selectedFilterValue;
  final String selectedSortValue;
  final List<FilterOption> filterOptions;
  final List<FilterOption> sortOptions;
  final ValueChanged<String> onFilterChanged;
  final ValueChanged<String> onSortChanged;
  final String filterLabel;
  final String sortLabel;

  const FilterSortSection({
    required this.selectedFilterValue,
    required this.selectedSortValue,
    required this.filterOptions,
    required this.sortOptions,
    required this.onFilterChanged,
    required this.onSortChanged,
    super.key,
    this.filterLabel = 'Filter By',
    this.sortLabel = 'Sort By',
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 16,
        children: [
          FilterDropdown(
            selectedValue: selectedFilterValue,
            options: filterOptions,
            onChanged: onFilterChanged,
          ),

          FilterDropdown(
            selectedValue: selectedSortValue,
            options: sortOptions,
            onChanged: onSortChanged,
          ),
        ],
      ),
    );
  }
}
