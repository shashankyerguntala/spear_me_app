import 'package:flutter/material.dart';
import 'package:spear_me_app/features/owner/presentation/owner_central_office/owner_central_office_home/widgets/stat_info.dart';

class OfficeLocationCard extends StatelessWidget {
  final String officeName;
  final String location;
  final String address;
  final int employeeCount;

  const OfficeLocationCard({
    required this.officeName,
    required this.location,
    required this.address,
    required this.employeeCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.blue.shade500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withAlpha(30),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.business, color: Colors.white, size: 32),
              const SizedBox(width: 12),
              Text(
                officeName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          InfoRow(icon: Icons.location_on, text: location),
          const SizedBox(height: 8),
          InfoRow(icon: Icons.people, text: '$employeeCount Employees'),
        ],
      ),
    );
  }
}
