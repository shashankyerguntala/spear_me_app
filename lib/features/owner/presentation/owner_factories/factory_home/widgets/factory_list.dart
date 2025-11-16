import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/factory_home/bloc/owner_factories_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/factory_home/screens/owner_factory_shimmer.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/factory_home/widgets/factory_card.dart';

class FactoriesList extends StatelessWidget {
  final ScrollController scrollController;

  const FactoriesList({required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnerFactoriesBloc, OwnerFactoriesState>(
      buildWhen: (p, c) =>
          p.factories != c.factories ||
          p.isLoading != c.isLoading ||
          p.hasMoreData != c.hasMoreData,
      builder: (context, state) {
        if (state.isLoading && state.factories.isEmpty) {
          return const OwnerFactoriesShimmer();
        }

        if (state.factories.isEmpty) {
          return _EmptyState();
        }

        return RefreshIndicator(
          onRefresh: () async {
            context.read<OwnerFactoriesBloc>().add(const FetchFactories());
          },
          child: ListView.builder(
            controller: scrollController,

            itemCount: state.factories.length + (state.hasMoreData ? 1 : 0),
            itemBuilder: (_, i) {
              if (i >= state.factories.length) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final f = state.factories[i];
              return FactoryCard(
                name: f.name,
                location: f.city,
                isActive: true,
              );
            },
          ),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.factory_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            StringConstants.noFactoryFound,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            StringConstants.tryAdjustingSearch,
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
