import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductsGridShimmer extends StatelessWidget {
  const ProductsGridShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 8,
      padding: const EdgeInsets.all(0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (_, __) => const _ProductTileShimmer(),
    );
  }
}

class _SkelBox extends StatelessWidget {
  const _SkelBox({required this.height, this.width, this.radius = 10});

  final double height;
  final double? width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}

class _ProductTileShimmer extends StatelessWidget {
  const _ProductTileShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _SkelBox(height: 130, width: double.infinity, radius: 0),

          SizedBox(height: 12),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: _SkelBox(height: 14, width: 140),
          ),
          SizedBox(height: 8),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: _SkelBox(height: 12, width: 100),
          ),
          SizedBox(height: 12),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                _SkelBox(height: 22, width: 68, radius: 16),
                SizedBox(width: 8),
                _SkelBox(height: 22, width: 48, radius: 16),
              ],
            ),
          ),

          Spacer(),

          Padding(
            padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Row(
              children: [
                _SkelBox(height: 16, width: 70),
                Spacer(),
                _SkelBox(height: 36, width: 36),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
