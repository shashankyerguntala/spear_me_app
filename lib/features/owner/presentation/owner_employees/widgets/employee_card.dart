import 'package:flutter/material.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/assets_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/core/helper_functions.dart';
import 'package:spear_me_app/features/owner/domain/entity/employee_entity.dart';

class EmployeeCard extends StatelessWidget {
  final EmployeeEntity employee;
  final VoidCallback onFireEmployee;

  const EmployeeCard({
    required this.employee,
    required this.onFireEmployee,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final roleColor = HelperFunctions.getRoleColor(employee.role);

    return Card(
      color: ColorConstants.scaffoldBg,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: roleColor,
              backgroundImage:
                  (employee.img != null && employee.img!.isNotEmpty)
                  ? NetworkImage(employee.img!)
                  : NetworkImage(AssetsConstants.defaultProfileImage),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    employee.username,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    employee.email,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: roleColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: roleColor.withAlpha(30)),
                    ),
                    child: Text(
                      HelperFunctions.formatRole(employee.role),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: roleColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: onFireEmployee,
              icon: const Icon(Icons.person_remove_outlined),
              color: ColorConstants.error,
              tooltip: StringConstants.removeEmployee,
              style: IconButton.styleFrom(
                backgroundColor: ColorConstants.error.withAlpha(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
