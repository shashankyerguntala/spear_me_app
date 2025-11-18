import 'package:flutter/material.dart';
import 'package:spear_me_app/core/theme/app_theme.dart';
import 'package:spear_me_app/core/routes/routes.dart';
import 'package:spear_me_app/core/di/di.dart';

void main() async {
  await Di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Routes.router,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
    );
  }
}
