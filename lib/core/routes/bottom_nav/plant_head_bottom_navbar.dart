import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';

class PlantHeadBottomNavbar extends StatelessWidget {
  final Widget child;
  const PlantHeadBottomNavbar({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    final tabs = [
      RoutesConstants.plantHeadHomeRoute,
      RoutesConstants.plantHeadRequestsRoute,
      RoutesConstants.plantHeadCreateRoute,
      RoutesConstants.plantHeadToolsRoute,
      RoutesConstants.plantHeadProfileRoute,
    ];

    int selectedIndex = tabs.indexWhere((path) => location.startsWith(path));
    selectedIndex = selectedIndex == -1 ? 0 : selectedIndex;

    return Scaffold(
      body: child,
      bottomNavigationBar: CurvedNavigationBar(
        index: selectedIndex,
        height: 60,
        backgroundColor: Colors.transparent,
        color: ColorConstants.plantHead,
        buttonBackgroundColor: ColorConstants.plantHeadLight,
        animationDuration: Duration(milliseconds: 350),
        animationCurve: Curves.linear,
        onTap: (i) => context.go(tabs[i]),
        items: const [
          Icon(Icons.dashboard, size: 28, color: ColorConstants.surface),
          Icon(Icons.move_to_inbox, size: 28, color: ColorConstants.surface),
          Icon(Icons.add, size: 28, color: ColorConstants.surface),
          Icon(Icons.handyman, size: 28, color: ColorConstants.surface),
          Icon(Icons.people, size: 28, color: ColorConstants.surface),
        ],
      ),
    );
  }
}
