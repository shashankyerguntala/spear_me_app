import 'package:flutter/material.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/features/owner/data/data_sources/local_data_source/city_list_factory.dart';

class CityDropdown extends StatefulWidget {
  final String? initialCity;
  final ValueChanged<String> onCityChanged;

  const CityDropdown({
    required this.initialCity,
    required this.onCityChanged,
    super.key,
  });

  @override
  State<CityDropdown> createState() => _CityDropdownState();
}

class _CityDropdownState extends State<CityDropdown> {
  String? selected;

  @override
  void initState() {
    super.initState();
    selected = widget.initialCity;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selected,
      dropdownColor: ColorConstants.cardBg,
      items: locations
          .map((city) => DropdownMenuItem(value: city, child: Text(city)))
          .toList(),
      onChanged: (value) {
        setState(() => selected = value);
        if (value != null) {
          widget.onCityChanged(value);
        }
      },
      decoration: InputDecoration(
        labelText: StringConstants.city,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      validator: (value) => value == null ? StringConstants.cityRequired : null,
    );
  }
}
