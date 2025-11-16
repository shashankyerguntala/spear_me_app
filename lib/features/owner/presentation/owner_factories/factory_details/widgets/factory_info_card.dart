import 'package:flutter/material.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/features/owner/domain/entity/factory_details_entity.dart';

class FactoryInfoCard extends StatelessWidget {
  final FactoryDetailsEntity factory;

  const FactoryInfoCard({required this.factory, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: ColorConstants.shadow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: ColorConstants.surface,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              factory.factoryName ?? StringConstants.unnamedFactory,
              style: const TextStyle(
                color: ColorConstants.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: ColorConstants.primaryLight,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  factory.location ?? StringConstants.unknown,
                  style: const TextStyle(
                    color: ColorConstants.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.people_outline,
                  color: ColorConstants.accent,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  "${StringConstants.totalEmployees}${factory.totalEmployees ?? 0}",
                  style: const TextStyle(
                    color: ColorConstants.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
