import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/features/owner/domain/entity/factory_entity.dart';

class FactoryCard extends StatelessWidget {
  final FactoryEntity factoryEntity;

  const FactoryCard({required this.factoryEntity, super.key});

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
                  factoryEntity.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  factoryEntity.city,
                  style: TextStyle(color: ColorConstants.primary),
                ),
              ],
            ),
          ),

          IconButton(
            icon: const Icon(
              Icons.edit_outlined,
              color: ColorConstants.primary,
            ),
            onPressed: () {
              context.push(
                '${RoutesConstants.ownerFactoriesRoute}/${RoutesConstants.ownerAddFactoriesRoute}',
                extra: {'isEdit': true, 'factory': factoryEntity},
              );
            },
          ),

          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, size: 18),
            onPressed: () {
              context.push(
                '${RoutesConstants.ownerFactoriesRoute}/details/${factoryEntity.factoryId}',
              );
            },
          ),
        ],
      ),
    );
  }
}
