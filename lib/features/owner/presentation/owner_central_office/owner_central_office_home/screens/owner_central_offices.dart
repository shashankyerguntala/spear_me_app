import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/features/owner/presentation/owner_central_office/owner_central_office_home/widgets/central_office_card.dart';

class OwnerCentralOffices extends StatelessWidget {
  const OwnerCentralOffices({super.key});
  //! Separate tab for merchandise not inside the central office
  //! please make the file for all buttons styles and text styles central file pleaseeeeeee
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Central Offices'), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: 'Search by central office ',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 12),

            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.filter_list),
              label: const Text('Filter'),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView(
                children: const <Widget>[
                  CentralOfficeCard(
                    name: 'Central Office 1',
                    location: 'HADAPSAR PUNE',
                    isActive: true,
                  ),
                  CentralOfficeCard(
                    name: 'Central Office 2',
                    location: 'HADAPSAR PUNE',
                    isActive: true,
                  ),
                  CentralOfficeCard(
                    name: 'Central Office 3',
                    location: 'HADAPSAR PUNE',
                    isActive: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),
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
          'Add central office',
          style: TextStyle(
            color: ColorConstants.cardBg,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
