import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/core/helper_functions.dart';
import 'package:spear_me_app/features/common/widgets/filter_option_product.dart';

import 'package:spear_me_app/features/common/widgets/product_card.dart';
import 'package:spear_me_app/features/common/widgets/product_details_sheet.dart';
import 'package:spear_me_app/features/common/widgets/search_field_widget.dart';
import 'package:spear_me_app/features/common/widgets/filter_sort_section.dart';
import 'package:spear_me_app/features/owner/domain/entity/product_category_entity.dart';
import 'package:spear_me_app/features/owner/presentation/owner_products/owner_products_home/bloc/owner_products_home_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_products/owner_products_home/screens/products_grid_shimmer.dart';
import 'package:spear_me_app/features/owner/presentation/owner_products/owner_products_home/widgets/add_category_bottom_sheet_products.dart';

class OwnerProducts extends StatelessWidget {
  const OwnerProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<OwnerProductsHomeBloc>()
        ..add(FetchProductCategories())
        ..add(const FetchProducts(categoryName: null)),
      child: const OwnerProductsBody(),
    );
  }
}

class OwnerProductsBody extends StatefulWidget {
  const OwnerProductsBody({super.key});

  @override
  State<OwnerProductsBody> createState() => _OwnerProductsBodyState();
}

class _OwnerProductsBodyState extends State<OwnerProductsBody> {
  final TextEditingController searchCtrl = TextEditingController();
  late final ScrollController scrollCtrl;

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
    if (!scrollCtrl.hasClients) {
      return;
    }

    if (scrollCtrl.position.pixels >=
        scrollCtrl.position.maxScrollExtent - 120) {
      context.read<OwnerProductsHomeBloc>().add(LoadMoreProducts());
    }
  }

  Future<void> _refresh() async {
    searchCtrl.clear();
    context.read<OwnerProductsHomeBloc>()
      ..add(const FilterByCategory(null))
      ..add(const FetchProducts(categoryName: null));
  }

  void _handleSortChange(String val) {
    final bloc = context.read<OwnerProductsHomeBloc>();
    bloc.add(SortProducts(sortBy: val));
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
        value: context.read<OwnerProductsHomeBloc>(),
        child: BlocBuilder<OwnerProductsHomeBloc, OwnerProductsHomeState>(
          builder: (context, state) {
            return AddCategoryBottomSheetProducts(
              isLoading: state.isAddingCategory,
              onSubmit: (name, description) {
                context.read<OwnerProductsHomeBloc>().add(
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
        value: context.read<OwnerProductsHomeBloc>(),
        child: BlocBuilder<OwnerProductsHomeBloc, OwnerProductsHomeState>(
          builder: (context, state) {
            return AddCategoryBottomSheetProducts(
              category: ProductCategoryEntity(
                id: id,
                categoryName: name,
                description: description,
              ),
              isLoading: state.isUpdatingCategory,
              onSubmit: (newName, newDescription) {
                context.read<OwnerProductsHomeBloc>().add(
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
              context.read<OwnerProductsHomeBloc>().add(
                DeleteCategoryEvent(categoryId),
              );
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
    return BlocConsumer<OwnerProductsHomeBloc, OwnerProductsHomeState>(
      listener: (context, state) {
        if (state.error != null) {
          HelperFunctions.showSnackBar(
            context,
            message: state.error!,
            isError: true,
          );
        }

        if (state.deleteError != null) {
          HelperFunctions.showSnackBar(
            context,
            message: state.deleteError!,
            isError: true,
          );
        }

        if (state.deleteSuccess != null) {
          HelperFunctions.showSnackBar(
            context,
            message: state.deleteSuccess!,
            isError: false,
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
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: ColorConstants.owner,
            onPressed: () {
              context.push(
                '${RoutesConstants.ownerProductsRoute}/${RoutesConstants.ownerAddProducts}',
                extra: {'isEdit': false},
              );
            },
            icon: const Icon(Icons.add, color: ColorConstants.textOnPrimary),
            label: const Text(
              StringConstants.addProduct,
              style: TextStyle(color: ColorConstants.textOnPrimary),
            ),
          ),
          appBar: AppBar(
            title: const Text(StringConstants.productsTitle),
            backgroundColor: ColorConstants.surface,
            elevation: 0,
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () => _showAddCategoryBottomSheet(context),
                icon: const Icon(Icons.add_circle_outline),
                tooltip: "Add Category",
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SearchField(
                  controller: searchCtrl,
                  hintText: StringConstants.searchProductsHint,
                  onChanged: (val) {
                    context.read<OwnerProductsHomeBloc>().add(
                      SearchProducts(val),
                    );
                  },
                  onClear: () {
                    searchCtrl.clear();
                    context.read<OwnerProductsHomeBloc>().add(
                      SearchProducts(''),
                    );
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
                            label: StringConstants.allCategory,
                            isSelected: isSelected,
                            onTap: () {
                              context.read<OwnerProductsHomeBloc>().add(
                                const FilterByCategory(null),
                              );
                            },
                          );
                        }

                        final category = state.categories[index - 1];
                        final isSelected =
                            state.selectedCategoryName == category.categoryName;

                        return _buildCategoryChip(
                          label: category.categoryName,
                          isSelected: isSelected,
                          onTap: () {
                            context.read<OwnerProductsHomeBloc>().add(
                              FilterByCategory(category.categoryName),
                            );
                          },
                          showMenu: true,
                          onEdit: () => _showEditCategoryBottomSheet(
                            context,
                            category.id,
                            category.categoryName,
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
                  selectedFilterValue: StringConstants.all,
                  selectedSortValue: state.sortBy ?? "createdAt",
                  filterOptions: productsFilters,   
                  sortOptions: productsSort,
                  onFilterChanged: (val) {},
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
                : ColorConstants.border.withAlpha(30),
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

  Widget _buildGrid(OwnerProductsHomeState state) {
    if (state.isLoading && state.products.isEmpty) {
      return const ProductsGridShimmer();
    }

    if (state.products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 64,
              color: ColorConstants.textSecondary.withAlpha(50),
            ),
            const SizedBox(height: 16),
            Text(
              StringConstants.noProductsFound,
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
          itemCount: state.products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.78,
          ),
          itemBuilder: (context, index) {
            final product = state.products[index];

            return ProductCard(
              product: product,
              onTap: () => ProductDetailBottomSheet.show(
                context,
                product: product,
                onDelete: () {
                  context.read<OwnerProductsHomeBloc>().add(
                    DeleteProduct(product.id),
                  );
                },
                onEdit: () {
                  context.push(
                    '${RoutesConstants.ownerProductsRoute}/${RoutesConstants.ownerAddProducts}',
                    extra: {'isEdit': true, 'product': product},
                  );
                },
              ),
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
        if (state.isDeleting)
          Container(
            color: Colors.black26,
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
