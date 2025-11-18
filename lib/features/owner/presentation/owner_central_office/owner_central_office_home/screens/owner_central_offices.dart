import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/constants/string_constants/routes_constansts.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/features/owner/presentation/owner_central_office/owner_central_office_home/screens/owner_central_office_shimmer.dart';
import 'package:spear_me_app/features/owner/presentation/owner_central_office/owner_central_office_home/widgets/employees_list.dart';
import 'package:spear_me_app/features/owner/presentation/owner_central_office/owner_central_office_home/widgets/office_loaction_card.dart';
import 'package:spear_me_app/features/owner/presentation/owner_central_office/owner_central_office_home/bloc/owner_central_office_home_bloc.dart';
import 'package:spear_me_app/core/di/di.dart';

class CentralOfficeScreen extends StatelessWidget {
  const CentralOfficeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          OwnerCentralOfficeHomeBloc(ownerUsecase: di())
            ..add(FetchCentralOffices()),
      child: const _CentralOfficeBody(),
    );
  }
}

class _CentralOfficeBody extends StatelessWidget {
  const _CentralOfficeBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.surface,

      appBar: AppBar(
        title: const Text(StringConstants.centralOffice),
        elevation: 0,
      ),

      body:
          BlocBuilder<OwnerCentralOfficeHomeBloc, OwnerCentralOfficeHomeState>(
            builder: (context, state) {
              if (state is OwnerCentralOfficeHomeLoading) {
                return OwnerCentralOfficeShimmer();
              }

              if (state is OwnerCentralOfficeHomeFailure) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(
                      color: ColorConstants.error,
                      fontSize: 16,
                    ),
                  ),
                );
              }

              if (state is OwnerCentralOfficeHomeLoaded) {
                if (state.offices.isEmpty) {
                  return const Center(
                    child: Text(StringConstants.noCentralOfficePresent),
                  );
                }

                final office = state.offices.first;
                final employees = office.officers;

                return ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    OfficeLocationCard(
                      officeName: StringConstants.centralOffice,
                      location: office.location,
                      address: StringConstants.unknownAddress,
                      employeeCount: employees.length,
                    ),

                    const SizedBox(height: 16),

                    EmployeeListSection(employees: employees),
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),

      floatingActionButton: FloatingActionButton.extended(
        splashColor: ColorConstants.primaryLight,
        hoverColor: ColorConstants.owner,
        backgroundColor: ColorConstants.owner,
        onPressed: () {
          context.push(
            '${RoutesConstants.ownerCentralOfficesRoute}/${RoutesConstants.ownerAddCentralOfficeRoute}',
          );
        },
        label: const Text(
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
