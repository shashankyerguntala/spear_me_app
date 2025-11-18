import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/features/common/widgets/confirmation_dialogue.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/factory_details/bloc/factory_details_bloc.dart';

class FactoryBottomBar extends StatelessWidget {
  final int factoryId;

  const FactoryBottomBar({required this.factoryId, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: ColorConstants.surface,
        boxShadow: const [
          BoxShadow(
            color: ColorConstants.shadow,
            offset: Offset(0, -2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.delete_outline),
              label: const Text(StringConstants.delete),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.error,
                foregroundColor: ColorConstants.textOnPrimary,
              ),
              onPressed: () {
                ConfirmationDialog.show(
                  context: context,
                  title: StringConstants.deleteFactoryTitle,
                  message: StringConstants.deleteFactoryMessage,
                  confirmText: StringConstants.delete,
                  confirmColor: ColorConstants.error,
                  icon: Icons.warning_amber_rounded,
                  iconColor: ColorConstants.error,
                  onConfirm: () {
                    context.read<FactoryDetailsBloc>().add(
                      DeleteFactoryEvent(factId: factoryId),
                    );
                    context.pop();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
