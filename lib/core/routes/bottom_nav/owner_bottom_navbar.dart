import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';

class OwnerBottomNavbar extends StatelessWidget {
  final Widget child;
  const OwnerBottomNavbar({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    final List<String> tabs = <String>[
      RoutesConstants.ownerHomeRoute,
      '/owner/factories',
      '/owner/central-office',
      '/owner/products',
      '/owner/employees',
    ];

    final int currentIndex = tabs.indexWhere(
      (String path) => location.startsWith(path),
    );

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex == -1 ? 0 : currentIndex,
        onTap: (int index) => context.go(tabs[index]),

        selectedItemColor: ColorConstants.primary,
        unselectedItemColor: ColorConstants.textSecondary,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.factory),
            label: 'Factories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apartment),
            label: 'Central Office',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Products',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Employees'),
        ],
      ),
    );
  }
}
