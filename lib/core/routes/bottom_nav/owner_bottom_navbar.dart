import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';

class OwnerBottomNavbar extends StatelessWidget {
  final Widget child;
  const OwnerBottomNavbar({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    final tabs = [
      RoutesConstants.ownerHomeRoute,
      RoutesConstants.ownerFactoriesRoute,
      RoutesConstants.ownerCentralOfficesRoute,
      RoutesConstants.ownerMerchandise,
      RoutesConstants.ownerEmployeesRoute,
    ];

    int selectedIndex = tabs.indexWhere((path) => location.startsWith(path));
    selectedIndex = selectedIndex == -1 ? 0 : selectedIndex;
    return Scaffold(
      body: child,
      bottomNavigationBar: CurvedNavigationBar(
        index: selectedIndex,
        height: 60,
        backgroundColor: Colors.transparent,
        color: ColorConstants.primary,
        buttonBackgroundColor: ColorConstants.primaryLight,
        animationDuration: Duration(milliseconds: 350),
        animationCurve: Curves.easeIn,
        onTap: (i) => context.go(tabs[i]),
        items: const [
          Icon(Icons.dashboard, size: 28, color: ColorConstants.surface),
          Icon(Icons.factory, size: 28, color: ColorConstants.surface),
          Icon(Icons.apartment, size: 28, color: ColorConstants.surface),
          Icon(Icons.inventory_2, size: 28, color: ColorConstants.surface),
          Icon(
            Icons.people_outline_outlined,
            size: 28,
            color: ColorConstants.surface,
          ),
        ],
      ),
    );
  }
}
