import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/core/routes/bottom_nav/owner_bottom_navbar.dart';
import 'package:spear_me_app/core/routes/bottom_nav/plant_head_bottom_navbar.dart';
import 'package:spear_me_app/core/routes/shell_routes/owner_shell_routes.dart';
import 'package:spear_me_app/core/routes/shell_routes/plant_head_shell_routes.dart';
import 'package:spear_me_app/features/authentication/data/model/roles_enum.dart';
import 'package:spear_me_app/features/authentication/presentation/sign_in/screens/sign_in_screen.dart';
import 'package:spear_me_app/features/authentication/presentation/sign_up/screens/sign_up_screen.dart';
import 'package:spear_me_app/features/owner/presentation/owner_products/owner_add_product/screens/owner_add_products.dart';
import 'package:spear_me_app/features/owner/presentation/owner_products/owner_products_home/screens/owner_products.dart';
import 'package:spear_me_app/features/owner/presentation/owner_profile/screens/owner_profile_screen.dart';
import 'package:spear_me_app/features/owner/presentation/owner_tools/add_tools/screens/add_tools_screen.dart';
import 'package:spear_me_app/features/owner/presentation/owner_tools/tools_home/screens/owner_tools_screen.dart';

class Routes {
  static final GoRouter router = GoRouter(
    initialLocation: RoutesConstants.loginRoute,
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

      //!common routes
      GoRoute(
        path: RoutesConstants.ownerToolsRoutes,
        builder: (context, state) => ToolsHomeScreen(role: RolesEnum.owner),
        routes: [
          GoRoute(
            path: RoutesConstants.ownerAddTools,
            builder: (context, state) => AddToolsScreen(),
          ),
        ],
      ),

      GoRoute(
        path: RoutesConstants.ownerProductsRoute,
        builder: (context, state) => OwnerProducts(),
        routes: [
          GoRoute(
            path: RoutesConstants.ownerAddProducts,
            builder: (context, state) => OwnerAddProducts(),
          ),
          // GoRoute(
          //   path: RoutesConstants.ownerAddCategory,
          //   builder: (context, state) => OwnerAddCategory(),
          // ),
        ],
      ),

      GoRoute(
        path: RoutesConstants.ownerProfileRoute,
        builder: (BuildContext context, GoRouterState state) =>
            OwnerProfileScreen(),
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
