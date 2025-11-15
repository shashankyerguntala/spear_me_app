import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spear_me_app/core/constants/string_constants/assets_constants.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Lottie.asset(AssetsConstants.loginLoadingAsset)),
    );
  }
}
