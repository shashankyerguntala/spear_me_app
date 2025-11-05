import 'package:flutter/material.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';

class StatCard extends StatelessWidget {
  final String label;
  const StatCard({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: BoxBorder.all(color: ColorConstants.border),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        spacing: 16,
        children: <Widget>[
          Text(label, style: TextStyle(fontSize: 16)),

          Text(
            '1,2345',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorConstants.success,
            ),
          ),
        ],
      ),
    );
  }
}
