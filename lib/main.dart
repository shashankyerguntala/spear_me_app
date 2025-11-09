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
        appBarTheme: AppBarTheme(color: ColorConstants.scaffoldBg),
        scaffoldBackgroundColor: ColorConstants.scaffoldBg,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
    );
  }
}
