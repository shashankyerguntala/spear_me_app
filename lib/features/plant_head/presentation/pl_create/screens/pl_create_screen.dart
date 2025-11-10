import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/features/authentication/presentation/sign_in/widgets/custom_textfield.dart';
import 'package:spear_me_app/features/plant_head/presentation/pl_create/bloc/pl_create_bloc.dart';
import 'package:spear_me_app/features/plant_head/presentation/pl_create/widgets/role_drop_down.dart';

class PlCreateScreen extends StatelessWidget {
  const PlCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<PlCreateBloc>()..add(PlFetchBays()),
      child: const _PlCreateBody(),
    );
  }
}

class _PlCreateBody extends StatelessWidget {
  const _PlCreateBody();

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final bayNameController = TextEditingController();

    return BlocConsumer<PlCreateBloc, PlCreateState>(
      listener: (context, state) {
        if (state is PlCreateFailure) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state is PlCreateSuccess) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(SnackBar(content: Text(state.msg)));
        }
      },
      builder: (context, state) {
        if (state is PlCreateLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is! PlCreateLoaded) {
          return const SizedBox.shrink();
        }

        return Scaffold(
          backgroundColor: ColorConstants.surface,
          appBar: AppBar(
            title: const Text("Create Staff"),
            elevation: 0,
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CustomTextField(
                  controller: nameController,
                  label: "Name",
                  validatorMsg: "Name cannot be empty",
                  isNumber: false,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  controller: emailController,
                  label: "Email",
                  keyboardType: TextInputType.emailAddress,
                  validatorMsg: "Email cannot be empty",
                  isNumber: false,
                ),
                const SizedBox(height: 16),

                RoleDropdown(
                  selectedRole: state.selectedRole,
                  onRoleChanged: (role) {
                    context.read<PlCreateBloc>().add(PlSelectRole(role!));
                  },
                ),
                const SizedBox(height: 16),

                if (state.selectedRole == "WORKER") ...[
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          value: state.selectedBayId,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            labelText: "Select Bay",
                          ),
                          items: state.bays.map((bay) {
                            return DropdownMenuItem(
                              value: bay.id,
                              child: Text(bay.bayName),
                            );
                          }).toList(),
                          onChanged: (val) => context.read<PlCreateBloc>().add(
                            PlSelectBay(val!),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () =>
                            _showAddBaySheet(context, bayNameController),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: ColorConstants.primary,
                          child: const Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      context.read<PlCreateBloc>().add(
                        PlCreateStaff(
                          name: nameController.text.trim(),
                          email: emailController.text.trim(),
                          role: state.selectedRole,
                          bayId: state.selectedRole == "WORKER"
                              ? state.selectedBayId
                              : null,
                        ),
                      );
                    },
                    child: const Text(
                      "Create",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddBaySheet(
    BuildContext context,
    TextEditingController bayNameController,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Add Bay",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 20),

            CustomTextField(
              controller: bayNameController,
              label: "Bay Name",
              validatorMsg: "Cannot be empty",
              isNumber: false,
            ),
            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.read<PlCreateBloc>().add(
                    PlCreateBay(2, bayNameController.text.trim()),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.primary,
                ),
                child: const Text(
                  "Create",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
