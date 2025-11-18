import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/core/helper_functions.dart';
import 'package:spear_me_app/features/common/widgets/custom_floating_action_button.dart';
import 'package:spear_me_app/features/common/widgets/filter_sort_section.dart';
import 'package:spear_me_app/features/common/widgets/search_field_widget.dart';
import 'package:spear_me_app/features/common/widgets/tool_card.dart';
import 'package:spear_me_app/features/owner/data/data_sources/local_data_source/filter_options_products.dart';
import 'package:spear_me_app/features/owner/data/data_sources/local_data_source/sort_options_products.dart';
import 'package:spear_me_app/features/owner/presentation/owner_products/owner_products_home/screens/products_grid_shimmer.dart';
import 'package:spear_me_app/features/owner/presentation/owner_tools/tools_home/bloc/tools_bloc.dart';

class ToolsHomeScreen extends StatelessWidget {
  const ToolsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<ToolsBloc>()
        ..add(FetchToolCategories())
        ..add(const FetchTools(categoryName: StringConstants.all)),
      child: const ToolsBodyScreen(),
    );
  }
}

class ToolsBodyScreen extends StatefulWidget {
  const ToolsBodyScreen({super.key});

  @override
  State<ToolsBodyScreen> createState() => _ToolsBodyScreenState();
}

class _ToolsBodyScreenState extends State<ToolsBodyScreen> {
  final TextEditingController searchCtrl = TextEditingController();
  late final ScrollController scrollCtrl;

  @override
  void initState() {
    super.initState();
    scrollCtrl = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollCtrl.dispose();
    searchCtrl.dispose();
    super.dispose();
  }

  void _onScroll() {
    final bloc = context.read<ToolsBloc>();
    if (!scrollCtrl.hasClients) {
      return;
    }

    final max = scrollCtrl.position.maxScrollExtent;
    final current = scrollCtrl.position.pixels;

    if (current >= max - 100) {
      bloc.add(LoadMoreTools());
    }
  }

  void _handleFilterChange(String val) {
    if (val == StringConstants.all) {
      context.read<ToolsBloc>().add(
        const FetchTools(categoryName: StringConstants.all),
      );
    } else {
      context.read<ToolsBloc>().add(FilterTools(val));
    }
  }

  void _handleSortChange(String val) {
    final state = context.read<ToolsBloc>().state;
    context.read<ToolsBloc>().add(
      SortTools(sortBy: val, sortDir: state.sortDir),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToolsBloc, ToolsState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          HelperFunctions.showSnackBar(
            context,
            message: state.errorMessage!,
            isError: true,
          );
        }
      },

      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorConstants.surface,

          appBar: AppBar(
            title: const Text(StringConstants.toolsTitle),
            centerTitle: true,
            elevation: 0,
            backgroundColor: ColorConstants.surface,
          ),

          floatingActionButton: CustomFloatingActionButton(
            label: StringConstants.addTool,
            onPressed: () => context.push(
              '${RoutesConstants.ownerToolsRoutes}/${RoutesConstants.ownerAddTools}',
            ),
          ),

          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SearchField(
                  controller: searchCtrl,
                  hintText: StringConstants.searchToolsHint,
                  onChanged: (value) {
                    context.read<ToolsBloc>().add(SearchTools(value));
                  },
                  onClear: () {
                    context.read<ToolsBloc>().add(
                      const FetchTools(categoryName: StringConstants.all),
                    );
                  },
                ),

                const SizedBox(height: 12),

                FilterSortSection(
                  selectedFilterValue: state.filter ?? StringConstants.all,
                  selectedSortValue: state.sortBy ?? "createdAt",
                  filterOptions: toolsFilters,
                  sortOptions: toolsSort,
                  onFilterChanged: _handleFilterChange,
                  onSortChanged: _handleSortChange,
                ),

                const SizedBox(height: 16),

                Expanded(child: _buildGrid(state)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: "Search tools by name...",
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onChanged: (val) => context.read<ToolsBloc>().add(SearchTools(val)),
    );
  }

  Widget _buildCategoryDropdown(ToolsState state) {
    return DropdownButtonFormField<String>(
      value: state.selectedCategoryName ?? "All",
      isExpanded: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        labelText: "Category",
      ),
      items: state.categories
          .map((e) => DropdownMenuItem(value: e.name, child: Text(e.name)))
          .toList(),
      onChanged: (val) {
        context.read<ToolsBloc>().add(FetchTools(categoryName: val ?? "All"));
      },
    );
  }

  Widget _buildSortDropdown(BuildContext context, ToolsState state) {
    const sortOptions = {
      "createdAt": "Date Added",
      "name": "Name",
      "threshold": "Threshold",
    };

    return DropdownButtonFormField<String>(
      value: state.sortBy ?? "createdAt",
      decoration: InputDecoration(
        labelText: "Sort by",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      items: sortOptions.entries
          .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
          .toList(),
      onChanged: (val) {
        context.read<ToolsBloc>().add(
          SortTools(sortBy: val ?? "createdAt", sortDir: state.sortDir),
        );
      },
    );
  }

  Widget _buildFilterDropdown(BuildContext context, ToolsState state) {
    const filters = ["All", "PERISHABLE", "NON-PERISHABLE", "EXPENSIVE"];

    return DropdownButtonFormField<String>(
      value: state.filter ?? "All",
      decoration: InputDecoration(
        labelText: "Filter",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      items: filters
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (val) {
        if (val != null && val != "All") {
          context.read<ToolsBloc>().add(FilterTools(val));
        } else {
          context.read<ToolsBloc>().add(const FetchTools(categoryName: "All"));
        }
      },
    );
  }

  Widget _buildGridSection(ToolsState state) {
    if (state.isLoadingTools && state.tools.isEmpty) {
      return const ProductsGridShimmer();
    }

    if (state.tools.isEmpty) {
      return const Center(
        child: Text(
          StringConstants.noToolsFound,
          style: TextStyle(color: ColorConstants.greyText),
        ),
      );
    }

    return Stack(
      children: [
        GridView.builder(
          controller: scrollCtrl,
          itemCount: state.tools.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.78,
          ),
          itemBuilder: (context, i) {
            final item = state.tools[i];
            return ToolCard(tool: item, onTap: () {});
          },
        ),

        if (state.isLoadingMore)
          const Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          ),
      ],
    );
  }
}
