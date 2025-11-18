import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/features/owner/presentation/owner_merchandise/add_merchandise/widgets/merchandise_image_preview.dart';

class MerchandiseImagePicker extends StatefulWidget {
  final File? initialFile;
  final String? existingUrl;
  final ValueChanged<File?> onPicked;

  const MerchandiseImagePicker({
    required this.initialFile,
    required this.existingUrl,
    required this.onPicked,
    super.key,
  });

  @override
  State<MerchandiseImagePicker> createState() => _MerchandiseImagePickerState();
}

class _MerchandiseImagePickerState extends State<MerchandiseImagePicker> {
  File? image;

  @override
  void initState() {
    super.initState();
    image = widget.initialFile;
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );

    if (file == null) {
      return;
    }

    final f = File(file.path);

    final sizeInKB = (await f.length()) / 1024;
    if (sizeInKB > 100) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Image must be smaller than 100 KB"),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    setState(() => image = f);
    widget.onPicked(f);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickImage,
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ColorConstants.border),
          color: Colors.white,
        ),
        child: MerchandiseImagePreview(
          selectedImage: image,
          existingImage: widget.existingUrl,
        ),
      ),
    );
  }
}
