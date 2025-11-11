import 'package:flutter/material.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/features/plant_head/domain/entity/staff_entity.dart';
import 'package:spear_me_app/features/plant_head/presentation/pl_employees/widgets/pl_employee_details_sheet.dart';

class PlEmployeeCard extends StatelessWidget {
  final StaffEntity employee;

  const PlEmployeeCard({required this.employee, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => PlEmployeeDetailsSheet(employee: employee),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ColorConstants.cardBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: ColorConstants.primary.withAlpha(20),
              child: employee.img!.isEmpty
                  ? Text(
                      employee.name.isNotEmpty
                          ? employee.name[0].toUpperCase()
                          : "?",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.primary,
                      ),
                    )
                  : Image.network(employee.img!),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    employee.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    employee.email,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  Text("Role: ${employee.role}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
