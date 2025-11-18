import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/features/owner/domain/entity/factory_details_entity.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/factory_details/bloc/factory_details_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/factory_details/widgets/factor_bottom_bar.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/factory_details/widgets/factory_info_card.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/factory_details/widgets/section_card.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/factory_details/widgets/item_list.dart';
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
            StringConstants.factoryDetails,
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
        bottomNavigationBar: FactoryBottomBar(factoryId: factoryId),
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
          FactoryInfoCard(factory: factory),
          const SizedBox(height: 24),
          if (factory.tools?.isNotEmpty ?? false)
            const SectionCard(title: StringConstants.tools, child: SizedBox()),
          if (factory.products?.isNotEmpty ?? false)
            const SectionCard(
              title: StringConstants.products,
              child: SizedBox(),
            ),
          if (factory.tools?.isNotEmpty ?? false)
            ItemList(items: factory.tools!),
          if (factory.products?.isNotEmpty ?? false)
            ItemList(items: factory.products!, isProduct: true),
        ],
      ),
    );
  }
}
