import 'package:flutter/material.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/features/authentication/data/model/roles_enum.dart';
import 'package:spear_me_app/features/owner/domain/entity/tools_entity.dart';

class ToolCard extends StatelessWidget {
  final ToolEntity tool;
  final RolesEnum role;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ToolCard({
    required this.tool,
    required this.role,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  bool get isOwner => role == RolesEnum.owner;

  @override
  Widget build(BuildContext context) {
    final isPerishable = tool.type?.toUpperCase() == "PERISHABLE";
    final isExpensive = tool.isExpensive?.toUpperCase() == "YES";

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstants.cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: ColorConstants.border.withAlpha(60),
            width: 1.1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0x1A000000),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1.2,
                    child: tool.image?.isNotEmpty == true
                        ? Image.network(tool.image!)
                        : _placeholder(),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tool.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: ColorConstants.textPrimary,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        tool.categoryName ?? "Uncategorized",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          color: ColorConstants.textSecondary,
                        ),
                      ),

                      const SizedBox(height: 8),

                      _badge(
                        label: isPerishable ? "Perishable" : "Non-Perishable",
                        color: isPerishable
                            ? ColorConstants.secondary
                            : ColorConstants.primary,
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Available: ${tool.threshold ?? 0}",
                        style: const TextStyle(
                          fontSize: 13,
                          color: ColorConstants.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            if (isExpensive)
              Positioned(top: 10, left: 10, child: _premiumBadge("Expensive")),

            if (isOwner)
              Positioned(
                top: 10,
                right: 10,
                child: Row(
                  children: [
                    _actionIcon(
                      Icons.edit_rounded,
                      ColorConstants.primary,
                      onEdit,
                    ),
                    const SizedBox(width: 8),
                    _actionIcon(
                      Icons.delete_rounded,
                      Colors.redAccent,
                      onDelete,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: Colors.grey.shade200,
      child: const Center(
        child: Icon(
          Icons.home_repair_service_rounded,
          size: 44,
          color: ColorConstants.greyText,
        ),
      ),
    );
  }

  Widget _badge({required String label, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _premiumBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFFFF7D1),
        border: Border.all(color: const Color(0xFFF3C748), width: 1.2),
      ),
      child: Row(
        children: [
          const Icon(Icons.star_rounded, size: 14, color: Color(0xFFB8860B)),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFB8860B),
              fontWeight: FontWeight.w800,
              fontSize: 12,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionIcon(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: color.withAlpha(15),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}
