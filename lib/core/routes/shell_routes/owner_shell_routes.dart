import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/features/owner/presentation/owner_central_office/screens/owner_central_offices.dart';
import 'package:spear_me_app/features/owner/presentation/owner_dashboard/screens/owner_dashboard.dart';
import 'package:spear_me_app/features/owner/presentation/owner_employees/screens/owner_employees.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/screens/owner_factories.dart';
import 'package:spear_me_app/features/owner/presentation/owner_products/screens/owner_products.dart';

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
        OwnerCentralOffices(),
  ),
  GoRoute(
    path: RoutesConstants.ownerProductsRoute,
    builder: (BuildContext context, GoRouterState state) => OwnerProducts(),
  ),
  GoRoute(
    path: RoutesConstants.ownerEmployeesRoute,
    builder: (BuildContext context, GoRouterState state) => OwnerEmployees(),
  ),
];
