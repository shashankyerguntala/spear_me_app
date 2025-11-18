import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';

class ShimmerCard extends StatelessWidget {
  final double width;
  final double height;
  final double? radius;
  final BoxShape shape;

  const ShimmerCard({
    required this.width,
    required this.height,
    super.key,
    this.radius,
    this.shape = BoxShape.rectangle,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorConstants.border,
      highlightColor: ColorConstants.scaffoldBg,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: ColorConstants.cardBg,
          shape: shape,
          borderRadius: shape == BoxShape.circle
              ? null
              : BorderRadius.circular(radius ?? 0),
        ),
      ),
    );
  }
}
