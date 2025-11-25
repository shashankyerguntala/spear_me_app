import 'package:flutter/material.dart';

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
    return DropdownButtonFormField<String>(
      initialValue: selectedRole,
      items: const [
        DropdownMenuItem(
          value: "CHIEF_SUPERVISOR",
          child: Text("Chief Supervisor"),
        ),
        DropdownMenuItem(value: "WORKER", child: Text("Worker")),
      ],
      onChanged: (val) => onRoleChanged(val?.toUpperCase()),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        labelText: "Select Role",
      ),
    );
  }
}
