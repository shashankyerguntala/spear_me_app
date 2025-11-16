import 'package:flutter/material.dart';
import 'package:spear_me_app/features/common/widgets/filter_option.dart';

const locations = [
  "Pune",
  "Mumbai",
  "Hyderabad",
  "Delhi",
  "Bangalore",
  "Surat",
  "Chennai",
  "Nagpur",
  "Ahmedabad",
];

final cityOptions = [
  const FilterOption(value: '', label: 'All Cities', icon: Icons.location_city),
  ...locations.map(
    (c) => FilterOption(value: c, label: c, icon: Icons.location_on),
  ),
];
