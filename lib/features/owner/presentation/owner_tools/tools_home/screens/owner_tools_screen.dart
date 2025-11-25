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

import 'package:spear_me_app/features/authentication/data/model/roles_enum.dart';
import 'package:spear_me_app/features/owner/data/data_sources/local_data_source/filter_options_products.dart';
import 'package:spear_me_app/features/owner/data/data_sources/local_data_source/sort_options_products.dart';
import 'package:spear_me_app/features/owner/domain/entity/tools_category_entity.dart';

import 'package:spear_me_app/features/owner/presentation/owner_products/owner_products_home/screens/products_grid_shimmer.dart';
import 'package:spear_me_app/features/owner/presentation/owner_tools/add_tools/screens/add_tools_screen.dart';
import 'package:spear_me_app/features/owner/presentation/owner_tools/tools_details/screens/tool_details_screen.dart';
import 'package:spear_me_app/features/owner/presentation/owner_tools/tools_home/widgets/add_category_bottom_sheet.dart';

import 'package:spear_me_app/features/owner/presentation/owner_tools/tools_home/bloc/tools_bloc.dart';

class ToolsHomeScreen extends StatelessWidget {
  final RolesEnum role;

  const ToolsHomeScreen({required this.role, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<ToolsBloc>()
        ..add(FetchToolCategories())
        ..add(const FetchTools(categoryName: null)),
      child: ToolsBodyScreen(role: role),
    );
  }
}

class ToolsBodyScreen extends StatefulWidget {
  final RolesEnum role;

  const ToolsBodyScreen({required this.role, super.key});

  @override
  State<ToolsBodyScreen> createState() => _ToolsBodyScreenState();
}

class _ToolsBodyScreenState extends State<ToolsBodyScreen> {
  final TextEditingController searchCtrl = TextEditingController();
  late final ScrollController scrollCtrl;

  bool get isOwner =>
      widget.role == RolesEnum.owner || widget.role == RolesEnum.centralOffice;

  @override
  void initState() {
    super.initState();
    scrollCtrl = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    scrollCtrl.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!scrollCtrl.hasClients) return;

