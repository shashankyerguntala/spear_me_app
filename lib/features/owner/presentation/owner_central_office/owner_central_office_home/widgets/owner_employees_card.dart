// Reusable Widget: Employee Card
import 'package:flutter/material.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/features/owner/presentation/owner_central_office/owner_central_office_home/widgets/owner_modal_sheet.dart';

class OwnerEmployeesCard extends StatelessWidget {
  final Map<String, String> employee;

  const OwnerEmployeesCard({required this.employee, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorConstants.scaffoldBg,
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => EmployeeDetailsModal(employee: employee),
        ),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(employee['imageUrl']!),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee['name']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      employee['position']!,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      employee['department']!,
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}
