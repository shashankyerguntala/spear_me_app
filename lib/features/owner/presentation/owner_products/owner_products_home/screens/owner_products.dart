import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/core/helper_functions.dart';
import 'package:spear_me_app/features/common/widgets/product_card.dart';
import 'package:spear_me_app/features/owner/presentation/owner_products/owner_products_home/bloc/owner_products_home_bloc.dart';
import 'package:spear_me_app/features/common/widgets/product_details_sheet.dart';

class OwnerProducts extends StatelessWidget {
  const OwnerProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<OwnerProductsHomeBloc>()
        ..add(FetchProductCategories())
        ..add(FetchProducts()),
      child: const _OwnerProductsBody(),
    );
  }
}

class _OwnerProductsBody extends StatefulWidget {
  const _OwnerProductsBody();

  @override
  State<_OwnerProductsBody> createState() => _OwnerProductsBodyState();
}

class _OwnerProductsBodyState extends State<_OwnerProductsBody> {
  final TextEditingController searchController = TextEditingController();
  String selectedCategory = "All";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OwnerProductsHomeBloc, OwnerProductsHomeState>(
      listener: (context, state) {
        if (state.deleteSuccess != null) {
          HelperFunctions.showSnackBar(
            context,
            message: state.deleteSuccess!,
            isError: false,
          );
        }

        if (state.deleteError != null) {
          HelperFunctions.showSnackBar(
            context,
            message: state.deleteError!,
            isError: true,
          );
        }
      },
      child: Scaffold(
        backgroundColor: ColorConstants.surface,
        appBar: AppBar(
          title: const Text("Products"),
          backgroundColor: ColorConstants.surface,
          elevation: 0,
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: ColorConstants.owner,
          onPressed: () {
            context.push(
              RoutesConstants.ownerAddProducts,
              extra: {'isEdit': false},
            );
          },
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text(
            "Add Product",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  context.read<OwnerProductsHomeBloc>().add(
                    FetchProducts(
                      search: value.trim(),
                      categoryName: selectedCategory == "All"
                          ? null
                          : selectedCategory,
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              BlocBuilder<OwnerProductsHomeBloc, OwnerProductsHomeState>(
                builder: (context, state) {
                  final categories = [
                    "All",
                    ...state.categories.map((e) => e.categoryName),
                  ];

                  return SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: categories
                                .map((c) => _buildCategoryChip(c))
                                .toList(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () async {
                            final status = await context.push<bool>(
                              RoutesConstants.ownerAddCategory,
                            );

                            if (status == true && context.mounted) {
                              context.read<OwnerProductsHomeBloc>().add(
                                (FetchProductCategories()),
                              );
                              context.read<OwnerProductsHomeBloc>().add(
                                FetchProducts(),
                              );
                            }
                          },
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: ColorConstants.primary,
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<OwnerProductsHomeBloc, OwnerProductsHomeState>(
                  builder: (context, state) {
                    if (state.isLoading && state.products == null) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.error != null) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              state.error!,
                              style: const TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: () {
                                context.read<OwnerProductsHomeBloc>().add(
                                  FetchProducts(
                                    search: searchController.text.trim(),
                                    categoryName: selectedCategory == "All"
                                        ? null
                                        : selectedCategory,
                                  ),
                                );
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text("Retry"),
                            ),
                          ],
                        ),
                      );
                    }

                    final products = state.products?.content ?? [];

                    if (products.isEmpty) {
                      return const Center(
                        child: Text(
                          "No products found",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      );
                    }

                    return Stack(
                      children: [
                        GridView.builder(
                          itemCount: products.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 14,
                                crossAxisSpacing: 14,
                                childAspectRatio: 0.78,
                              ),
                          itemBuilder: (_, i) {
                            final p = products[i];
                            return ProductCard(
                              product: p,
                              onTap: () => ProductDetailBottomSheet.show(
                                context,
                                product: p,
                                onDelete: () {
                                  context.read<OwnerProductsHomeBloc>().add(
                                    DeleteProduct(p.id),
                                  );
                                },
                                onEdit: () {
                                  context.push(
                                    RoutesConstants.ownerAddProducts,
                                    extra: {'isEdit': true, 'product': p},
                                  );
                                },
                              ),
                            );
                          },
                        ),

                        if (state.isDeleting)
                          Container(
                            color: Colors.black26,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    final isSelected = selectedCategory == category;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(category),
        selected: isSelected,
        selectedColor: ColorConstants.primary,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.w600,
        ),
        onSelected: (_) {
          setState(() => selectedCategory = category);
          context.read<OwnerProductsHomeBloc>().add(
            FetchProducts(
              search: searchController.text.trim(),
              categoryName: category == "All" ? null : category,
            ),
          );
        },
      ),
    );
  }
}
