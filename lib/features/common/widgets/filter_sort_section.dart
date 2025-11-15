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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          _buildDropdownColumn(
            context,
            title: filterLabel,
            child: FilterDropdown(
              selectedValue: selectedFilterValue,
              options: filterOptions,
              onChanged: onFilterChanged,
            ),
          ),
          const SizedBox(width: 16),
          _buildDropdownColumn(
            context,
            title: sortLabel,
            child: FilterDropdown(
              selectedValue: selectedSortValue,
              options: sortOptions,
              onChanged: onSortChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownColumn(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}
