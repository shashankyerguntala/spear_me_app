import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/features/common/widgets/confirmation_dialogue.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/factory_details/bloc/factory_details_bloc.dart';

class FactorBottomBar extends StatelessWidget {
  final int factoryId;

  const FactorBottomBar({required this.factoryId, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            offset: const Offset(0, -2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              icon: const Icon(Icons.edit_outlined),
              label: const Text("Edit"),
              onPressed: () {
                context.push(
                  RoutesConstants.ownerAddFactoriesRoute,
                  extra: {'isEdit': true, 'factory': factory},
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.delete_outline),
              label: const Text("Delete"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                ConfirmationDialog.show(
                  context: context,
                  title: "Delete Factory?",
                  message:
                      "This action will mark the factory as INACTIVE.\nAre you sure?",
                  confirmText: "Delete",
                  confirmColor: Colors.red,
                  icon: Icons.warning_amber_rounded,
                  iconColor: Colors.red,
                  onConfirm: () {
                    context.read<FactoryDetailsBloc>().add(
                      DeleteFactoryEvent(factId: factoryId),
                    );
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
