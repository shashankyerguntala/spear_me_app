import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/core/routes/bottom_nav/owner_bottom_navbar.dart';
import 'package:spear_me_app/core/routes/bottom_nav/plant_head_bottom_navbar.dart';
import 'package:spear_me_app/core/routes/shell_routes/owner_shell_routes.dart';
import 'package:spear_me_app/core/routes/shell_routes/plant_head_shell_routes.dart';
import 'package:spear_me_app/features/authentication/presentation/sign_in/screens/sign_in_screen.dart';
import 'package:spear_me_app/features/authentication/presentation/sign_up/screens/sign_up_screen.dart';

// ignore: avoid_classes_with_only_static_members
class Routes {
  static final GoRouter router = GoRouter(
    initialLocation: RoutesConstants.plantHeadHomeRoute,
    routes: <RouteBase>[
      //! owner shell
      ShellRoute(
        navigatorKey: ownerKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return OwnerBottomNavbar(child: child);
        },
        routes: ownerRoutes,
      ),
      //! plant head shell
      ShellRoute(
        navigatorKey: plantHeadKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return PlantHeadBottomNavbar(child: child);
        },
        routes: plantHeadRoutes,
      ),
      GoRoute(
        path: RoutesConstants.loginRoute,
        builder: (BuildContext context, GoRouterState state) => SignInScreen(),
      ),
      GoRoute(
        path: RoutesConstants.registerRoute,
        builder: (BuildContext context, GoRouterState state) => SignUpScreen(),
      ),
    ],
  );
}
