import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/features/owner/presentation/owner_central_office/add_central_office/screens/add_central_officer.dart';
import 'package:spear_me_app/features/owner/presentation/owner_central_office/owner_central_office_home/screens/owner_central_offices.dart';
import 'package:spear_me_app/features/owner/presentation/owner_dashboard/screens/owner_dashboard.dart';
import 'package:spear_me_app/features/owner/presentation/owner_employees/screens/owner_employees.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/add_factory/screen/add_factory_screen.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/create_plant_head/screens/create_plant_head.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/factory_home/screens/owner_factories.dart';
import 'package:spear_me_app/features/owner/presentation/owner_products/screens/owner_products.dart';
import 'package:spear_me_app/features/owner/presentation/owner_profile/screens/owner_profile_screen.dart';

final GlobalKey<NavigatorState> ownerKey = GlobalKey<NavigatorState>();
final List<GoRoute> ownerRoutes = <GoRoute>[
  GoRoute(
    path: RoutesConstants.ownerHomeRoute,
    builder: (BuildContext context, GoRouterState state) => OwnerDashboard(),
  ),
  GoRoute(
    path: RoutesConstants.ownerFactoriesRoute,
    builder: (BuildContext context, GoRouterState state) => OwnerFactories(),
  ),
  GoRoute(
    path: RoutesConstants.ownerCentralOfficesRoute,
    builder: (BuildContext context, GoRouterState state) =>
        CentralOfficeScreen(),
  ),
  GoRoute(
    path: RoutesConstants.ownerProductsRoute,
    builder: (BuildContext context, GoRouterState state) => OwnerProducts(),
  ),
  GoRoute(
    path: RoutesConstants.ownerEmployeesRoute,
    builder: (BuildContext context, GoRouterState state) => OwnerEmployees(),
  ),
  GoRoute(
    path: RoutesConstants.ownerAddProductsRoute,
    builder: (BuildContext context, GoRouterState state) => AddFactoryScreen(),
  ),
  GoRoute(
    path: RoutesConstants.ownerAddCentralOfficeRoute,
    builder: (BuildContext context, GoRouterState state) => AddCentralOffice(),
  ),
  GoRoute(
    path: RoutesConstants.ownerProfileRoute,
    builder: (BuildContext context, GoRouterState state) =>
        OwnerProfileScreen(),
  ),
  GoRoute(
    path: RoutesConstants.createPlantHead,
    builder: (BuildContext context, GoRouterState state) =>
        CreatePlantHeadScreen(),
  ),
];
