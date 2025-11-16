import 'package:flutter/material.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/features/owner/domain/entity/central_officer_entity.dart';
import 'package:spear_me_app/features/owner/presentation/owner_central_office/owner_central_office_home/widgets/detail_item.dart';

class EmployeeDetailsModal extends StatelessWidget {
  final OfficerEntity employee;

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
                  backgroundImage: NetworkImage(
                    StringConstants.defaultProfileImage,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  employee.username,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                Text(
                  employee.role,
                  style: const TextStyle(
                    fontSize: 18,
                    color: ColorConstants.primaryDark,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 32),

                DetailItem(
                  icon: Icons.badge,
                  label: StringConstants.employeeId,
                  value: employee.id.toString(),
                ),

                DetailItem(
                  icon: Icons.business_center,
                  label: StringConstants.department,
                  value: StringConstants.delivery,
                ),

                DetailItem(
                  icon: Icons.email,
                  label: StringConstants.emailLabel,
                  value: employee.email,
                ),

                DetailItem(
                  icon: Icons.phone,
                  label: StringConstants.phoneNumber,
                  value: StringConstants.defaultPhoneNumber,
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
