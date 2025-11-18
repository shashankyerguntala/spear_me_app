import 'package:flutter/material.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/features/owner/domain/entity/merchandise_entity.dart';
import 'package:spear_me_app/features/owner/presentation/owner_merchandise/merchandise_home/widgets/action_button.dart';

class MerchandiseCard extends StatelessWidget {
  final MerchandiseEntity merchandise;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const MerchandiseCard({
    required this.merchandise,
    this.onTap,
    this.onEdit,
    this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstants.cardBg,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: ColorConstants.shadow,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.network(
                  merchandise.imageUrl ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: ColorConstants.border,
                    child: const Icon(
                      Icons.image_not_supported,
                      color: ColorConstants.textSecondary,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    merchandise.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: ColorConstants.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${StringConstants.points}${merchandise.requiredPoints}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: ColorConstants.textSecondary,
                        ),
                      ),
                      Text(
                        '${StringConstants.quantity}${merchandise.availableQuantity}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: ColorConstants.textSecondary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Column(
                    spacing: 8,
                    children: [
                      ActionButton(
                        icon: Icons.edit_outlined,
                        label: StringConstants.edit,
                        color: ColorConstants.primary,
                        onPressed: onEdit,
                      ),
                      ActionButton(
                        icon: Icons.delete_outline_rounded,
                        label: StringConstants.delete,
                        color: ColorConstants.error,
                        onPressed: onDelete,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
