import 'package:flutter/material.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';

class FactoryCard extends StatelessWidget {
  final String name;
  final String location;
  final bool isActive;

  const FactoryCard({
    required this.name,
    required this.location,
    required this.isActive,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorConstants.border),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorConstants.primaryLight.withAlpha(30),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.factory, color: ColorConstants.primary),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(location, style: TextStyle(color: ColorConstants.primary)),
              ],
            ),
          ),
          Icon(Icons.arrow_forward),
        ],
      ),
    );
  }
}
