import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/features/common/widgets/filter_sort_section.dart';
import 'package:spear_me_app/features/common/widgets/search_field_widget.dart';
import 'package:spear_me_app/features/owner/data/data_sources/local_data_source/city_list_factory.dart';
import 'package:spear_me_app/features/owner/data/data_sources/local_data_source/sort_options_factory.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/factory_home/bloc/owner_factories_bloc.dart';

class FiltersSection extends StatelessWidget {
  final TextEditingController searchController;

  const FiltersSection({required this.searchController, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchField(
          controller: searchController,
          onChanged: (v) =>
              context.read<OwnerFactoriesBloc>().add(UpdateFactorySearch(v)),
          onClear: () {
            searchController.clear();
            context.read<OwnerFactoriesBloc>().add(
              const UpdateFactorySearch(""),
            );
          },
        ),
        const SizedBox(height: 12),
        BlocSelector<OwnerFactoriesBloc, OwnerFactoriesState, dynamic>(
          selector: (s) => (s.selectedFilter, s.sortBy),
          builder: (context, _) {
            return FilterSortSection(
              selectedFilterValue: context.select(
                (OwnerFactoriesBloc b) => b.state.selectedFilter,
              ),
              selectedSortValue: context.select(
                (OwnerFactoriesBloc b) => b.state.sortBy,
              ),
              filterOptions: cityOptions,
              sortOptions: sortOptionsFactory,
              filterLabel: StringConstants.filterByCity,
              onFilterChanged: (v) => context.read<OwnerFactoriesBloc>().add(
                UpdateFactoryFilter(v),
              ),
              onSortChanged: (v) => context.read<OwnerFactoriesBloc>().add(
                UpdateFactorySort(sortBy: v, ascending: true),
              ),
            );
          },
        ),
      ],
    );
  }
}
