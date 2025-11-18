import 'package:flutter/material.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';

class MerchandisePlaceholder extends StatelessWidget {
  const MerchandisePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.image_outlined,
            size: 50,
            color: ColorConstants.textSecondary,
          ),
          const SizedBox(height: 8),
          const Text(
            StringConstants.tapToUploadImage,
            style: TextStyle(color: ColorConstants.textSecondary),
          ),
        ],
      ),
    );
  }
}
