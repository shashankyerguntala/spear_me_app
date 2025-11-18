import 'package:flutter/material.dart';
import 'package:spear_me_app/features/common/widgets/shimmer_card.dart';

// TODO(Shashank): move it to widgets folder
class MerchandiseGridShimmer extends StatelessWidget {
  const MerchandiseGridShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.78,
      ),
      itemBuilder: (_, __) => ShimmerCard(width: 100, height: 100),
    );
  }
}
