import 'dart:io';

import 'package:flutter/material.dart';
import 'package:spear_me_app/features/owner/presentation/owner_merchandise/add_merchandise/widgets/merchandise_placeholder.dart';

class MerchandiseImagePreview extends StatelessWidget {
  final File? selectedImage;
  final String? existingImage;

  const MerchandiseImagePreview({
    required this.selectedImage,
    required this.existingImage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.file(selectedImage!, fit: BoxFit.cover),
      );
    }

    if (existingImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          existingImage!,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => MerchandisePlaceholder(),
        ),
      );
    }
    return const MerchandisePlaceholder();
  }
}
