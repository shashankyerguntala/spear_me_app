import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/core/theme/app_text_style.dart';
import 'package:spear_me_app/features/common/widgets/custom_floating_action_button.dart';
import 'package:spear_me_app/features/common/widgets/search_field_widget.dart';
import 'package:spear_me_app/features/owner/presentation/owner_merchandise/merchandise_home/bloc/merchandise_home_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_merchandise/merchandise_home/screens/merchandise_home_body.dart';

class MerchandiseHomeScreen extends StatefulWidget {
  const MerchandiseHomeScreen({super.key});

  @override
  State<MerchandiseHomeScreen> createState() => _MerchandiseHomeScreenState();
}

class _MerchandiseHomeScreenState extends State<MerchandiseHomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<MerchandiseHomeBloc>()..add(FetchMerchandise()),
      child: Scaffold(
        backgroundColor: ColorConstants.surface,
        appBar: AppBar(
          title: Text(
            StringConstants.merchandise,
            style: AppTextStyles.headlineMedium,
          ),
          centerTitle: true,
          backgroundColor: ColorConstants.surface,
          elevation: 0,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
              child: SearchField(
                controller: _searchController,
                hintText: StringConstants.searchMerchandise,
                onChanged: (value) {
                  context.read<MerchandiseHomeBloc>().add(
                    UpdateSearchQuery(value),
                  );
                },
                onClear: () {
                  _searchController.clear();
                  context.read<MerchandiseHomeBloc>().add(
                    const UpdateSearchQuery(''),
                  );
                },
              ),
            ),

            const Expanded(child: MerchandiseHomeBody()),
          ],
        ),
        floatingActionButton: CustomFloatingActionButton(
          label: StringConstants.addMerchandise,
          onPressed: () => context.push(
            '${RoutesConstants.ownerMerchandise}/${RoutesConstants.ownerAddMerchandise}',
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
