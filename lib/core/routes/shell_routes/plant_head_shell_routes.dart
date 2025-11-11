import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/features/plant_head/presentation/pl_create/screens/pl_create_screen.dart';
import 'package:spear_me_app/features/plant_head/presentation/pl_dashboard/screens/pl_dashboard_screen.dart';
import 'package:spear_me_app/features/plant_head/presentation/pl_employees/screens/pl_employee_screen.dart';
import 'package:spear_me_app/features/plant_head/presentation/pl_profile/screens/pl_profile_screen.dart';
import 'package:spear_me_app/features/plant_head/presentation/pl_requests/screens/pl_requests_screen.dart';
import 'package:spear_me_app/features/plant_head/presentation/pl_tools/screens/pl_tools_screen.dart';

final GlobalKey<NavigatorState> plantHeadKey = GlobalKey<NavigatorState>();
final List<GoRoute> plantHeadRoutes = <GoRoute>[
  GoRoute(
    path: RoutesConstants.plantHeadHomeRoute,
    builder: (BuildContext context, GoRouterState state) => PlDashboardScreen(),
  ),
  GoRoute(
    path: RoutesConstants.plantHeadCreateRoute,
    builder: (BuildContext context, GoRouterState state) => PlCreateScreen(),
  ),
  GoRoute(
    path: RoutesConstants.plantHeadProfileRoute,
    builder: (BuildContext context, GoRouterState state) => PlProfileScreen(),
  ),
  GoRoute(
    path: RoutesConstants.plantHeadRequestsRoute,
    builder: (BuildContext context, GoRouterState state) => PlRequestsScreen(),
  ),
  GoRoute(
    path: RoutesConstants.plantHeadToolsRoute,
    builder: (BuildContext context, GoRouterState state) => PlToolsScreen(),
  ),
  GoRoute(
    path: RoutesConstants.plantHeadEmployeesRoute,
    builder: (BuildContext context, GoRouterState state) => PlEmployeeScreen(),
  ),
];
