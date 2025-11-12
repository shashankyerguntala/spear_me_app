import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/core/helper_functions.dart';
import 'package:spear_me_app/features/owner/presentation/owner_merchandise/merchandise_home/bloc/merchandise_home_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_merchandise/merchandise_home/widgets/merchandise_card.dart';
import 'package:spear_me_app/features/owner/presentation/owner_merchandise/merchandise_home/widgets/merchandise_grid_shimmer.dart';

class MerchandiseHomeBody extends StatefulWidget {
  const MerchandiseHomeBody({super.key});

  @override
  State<MerchandiseHomeBody> createState() => _MerchandiseHomeBodyState();
}

class _MerchandiseHomeBodyState extends State<MerchandiseHomeBody> {
  final searchController = TextEditingController();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100) {
      context.read<MerchandiseHomeBloc>().add(
        const FetchMerchandise(isLoadMore: true),
      );
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MerchandiseHomeBloc, MerchandiseHomeState>(
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
        if (state.isLoading && state.items.isEmpty) {
          return const MerchandiseGridShimmer();
        }

        if (state.errorMessage != null && state.items.isEmpty) {
          return Center(child: Text(state.errorMessage!));
        }

        if (state.items.isEmpty) {
          return const Center(child: Text(StringConstants.noMerchandiseFound));
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildSearchBar(context),
              const SizedBox(height: 12),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<MerchandiseHomeBloc>().add(
                      const FetchMerchandise(),
                    );
                  },
                  child: GridView.builder(
                    controller: scrollController,
                    itemCount:
                        state.items.length + (state.isLoadingMore ? 1 : 0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 14,
                          crossAxisSpacing: 14,
                          childAspectRatio: 0.78,
                        ),
                    itemBuilder: (context, index) {
                      if (index == state.items.length && state.isLoadingMore) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      }
                      final merchandise = state.items[index];
                      return MerchandiseCard(merchandise: merchandise);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: "Search merchandise...",
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onChanged: (value) {
        context.read<MerchandiseHomeBloc>().add(
          FetchMerchandise(search: value),
        );
      },
    );
  }
}
