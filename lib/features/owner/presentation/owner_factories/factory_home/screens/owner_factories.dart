import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/features/owner/data/data_sources/local_data_source/city_list.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/factory_home/screens/owner_factory_shimmer.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/factory_home/widgets/factory_card.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/factory_home/bloc/owner_factories_bloc.dart';
import 'package:spear_me_app/core/di/di.dart';

class OwnerFactories extends StatelessWidget {
  const OwnerFactories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          OwnerFactoriesBloc(ownerUsecase: di())..add(const FetchFactories()),
      child: const _OwnerFactoriesBody(),
    );
  }
}

class _OwnerFactoriesBody extends StatefulWidget {
  const _OwnerFactoriesBody();

  @override
  State<_OwnerFactoriesBody> createState() => _OwnerFactoriesBodyState();
}

class _OwnerFactoriesBodyState extends State<_OwnerFactoriesBody> {
  final TextEditingController searchController = TextEditingController();
  String selectedLocation = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Factories')),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ColorConstants.owner,
        onPressed: () => context.push(RoutesConstants.ownerAddFactoriesRoute),
        label: const Text(
          "Add Factory",
          style: TextStyle(color: ColorConstants.surface),
        ),
        icon: const Icon(Icons.add, color: ColorConstants.surface),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: (value) {
                context.read<OwnerFactoriesBloc>().add(
                  FetchFactories(search: value.trim()),
                );
              },
              decoration: InputDecoration(
                hintText: 'Search factories...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: locations
                    .map((city) => _buildFilterChip(city))
                    .toList(),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: BlocBuilder<OwnerFactoriesBloc, OwnerFactoriesState>(
                builder: (context, state) {
                  if (state is OwnerFactoriesLoading) {
                    return OwnerFactoriesShimmer();
                  }

                  if (state is OwnerFactoriesFailure) {
                    return Center(child: Text(state.message));
                  }

                  if (state is OwnerFactoriesLoaded) {
                    final factories = state.factories;
                    //! if error wrap with expanded
                    return ListView.builder(
                      itemCount: factories.length,
                      itemBuilder: (_, i) => GestureDetector(
                        onTap: () => context.push(
                          '${RoutesConstants.ownerFactoriesRoute}/details/${factories[i].factoryId}',
                        ),
                        child: FactoryCard(
                          name: factories[i].name,
                          location: factories[i].city,
                          isActive: true,
                        ),
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String city) {
    final bool isSelected = selectedLocation == city;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(city),
        selected: isSelected,
        selectedColor: ColorConstants.owner,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.w600,
        ),
        onSelected: (_) {
          setState(() {
            selectedLocation = isSelected ? "" : city;
          });

          context.read<OwnerFactoriesBloc>().add(
            FetchFactories(search: selectedLocation),
          );
        },
      ),
    );
  }
}
