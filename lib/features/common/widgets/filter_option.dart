import 'package:flutter/material.dart';

class FilterOption {
  final String value;
  final String label;
  final IconData? icon;

  const FilterOption({
    required this.value,
    required this.label,
    this.icon,
  });
}
