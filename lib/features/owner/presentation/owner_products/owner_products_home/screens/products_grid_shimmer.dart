import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';

class ProductsGridShimmer extends StatelessWidget {
  const ProductsGridShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 8,
      padding: const EdgeInsets.all(0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (_, __) => const ProductTileShimmer(),
    );
  }
}

class SkelBox extends StatelessWidget {
  const SkelBox({
    required this.height,
    this.width,
    this.radius = 10,
    super.key,
  });

  final double height;
  final double? width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorConstants.shimmerBase,
      highlightColor: ColorConstants.shimmerHighlight,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: ColorConstants.shimmerTile,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}

class ProductTileShimmer extends StatelessWidget {
  const ProductTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: ColorConstants.shimmerTile,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.lightShadow,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkelBox(height: 130, width: double.infinity, radius: 0),

          SizedBox(height: 12),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: SkelBox(height: 14, width: 140),
          ),
          SizedBox(height: 8),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: SkelBox(height: 12, width: 100),
          ),
          SizedBox(height: 12),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                SkelBox(height: 22, width: 68, radius: 16),
                SizedBox(width: 8),
                SkelBox(height: 22, width: 48, radius: 16),
              ],
            ),
          ),

          Spacer(),

          Padding(
            padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Row(
              children: [
                SkelBox(height: 16, width: 70),
                Spacer(),
                SkelBox(height: 36, width: 36),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
