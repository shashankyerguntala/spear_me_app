import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/features/owner/domain/entity/factory_details_entity.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/factory_details/bloc/factory_details_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/factory_home/screens/owner_factory_shimmer.dart';

class FactoryDetailsScreen extends StatelessWidget {
  final int factoryId;

  const FactoryDetailsScreen({required this.factoryId, super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FactoryDetailsBloc>(
      create: (_) =>
          di<FactoryDetailsBloc>()..add(FetchFactoryDetailsEvent(factoryId)),
      child: Scaffold(
        backgroundColor: ColorConstants.scaffoldBg,
        appBar: AppBar(
          backgroundColor: ColorConstants.primary,
          title: const Text(
            "Factory Details",
            style: TextStyle(color: ColorConstants.textOnPrimary),
          ),
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: BlocBuilder<FactoryDetailsBloc, FactoryDetailsState>(
          builder: (context, state) {
            if (state is FactoryDetailsLoading) {
              return const OwnerFactoriesShimmer();
            } else if (state is FactoryDetailsFailure) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(
                    color: ColorConstants.error,
                    fontSize: 16,
                  ),
                ),
              );
            } else if (state is FactoryDetailsSuccess) {
              final factory = state.factory;
              return _FactoryDetailsBody(factory: factory);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _FactoryDetailsBody extends StatelessWidget {
  final FactoryDetailsEntity factory;

  const _FactoryDetailsBody({required this.factory});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FactoryInfoCard(factory: factory),
          const SizedBox(height: 24),
          if (factory.tools?.isNotEmpty ?? false)
            _SectionCard(
              title: "Tools",
              child: _ToolList(tools: factory.tools!),
            ),
          if (factory.products?.isNotEmpty ?? false)
            _SectionCard(
              title: "Products",
              child: _ProductList(products: factory.products!),
            ),
        ],
      ),
    );
  }
}

class _FactoryInfoCard extends StatelessWidget {
  final FactoryDetailsEntity factory;

  const _FactoryInfoCard({required this.factory});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: ColorConstants.shadow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: ColorConstants.surface,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              factory.factoryName ?? "Unnamed Factory",
              style: const TextStyle(
                color: ColorConstants.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: ColorConstants.primaryLight,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  factory.location ?? "Unknown",
                  style: const TextStyle(
                    color: ColorConstants.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.people_outline,
                  color: ColorConstants.accent,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  "Total Employees: ${factory.totalEmployees ?? 0}",
                  style: const TextStyle(
                    color: ColorConstants.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: ColorConstants.shadow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: ColorConstants.surface,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: ColorConstants.primaryDark,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _ToolList extends StatelessWidget {
  final List tools;

  const _ToolList({required this.tools});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: tools.map((tool) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ColorConstants.scaffoldBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tool.toolName ?? "Unknown Tool",
                style: const TextStyle(
                  color: ColorConstants.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Available: ${tool.availableQuantity ?? 0}",
                style: const TextStyle(
                  color: ColorConstants.primaryLight,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _ProductList extends StatelessWidget {
  final List products;

  const _ProductList({required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: products.map((product) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ColorConstants.scaffoldBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product.productName ?? "Unknown Product",
                style: const TextStyle(
                  color: ColorConstants.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Produced: ${product.producedQuantity ?? 0}",
                style: const TextStyle(
                  color: ColorConstants.accent,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
