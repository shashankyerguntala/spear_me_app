import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/features/owner/presentation/owner_central_office/owner_central_office_home/widgets/employees_list.dart';
import 'package:spear_me_app/features/owner/presentation/owner_central_office/owner_central_office_home/widgets/office_loaction_card.dart';

class CentralOfficeScreen extends StatelessWidget {
  const CentralOfficeScreen({super.key});
  static const String officeName = 'Central Office';
  static const String officeLocation = 'New York, NY';
  static const String officeAddress =
      '123 Business Avenue, Manhattan, NY 10001';
  static const List<Map<String, String>> employees = [
    {
      'id': '1',
      'name': 'Sarah Johnson',
      'position': 'CEO',
      'department': 'Executive',
      'email': 'sarah.johnson@company.com',
      'phone': '+1 (555) 123-4567',
      'imageUrl': 'https://i.pravatar.cc/150?img=1',
    },
    {
      'id': '2',
      'name': 'Michael Chen',
      'position': 'CTO',
      'department': 'Technology',
      'email': 'michael.chen@company.com',
      'phone': '+1 (555) 234-5678',
      'imageUrl': 'https://i.pravatar.cc/150?img=12',
    },
    {
      'id': '3',
      'name': 'Emily Rodriguez',
      'position': 'HR Manager',
      'department': 'Human Resources',
      'email': 'emily.rodriguez@company.com',
      'phone': '+1 (555) 345-6789',
      'imageUrl': 'https://i.pravatar.cc/150?img=5',
    },
    {
      'id': '4',
      'name': 'David Kim',
      'position': 'Senior Developer',
      'department': 'Technology',
      'email': 'david.kim@company.com',
      'phone': '+1 (555) 456-7890',
      'imageUrl': 'https://i.pravatar.cc/150?img=14',
    },
    {
      'id': '5',
      'name': 'Lisa Anderson',
      'position': 'Marketing Director',
      'department': 'Marketing',
      'email': 'lisa.anderson@company.com',
      'phone': '+1 (555) 567-8901',
      'imageUrl': 'https://i.pravatar.cc/150?img=9',
    },
    {
      'id': '6',
      'name': 'James Wilson',
      'position': 'Finance Manager',
      'department': 'Finance',
      'email': 'james.wilson@company.com',
      'phone': '+1 (555) 678-9012',
      'imageUrl': 'https://i.pravatar.cc/150?img=15',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.surface,
      appBar: AppBar(title: const Text('Central Office'), elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OfficeLocationCard(
              officeName: officeName,
              location: officeLocation,
              address: officeAddress,
              employeeCount: employees.length,
            ),
            const SizedBox(height: 16),
            EmployeeListSection(employees: employees),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        splashColor: ColorConstants.primaryLight,
        hoverColor: ColorConstants.owner,
        backgroundColor: ColorConstants.owner,
        onPressed: () {
          context.push(RoutesConstants.ownerAddCentralOfficeRoute);
        },
        label: Text(
          StringConstants.addCentralOfficer,
          style: TextStyle(
            color: ColorConstants.cardBg,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
