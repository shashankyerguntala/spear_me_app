import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/core/routes/routes.dart';

void main() async {
  Di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Routes.router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.poppins().fontFamily,
        scaffoldBackgroundColor: ColorConstants.scaffoldBg,
        primaryColor: ColorConstants.primary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorConstants.primary,
          primary: ColorConstants.primary,
          secondary: ColorConstants.secondary,
          surface: ColorConstants.surface,
          error: ColorConstants.error,
          onPrimary: ColorConstants.textOnPrimary,
          onSurface: ColorConstants.textPrimary,
        ),
        appBarTheme: const AppBarTheme(
          color: ColorConstants.primary,
          foregroundColor: ColorConstants.textOnPrimary,
          elevation: 0,
          centerTitle: true,
        ),
        textTheme: GoogleFonts.poppinsTextTheme().apply(
          bodyColor: ColorConstants.textPrimary,
          displayColor: ColorConstants.textPrimary,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: ColorConstants.primaryLight,
        ),
      ),
    );
  }
}
