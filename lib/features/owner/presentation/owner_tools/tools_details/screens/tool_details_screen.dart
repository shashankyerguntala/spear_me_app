import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:dartz/dartz.dart' hide State;
import 'package:spear_me_app/features/authentication/data/model/roles_enum.dart';
import 'package:spear_me_app/features/owner/domain/entity/tools_entity.dart';
import 'package:spear_me_app/features/owner/domain/usecase/tools_usecase.dart';

class ToolDetailsScreen extends StatefulWidget {
  final ToolEntity tool;
  final RolesEnum role;

  const ToolDetailsScreen({required this.tool, required this.role, super.key});

  @override
  State<ToolDetailsScreen> createState() => _ToolDetailsScreenState();
}

class _ToolDetailsScreenState extends State<ToolDetailsScreen> {
  XFile? selectedImage;
  bool isUploading = false;

  bool get isOwner => widget.role == RolesEnum.owner;

  Future<void> pickImage() async {
    if (!isOwner) {
      return;
    }

    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);

    if (img != null) {
      setState(() => selectedImage = img);
    }
  }

  Future<void> submitImage() async {
    if (!isOwner) {
      return;
    }
    if (selectedImage == null) {
      return;
    }

    setState(() => isUploading = true);

    final usecase = di<ToolUsecase>();

    final Either<Failure, String> result = await usecase.updateToolImage(
      toolId: widget.tool.id,
      imagePath: selectedImage!.path,
    );

    setState(() => isUploading = false);

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.message),
            backgroundColor: ColorConstants.error,
          ),
        );
      },
      (successMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(successMessage),
            backgroundColor: ColorConstants.success,
          ),
        );

        setState(() {
          widget.tool.copyWith(image: selectedImage!.path);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tool = widget.tool;

    final isPerishable = tool.type?.toUpperCase() == "PERISHABLE";
    final isExpensive = tool.isExpensive?.toUpperCase() == "YES";

    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBg,

      appBar: AppBar(
        backgroundColor: ColorConstants.scaffoldBg,
        elevation: 0,
        centerTitle: true,
        title: Text(
          tool.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorConstants.textPrimary,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                _buildImageBlock(),

                if (isOwner)
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: pickImage,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: ColorConstants.primary,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstants.primaryDark.withAlpha(30),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 16),

            if (isOwner && selectedImage != null)
              Center(
                child: ElevatedButton(
                  onPressed: isUploading ? null : submitImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 14,
                    ),
                  ),
                  child: isUploading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          "Upload Image",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),

            const SizedBox(height: 26),

            _buildDetailsCard(tool, isPerishable, isExpensive),
          ],
        ),
      ),
    );
  }

  Widget _buildImageBlock() {
    final tool = widget.tool;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 240,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorConstants.primaryLight.withAlpha(10),
              ColorConstants.primary.withAlpha(5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: selectedImage != null
            ? Image.file(File(selectedImage!.path), fit: BoxFit.cover)
            : (tool.image != null && tool.image!.isNotEmpty)
            ? Image.network(
                tool.image!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _placeholder(),
              )
            : _placeholder(),
      ),
    );
  }

  Widget _buildDetailsCard(
    ToolEntity tool,
    bool isPerishable,
    bool isExpensive,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: ColorConstants.cardBg,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.shadow,
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _detailSection("Tool ID", tool.id.toString()),
          _detailSection("Name", tool.name),
          _detailSection("Category", tool.categoryName ?? "Uncategorized"),
          _detailSection("Threshold", tool.threshold?.toString() ?? "N/A"),

          const SizedBox(height: 14),

          Row(
            children: [
              _badge(
                label: isPerishable ? "Perishable" : "Non-Perishable",
                color: isPerishable
                    ? ColorConstants.secondary
                    : ColorConstants.primary,
              ),
              const SizedBox(width: 10),

              if (isExpensive) _premiumBadge("Expensive"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailSection(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              color: ColorConstants.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: ColorConstants.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _badge({required String label, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _premiumBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstants.secondaryLight.withAlpha(40),
        border: Border.all(color: ColorConstants.secondary, width: 1.4),
      ),
      child: Row(
        children: [
          Icon(Icons.star_rounded, size: 15, color: ColorConstants.secondary),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: ColorConstants.secondary,
              fontWeight: FontWeight.w800,
              fontSize: 13,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() {
    return const Center(
      child: Icon(
        Icons.home_repair_service_rounded,
        size: 70,
        color: ColorConstants.greyText,
      ),
    );
  }
}
