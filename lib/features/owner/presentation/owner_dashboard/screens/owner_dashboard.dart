import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/assets_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/features/owner/presentation/owner_dashboard/bloc/owner_home_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_dashboard/widgets/bar_chart_widget.dart';
import 'package:spear_me_app/features/owner/presentation/owner_dashboard/widgets/stat_card.dart';

class OwnerDashboard extends StatelessWidget {
  const OwnerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider<OwnerHomeBloc>(
      create: (BuildContext context) =>
          OwnerHomeBloc()..add(OwnerInitialEvent()),
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: IconButton(
                onPressed: () {
                  context.go(RoutesConstants.ownerProfileRoute);
                },
                icon: Icon(Icons.person),
              ),
            ),
          ],
        ),
        body: BlocBuilder<OwnerHomeBloc, OwnerHomeState>(
          builder: (BuildContext context, OwnerHomeState state) {
            if (state is OwnerLoading) {
              return Center(
                child: Lottie.asset(AssetsConstants.dashboardLoadingAsset),
              );
            } else if (state is OwnerLoaded) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    spacing: 28,
                    children: <Widget>[
                      GridView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.5,
                        ),
                        children: <Widget>[
                          StatCard(label: 'Factories'),
                          StatCard(label: 'Factories'),
                          StatCard(label: 'Factories'),
                          StatCard(label: 'Factories'),
                        ],
                      ),

                      Container(
                        width: double.infinity,
                        height: screenHeight * 0.4,

                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: ColorConstants.border),
                        ),

                        child: const BarChartWidget(),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
