import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/core/helper_functions.dart';
import 'package:spear_me_app/features/common/widgets/product_card.dart';
import 'package:spear_me_app/features/common/widgets/product_details_sheet.dart';
import 'package:spear_me_app/features/owner/presentation/owner_products/owner_products_home/screens/products_grid_shimmer.dart';
import 'package:spear_me_app/features/plant_head/presentation/pl_dashboard/pl_products/bloc/pl_products_bloc.dart';

class PlProductsScreen extends StatelessWidget {
  const PlProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<PlProductsBloc>()..add(FetchProductsPlantHead()),
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text('Products')),
        body: _PlProductsBody(),
      ),
    );
  }
}

class _PlProductsBody extends StatelessWidget {
  const _PlProductsBody();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlProductsBloc, PlProductsState>(
      listener: (BuildContext context, PlProductsState state) {
        if (state is PlErrorState) {
          HelperFunctions.showSnackBar(
            context,
            message: state.message,
            isError: true,
          );
        }
      },

      builder: (BuildContext context, PlProductsState state) {
        if (state is PlLoadingState) {
          return ProductsGridShimmer();
        } else if (state is PlLoadedState) {
          if (state.products.isEmpty) {
            return Center(child: Text(StringConstants.noProductsFound));
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisExtent: 16,
              ),
              itemCount: state.products.length,
              itemBuilder: (_, int index) {
                return ProductCard(
                  product: state.products[index],
                  onTap: () {
                    ProductDetailBottomSheet.show(
                      context,
                      product: state.products[index],
                    );
                  },
                );
              },
            );
          }
        } else {
          return SizedBox();
        }
      },
    );
  }
}
