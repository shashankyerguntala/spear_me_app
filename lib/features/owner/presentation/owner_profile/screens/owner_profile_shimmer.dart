import 'package:flutter/material.dart';
import 'package:spear_me_app/features/common/widgets/shimmer_card.dart';

class OwnerProfileShimmer extends StatelessWidget {
  const OwnerProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          ShimmerCard(width: 120, height: 120, shape: BoxShape.circle),

          const SizedBox(height: 25),

          ShimmerCard(width: 160, height: 22, radius: 6),

          const SizedBox(height: 10),

          ShimmerCard(width: 110, height: 18, radius: 6),

          const SizedBox(height: 30),

          ShimmerCard(width: double.infinity, height: 120, radius: 12),
        ],
      ),
    );
  }
}
