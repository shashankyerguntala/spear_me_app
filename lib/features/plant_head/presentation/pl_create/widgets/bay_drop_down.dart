import 'package:flutter/material.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';

class BayDropdown extends StatelessWidget {
  final List<Map<String, dynamic>> bays;
  final int? selectedBayId;
  final ValueChanged<int?> onChanged;

  const BayDropdown({
    required this.bays, required this.selectedBayId, required this.onChanged, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      initialValue: selectedBayId,
      items: bays.map<DropdownMenuItem<int>>((b) {
        return DropdownMenuItem<int>(
          value: b["id"] as int,
          child: Text(b["name"] as String),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: "Allocate Bay",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      dropdownColor: ColorConstants.cardBg,
    );
  }
}
