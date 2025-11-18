import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/features/common/widgets/custom_floating_action_button.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/factory_home/bloc/owner_factories_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/factory_home/widgets/factory_list.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/factory_home/widgets/filters_section.dart';

class OwnerFactories extends StatelessWidget {
  const OwnerFactories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<OwnerFactoriesBloc>()..add(FetchFactories()),
      child: const _OwnerFactoriesView(),
    );
  }
}

class _OwnerFactoriesView extends StatefulWidget {
  const _OwnerFactoriesView();

  @override
  State<_OwnerFactoriesView> createState() => _OwnerFactoriesViewState();
}

class _OwnerFactoriesViewState extends State<_OwnerFactoriesView> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scroll.hasClients) {
      return;
    }

    final max = _scroll.position.maxScrollExtent;
    final offset = _scroll.offset;

    if (offset >= max * 0.9) {
      context.read<OwnerFactoriesBloc>().add(const LoadMoreFactories());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(StringConstants.factories)),
      floatingActionButton: CustomFloatingActionButton(
        label: StringConstants.addFactory,
        onPressed: () {
          context.push(
            '${RoutesConstants.ownerFactoriesRoute}/${RoutesConstants.ownerAddFactoriesRoute}',
            extra: {'isEdit': false, 'factory': null},
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          children: [
            FiltersSection(searchController: _searchController),

            Expanded(child: FactoriesList(scrollController: _scroll)),
          ],
        ),
      ),
    );
  }
}
