import 'package:flutter/material.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/features/owner/domain/entity/central_officer_entity.dart';
import 'package:spear_me_app/features/owner/presentation/owner_central_office/owner_central_office_home/widgets/owner_modal_sheet.dart';

class OwnerEmployeesCard extends StatelessWidget {
  final OfficerEntity employee;

  const OwnerEmployeesCard({required this.employee, super.key});

  @override
  Widget build(BuildContext context) {
    final imageUrl = StringConstants.defaultProfileImage;
    final department = StringConstants.delivery;

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
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(imageUrl)),
              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee.username,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      employee.role,
                      style: const TextStyle(
                        fontSize: 14,
                        color: ColorConstants.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      department,
                      style: const TextStyle(
                        fontSize: 12,
                        color: ColorConstants.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right,
                color: ColorConstants.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
