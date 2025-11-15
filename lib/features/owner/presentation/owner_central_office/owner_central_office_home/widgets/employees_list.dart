// Reusable Widget: Employee List Section
import 'package:flutter/material.dart';
import 'package:spear_me_app/features/owner/presentation/owner_central_office/owner_central_office_home/widgets/owner_employees_card.dart';

class EmployeeListSection extends StatelessWidget {
  final List<Map<String, String>> employees;

  const EmployeeListSection({required this.employees, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Employees',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: employees.length,
            itemBuilder: (context, index) {
              return OwnerEmployeesCard(employee: employees[index]);
            },
          ),
        ],
      ),
    );
  }
}
