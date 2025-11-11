import 'package:flutter/material.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/features/owner/presentation/owner_central_office/owner_central_office_home/widgets/detail_item.dart';
import 'package:spear_me_app/features/plant_head/domain/entity/staff_entity.dart';

class PlEmployeeDetailsSheet extends StatelessWidget {
  final StaffEntity employee;

  const PlEmployeeDetailsSheet({required this.employee, super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.78,
      minChildSize: 0.55,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: ColorConstants.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListView(
            controller: scrollController,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: ColorConstants.primary.withAlpha(20),
                  backgroundImage:
                      (employee.img != null && employee.img!.isNotEmpty)
                      ? NetworkImage(employee.img!)
                      : null,
                  child: (employee.img == null || employee.img!.isEmpty)
                      ? Text(
                          employee.name.isNotEmpty
                              ? employee.name[0].toUpperCase()
                              : "?",
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.primary,
                          ),
                        )
                      : null,
                ),
              ),

              const SizedBox(height: 18),

              Center(
                child: Text(
                  employee.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(height: 6),

              Center(
                child: Text(
                  employee.role,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),

              const SizedBox(height: 28),

              DetailItem(
                icon: Icons.badge,
                label: "Employee ID",
                value: employee.id.toString(),
              ),
              DetailItem(
                icon: Icons.email_outlined,
                label: "Email",
                value: employee.email,
              ),
              DetailItem(
                icon: Icons.location_city,
                label: "Factory",
                value: employee.factoryName,
              ),
              if (employee.bayName != null &&
                  employee.bayName!.trim().isNotEmpty)
                DetailItem(
                  icon: Icons.account_tree_outlined,
                  label: "Bay Assigned",
                  value: employee.bayName!,
                ),
            ],
          ),
        );
      },
    );
  }
}
