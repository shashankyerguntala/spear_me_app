import 'package:flutter/material.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';

class RoleDropdown extends StatelessWidget {
  final String selectedRole;
  final ValueChanged<String?> onRoleChanged;

  const RoleDropdown({
    required this.selectedRole,
    required this.onRoleChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const roles = ["CHIEF_SUPERVISOR", "WORKER"];

    return DropdownButtonFormField<String>(
      value: selectedRole,
      items: roles
          .map(
            (e) =>
                DropdownMenuItem(value: e, child: Text(e.replaceAll("_", " "))),
          )
          .toList(),
      onChanged: onRoleChanged,
      decoration: InputDecoration(
        labelText: "Role",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      dropdownColor: ColorConstants.cardBg,
    );
  }
}
