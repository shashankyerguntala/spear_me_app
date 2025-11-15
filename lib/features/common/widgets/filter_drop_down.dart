import 'package:flutter/material.dart';
import 'package:spear_me_app/features/common/widgets/filter_option.dart';

class FilterDropdown extends StatelessWidget {
  final String selectedValue;
  final ValueChanged<String> onChanged;
  final List<FilterOption> options;
  final String? hint;
  final double? width;
  final Color? backgroundColor;

  const FilterDropdown({
    required this.selectedValue,
    required this.onChanged,
    required this.options,
    this.hint,
    this.width,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue.isEmpty ? options.first.value : selectedValue,
          icon: const Icon(Icons.arrow_drop_down, size: 24),
          borderRadius: BorderRadius.circular(12),
          hint: hint != null ? Text(hint!) : null,
          items: options.map((option) {
            final isSelected = selectedValue == option.value;
            return DropdownMenuItem<String>(
              value: option.value,
              child: Row(
                children: [
                  if (option.icon != null) ...[
                    Icon(
                      option.icon,
                      size: 20,
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.grey[600],
                    ),
                    const SizedBox(width: 12),
                  ],
                  Text(
                    option.label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.black87,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) => onChanged(value ?? ''),
        ),
      ),
    );
  }
}
