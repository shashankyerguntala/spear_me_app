import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/core/helper_functions.dart';
import 'package:spear_me_app/features/common/widgets/product_card.dart';
import 'package:spear_me_app/features/common/widgets/product_details_sheet.dart';
import 'package:spear_me_app/features/owner/presentation/owner_products/owner_products_home/bloc/owner_products_home_bloc.dart';

class OwnerProducts extends StatelessWidget {
  const OwnerProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<OwnerProductsHomeBloc>()
        ..add(FetchProductCategories())
        ..add(FetchProducts()),
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
  String chosenCategory = StringConstants.allCategory;

  @override
  void dispose() {
    searchCtrl.dispose();
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
          title: const Text(StringConstants.productsTitle),
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
          icon: const Icon(Icons.add, color: ColorConstants.textOnPrimary),
          label: const Text(
            StringConstants.addProduct,
            style: TextStyle(color: ColorConstants.textOnPrimary),
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: searchCtrl,
                decoration: InputDecoration(
                  hintText: StringConstants.searchProductsHint,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  context.read<OwnerProductsHomeBloc>().add(
                    FetchProducts(
                      search: value.trim(),
                      categoryName:
                          chosenCategory == StringConstants.allCategory
                          ? null
                          : chosenCategory,
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              BlocBuilder<OwnerProductsHomeBloc, OwnerProductsHomeState>(
                builder: (context, state) {
                  final categoryList = [
                    StringConstants.allCategory,
                    ...state.categories.map((e) => e.categoryName),
                  ];

                  return SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: categoryList
                                .map((cat) => createCategoryChip(cat))
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
                                FetchProductCategories(),
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
                              color: ColorConstants.textOnPrimary,
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
                              color: ColorConstants.error,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              state.error!,
                              style: const TextStyle(
                                color: ColorConstants.error,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: () {
                                context.read<OwnerProductsHomeBloc>().add(
                                  FetchProducts(
                                    search: searchCtrl.text.trim(),
                                    categoryName:
                                        chosenCategory ==
                                            StringConstants.allCategory
                                        ? null
                                        : chosenCategory,
                                  ),
                                );
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text(StringConstants.retry),
                            ),
                          ],
                        ),
                      );
                    }

                    final productList = state.products?.content ?? [];

                    if (productList.isEmpty) {
                      return const Center(
                        child: Text(
                          StringConstants.noProductsFound,
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorConstants.textSecondary,
                          ),
                        ),
                      );
                    }

                    return Stack(
                      children: [
                        GridView.builder(
                          itemCount: productList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 14,
                                crossAxisSpacing: 14,
                                childAspectRatio: 0.78,
                              ),
                          itemBuilder: (_, i) {
                            final item = productList[i];
                            return ProductCard(
                              product: item,
                              onTap: () => ProductDetailBottomSheet.show(
                                context,
                                product: item,
                                onDelete: () {
                                  context.read<OwnerProductsHomeBloc>().add(
                                    DeleteProduct(item.id),
                                  );
                                },
                                onEdit: () {
                                  context.push(
                                    RoutesConstants.ownerAddProducts,
                                    extra: {'isEdit': true, 'product': item},
                                  );
                                },
                              ),
                            );
                          },
                        ),

                        if (state.isDeleting)
                          Container(
                            color: ColorConstants.overlayDark,
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

  Widget createCategoryChip(String cat) {
    final isSelected = chosenCategory == cat;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(cat),
        selected: isSelected,
        selectedColor: ColorConstants.primary,
        labelStyle: TextStyle(
          color: isSelected
              ? ColorConstants.textOnPrimary
              : ColorConstants.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        onSelected: (_) {
          setState(() => chosenCategory = cat);
          context.read<OwnerProductsHomeBloc>().add(
            FetchProducts(
              search: searchCtrl.text.trim(),
              categoryName: cat == StringConstants.allCategory ? null : cat,
            ),
          );
        },
      ),
    );
  }
}