    if (scrollCtrl.position.pixels >=
        scrollCtrl.position.maxScrollExtent - 120) {
      context.read<ToolsBloc>().add(LoadMoreTools());
    }
  }

  Future<void> _refresh() async {
    searchCtrl.clear();
    context.read<ToolsBloc>()
      ..add(const FilterByCategory(null))
      ..add(const FetchTools(categoryName: null));
  }

  void _handleFilterChange(String val) {
    context.read<ToolsBloc>().add(FilterTools(val));
  }

  void _handleSortChange(String val) {
    final s = context.read<ToolsBloc>().state;
    context.read<ToolsBloc>().add(SortTools(sortBy: val, sortDir: s.sortDir));
  }

  void _showAddCategoryBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ColorConstants.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<ToolsBloc>(),
        child: BlocBuilder<ToolsBloc, ToolsState>(
          builder: (context, state) {
            return AddCategoryBottomSheet(
              isLoading: state.isAddingCategory,
              onSubmit: (name, description) {
                context.read<ToolsBloc>().add(
                  AddCategoryEvent(name: name, description: description),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showEditCategoryBottomSheet(
    BuildContext context,
    int id,
    String name,
    String description,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ColorConstants.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<ToolsBloc>(),
        child: BlocBuilder<ToolsBloc, ToolsState>(
          builder: (context, state) {
            return AddCategoryBottomSheet(
              category: ToolCategoryEntity(
                id: id,
                name: name,
                description: description,
              ),
              isLoading: state.isUpdatingCategory,
              onSubmit: (newName, newDescription) {
                context.read<ToolsBloc>().add(
                  UpdateCategoryEvent(
                    id: id,
                    name: newName,
                    description: newDescription,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showDeleteCategoryConfirmation(BuildContext context, int categoryId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Delete Category"),
        content: const Text(
          "Are you sure you want to delete this category? This action cannot be undone.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<ToolsBloc>().add(DeleteCategoryEvent(categoryId));
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("Delete"),
          ),
        ],
      ),
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

        if (state.successMessage != null) {
          HelperFunctions.showSnackBar(
            context,
            message: state.successMessage!,
            isError: false,
          );
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorConstants.surface,
          floatingActionButton: isOwner
              ? CustomFloatingActionButton(
                  label: StringConstants.addTool,
                  onPressed: () => context.push(
                    '${RoutesConstants.ownerToolsRoutes}/${RoutesConstants.ownerAddTools}',
                  ),
                )
              : null,
          appBar: AppBar(
            title: const Text(StringConstants.toolsTitle),
            centerTitle: true,
            backgroundColor: ColorConstants.surface,
            elevation: 0,
            actions: isOwner
                ? [
                    IconButton(
                      onPressed: () => _showAddCategoryBottomSheet(context),
                      icon: const Icon(Icons.add_circle_outline),
                      tooltip: "Add Category",
                    ),
                  ]
                : null,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SearchField(
                  controller: searchCtrl,
                  hintText: StringConstants.searchToolsHint,
                  onChanged: (val) {
                    context.read<ToolsBloc>().add(SearchTools(val));
                  },
                  onClear: () {
                    searchCtrl.clear();
                    context.read<ToolsBloc>().add(SearchTools(''));
                  },
                ),
                const SizedBox(height: 12),

                if (state.categories.isNotEmpty)
                  SizedBox(
                    height: 44,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      itemCount: state.categories.length + 1,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          final isSelected = state.selectedCategoryName == null;
                          return _buildCategoryChip(
                            label: "All",
                            isSelected: isSelected,
                            onTap: () {
                              context.read<ToolsBloc>().add(
                                const FilterByCategory(null),
                              );
                            },
                          );
                        }

                        final category = state.categories[index - 1];
                        final isSelected =
                            state.selectedCategoryName == category.name;

                        return _buildCategoryChip(
                          label: category.name,
                          isSelected: isSelected,
                          onTap: () {
                            context.read<ToolsBloc>().add(
                              FilterByCategory(category.name),
                            );
                          },
                          showMenu: isOwner,
                          onEdit: () => _showEditCategoryBottomSheet(
                            context,
                            category.id,
                            category.name,
                            category.description,
                          ),
                          onDelete: () => _showDeleteCategoryConfirmation(
                            context,
                            category.id,
                          ),
                        );
                      },
                    ),
                  ),

                if (state.categories.isNotEmpty) const SizedBox(height: 12),

                FilterSortSection(
                  selectedFilterValue: state.filter ?? StringConstants.all,
                  selectedSortValue: state.sortBy ?? "createdAt",
                  filterOptions: toolsFilters,
                  sortOptions: toolsSort,
                  onFilterChanged: _handleFilterChange,
                  onSortChanged: _handleSortChange,
                ),
                const SizedBox(height: 16),

                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _refresh,
                    child: _buildGrid(state),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    bool showMenu = false,
    VoidCallback? onEdit,
    VoidCallback? onDelete,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: showMenu ? 8 : 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? ColorConstants.primary : ColorConstants.cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? ColorConstants.primary
                : ColorConstants.border.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : ColorConstants.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            if (showMenu) ...[
              const SizedBox(width: 4),
              PopupMenuButton<String>(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.more_vert,
                  size: 16,
                  color: isSelected
                      ? Colors.white
                      : ColorConstants.textSecondary,
                ),
                offset: const Offset(0, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onSelected: (value) {
                  if (value == 'edit' && onEdit != null) {
                    onEdit();
                  } else if (value == 'delete' && onDelete != null) {
                    onDelete();
                  }
                },
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem<String>(
                    value: 'edit',
                    height: 40,
                    child: Row(
                      children: [
                        Icon(Icons.edit, size: 18),
                        SizedBox(width: 12),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'delete',
                    height: 40,
                    child: Row(
                      children: [
                        Icon(Icons.delete, size: 18, color: Colors.red),
                        SizedBox(width: 12),
                        Text('Delete', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(ToolsState state) {
    if (state.isLoadingTools && state.tools.isEmpty) {
      return const ProductsGridShimmer();
    }

    if (state.tools.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction_outlined,
              size: 64,
              color: ColorConstants.textSecondary.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              "No tools found",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: ColorConstants.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return Stack(
      children: [
        GridView.builder(
          controller: scrollCtrl,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: state.tools.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            final tool = state.tools[index];

            return ToolCard(
              tool: tool,
              role: widget.role,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ToolDetailsScreen(tool: tool, role: widget.role),
                  ),
                );
              },
              onEdit: isOwner
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              AddToolsScreen(tool: tool, isEdit: true),
                        ),
                      );
                    }
                  : () {},
              onDelete: isOwner
                  ? () {
                      HelperFunctions.showSnackBar(
                        context,
                        message: "Delete tool feature coming soon",
                        isError: false,
                      );
                    }
                  : () {},
            );
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
