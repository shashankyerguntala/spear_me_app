import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/features/common/widgets/custom_floating_action_button.dart';
import 'package:spear_me_app/features/owner/presentation/owner_merchandise/merchandise_home/bloc/merchandise_home_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_merchandise/merchandise_home/screens/merchandise_home_body.dart';

class MerchandiseHomeScreen extends StatelessWidget {
  const MerchandiseHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<MerchandiseHomeBloc>()..add(const FetchMerchandise()),
      child: Scaffold(
        backgroundColor: ColorConstants.surface,
        appBar: AppBar(
          title: const Text(StringConstants.merchandise),
          centerTitle: true,
          backgroundColor: ColorConstants.surface,
          elevation: 0,
        ),
        body: const MerchandiseHomeBody(),
        floatingActionButton: CustomFloatingActionButton(
          label: StringConstants.addMerchandise,
          onPressed: () => context.push(RoutesConstants.ownerAddMerchandise),
        ),
      ),
    );
  }
}
