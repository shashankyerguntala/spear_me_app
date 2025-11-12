import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/core/helper_functions.dart';
import 'package:spear_me_app/features/common/widgets/custom_floating_action_button.dart';
import 'package:spear_me_app/features/common/widgets/tool_card.dart';
import 'package:spear_me_app/features/owner/presentation/owner_products/owner_products_home/screens/products_grid_shimmer.dart';
import 'package:spear_me_app/features/owner/presentation/owner_tools/tools_home/bloc/tools_bloc.dart';

class ToolsHomeScreen extends StatelessWidget {
  const ToolsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<ToolsBloc>()
        ..add(FetchToolCategories())
        ..add(const FetchTools(categoryName: "All")),
      child: const _ToolsBodyScreen(),
    );
  }
}

class _ToolsBodyScreen extends StatefulWidget {
  const _ToolsBodyScreen();

  @override
  State<_ToolsBodyScreen> createState() => _ToolsBodyScreenState();
}

class _ToolsBodyScreenState extends State<_ToolsBodyScreen> {
  final TextEditingController _searchController = TextEditingController();
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final bloc = context.read<ToolsBloc>();
    if (!_scrollController.hasClients) {
      return;
    }
    final max = _scrollController.position.maxScrollExtent;
    final current = _scrollController.position.pixels;
    if (current >= max - 100) {
      bloc.add(LoadMoreTools());
    }
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
            title: const Text('Tools'),
            centerTitle: true,
            elevation: 0,
            backgroundColor: ColorConstants.surface,
          ),
          floatingActionButton: CustomFloatingActionButton(
            label: "Add Tool",
            onPressed: () => context.push('/owner/addTool'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildSearchBar(context),
                const SizedBox(height: 12),
                _buildCategoryDropdown(state),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _buildSortDropdown(context, state)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildFilterDropdown(context, state)),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(child: _buildGridSection(state)),
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
        child: Text("No tools found", style: TextStyle(color: Colors.grey)),
      );
    }

    return Stack(
      children: [
        GridView.builder(
          controller: _scrollController,
          itemCount: state.tools.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.78,
          ),
          itemBuilder: (context, i) {
            final tool = state.tools[i];
            return ToolCard(tool: tool, onTap: () {});
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
