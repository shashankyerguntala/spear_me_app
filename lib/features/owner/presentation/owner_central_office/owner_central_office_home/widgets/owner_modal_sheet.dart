import 'package:flutter/material.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/features/owner/presentation/owner_central_office/owner_central_office_home/widgets/detail_item.dart';

class EmployeeDetailsModal extends StatelessWidget {
  final Map<String, String> employee;

  const EmployeeDetailsModal({required this.employee, super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: ColorConstants.scaffoldBg,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: ColorConstants.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(employee['imageUrl']!),
                ),
                const SizedBox(height: 20),
                Text(
                  employee['name']!,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  employee['position']!,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                DetailItem(
                  icon: Icons.badge,
                  label: 'Employee ID',
                  value: employee['id']!,
                ),
                DetailItem(
                  icon: Icons.business_center,
                  label: 'Department',
                  value: employee['department']!,
                ),
                DetailItem(
                  icon: Icons.email,
                  label: 'Email',
                  value: employee['email']!,
                ),
                DetailItem(
                  icon: Icons.phone,
                  label: 'Phone',
                  value: employee['phone']!,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}
