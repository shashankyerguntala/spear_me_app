import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/features/owner/presentation/owner_central_office/add_central_office/screens/add_central_officer.dart';
import 'package:spear_me_app/features/owner/presentation/owner_central_office/owner_central_office_home/screens/owner_central_offices.dart';
import 'package:spear_me_app/features/owner/presentation/owner_dashboard/screens/owner_dashboard.dart';
import 'package:spear_me_app/features/owner/presentation/owner_employees/screens/owner_employees.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/add_factory/screen/add_factory_screen.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/create_plant_head/screens/create_plant_head.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/factory_details/screens/factory_details_screen.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/factory_home/screens/owner_factories.dart';
import 'package:spear_me_app/features/owner/presentation/owner_merchandise/add_merchandise/screens/add_merchandise_screen.dart';
import 'package:spear_me_app/features/owner/presentation/owner_merchandise/merchandise_home/screens/merchandise_home_screen.dart';
import 'package:spear_me_app/features/owner/presentation/owner_products/owner_add_category/screens/owner_add_category.dart';
import 'package:spear_me_app/features/owner/presentation/owner_products/owner_add_product/screens/owner_add_products.dart';
import 'package:spear_me_app/features/owner/presentation/owner_products/owner_products_home/screens/owner_products.dart';
import 'package:spear_me_app/features/owner/presentation/owner_profile/screens/owner_profile_screen.dart';
import 'package:spear_me_app/features/owner/presentation/owner_tools/add_tools/screens/add_tools_screen.dart';
import 'package:spear_me_app/features/owner/presentation/owner_tools/tools_home/screens/owner_tools_screen.dart';

final GlobalKey<NavigatorState> ownerKey = GlobalKey<NavigatorState>();
final List<GoRoute> ownerRoutes = <GoRoute>[
  GoRoute(
    path: RoutesConstants.ownerHomeRoute,
    builder: (BuildContext context, GoRouterState state) => OwnerDashboard(),
    routes: [
      GoRoute(
        path: 'profile',
        builder: (BuildContext context, GoRouterState state) =>
            const OwnerProfileScreen(),
      ),
    ],
  ),

  GoRoute(
    path: RoutesConstants.ownerFactoriesRoute,
    builder: (BuildContext context, GoRouterState state) => OwnerFactories(),
    routes: [
      GoRoute(
        path: 'add',
        builder: (BuildContext context, GoRouterState state) =>
            const AddFactoryScreen(),
      ),
      GoRoute(
        path: 'details/:id',
        builder: (BuildContext context, GoRouterState state) {
          final id = int.parse(state.pathParameters['id']!);
          return FactoryDetailsScreen(factoryId: id);
        },
      ),
      GoRoute(
        path: 'create-plant-head',
        builder: (BuildContext context, GoRouterState state) =>
            const CreatePlantHeadScreen(),
      ),
    ],
  ),

  GoRoute(
    path: RoutesConstants.ownerCentralOfficesRoute,
    builder: (BuildContext context, GoRouterState state) =>
        CentralOfficeScreen(),
    routes: [
      GoRoute(
        path: 'add',
        builder: (BuildContext context, GoRouterState state) =>
            const AddCentralOffice(),
      ),
    ],
  ),

  GoRoute(
    path: RoutesConstants.ownerMerchandise,
    builder: (BuildContext context, GoRouterState state) =>
        const MerchandiseHomeScreen(),
    routes: [
      GoRoute(
        path: 'add',
        builder: (BuildContext context, GoRouterState state) =>
            const AddMerchandiseScreen(),
      ),
    ],
  ),

  GoRoute(
    path: RoutesConstants.ownerEmployeesRoute,
    builder: (BuildContext context, GoRouterState state) =>
        const OwnerEmployees(),
  ),

  GoRoute(
    path: RoutesConstants.ownerProductsRoute,
    builder: (BuildContext context, GoRouterState state) =>
        const OwnerProducts(),
    routes: [
      GoRoute(
        path: 'add',
        builder: (BuildContext context, GoRouterState state) {
          final extra = state.extra as Map<String, dynamic>?;
          return OwnerAddProducts(
            isEdit: extra?['isEdit'] ?? false,
            product: extra?['product'],
          );
        },
      ),
      GoRoute(
        path: 'add-category',
        builder: (BuildContext context, GoRouterState state) =>
            const OwnerAddCategory(),
      ),
    ],
  ),

  GoRoute(
    path: RoutesConstants.ownerToolsRoutes,
    builder: (BuildContext context, GoRouterState state) =>
        const ToolsHomeScreen(),
    routes: [
      GoRoute(
        path: 'add',
        builder: (BuildContext context, GoRouterState state) =>
            const AddToolsScreen(),
      ),
    ],
  ),
];
