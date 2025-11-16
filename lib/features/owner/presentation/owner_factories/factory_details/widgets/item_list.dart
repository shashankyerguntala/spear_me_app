import 'package:flutter/material.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';

class ItemList extends StatelessWidget {
  final List items;
  final bool isProduct;

  const ItemList({required this.items, this.isProduct = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) {
        final title = isProduct
            ? (item.productName ?? StringConstants.unknownProduct)
            : (item.toolName ?? StringConstants.unknownTool);

        final value = isProduct
            ? "${StringConstants.produced}${item.producedQuantity ?? 0}"
            : "${StringConstants.available}${item.availableQuantity ?? 0}";

        final valueColor = isProduct
            ? ColorConstants.accent
            : ColorConstants.primaryLight;

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ColorConstants.scaffoldBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: ColorConstants.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: valueColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
