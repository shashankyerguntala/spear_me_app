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
      create: (_) => di<PlCreateBloc>(),
      child: const _PlCreateBody(),
    );
  }
}

class _PlCreateBody extends StatefulWidget {
  const _PlCreateBody();

  @override
  State<_PlCreateBody> createState() => _PlCreateBodyState();
}

class _PlCreateBodyState extends State<_PlCreateBody> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final bayNameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    bayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlCreateBloc, PlCreateState>(
      listener: (context, state) {
        if (state is PlCreateFailure) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }

        if (state is PlCreateSuccess) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );

          nameController.clear();
          emailController.clear();
        }
      },
      builder: (context, state) {
        if (state is! PlCreateDataState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final data = state;

        return Scaffold(
          backgroundColor: ColorConstants.surface,
          appBar: AppBar(
            title: const Text("Create Staff"),
            elevation: 0,
            centerTitle: true,
          ),
          body: data.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
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
                        selectedRole: data.selectedRole,
                        onRoleChanged: (role) {
                          if (role != null) {
                            context.read<PlCreateBloc>().add(
                              PlSelectRole(role),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      if (data.selectedRole.toUpperCase() == "WORKER") ...[
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<int>(
                                value: data.selectedBayId,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  labelText: "Select Bay",
                                ),
                                hint: const Text("Select a bay"),
                                items: data.bays.map((bay) {
                                  return DropdownMenuItem(
                                    value: bay.id,
                                    child: Text(bay.bayName),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  if (val != null) {
                                    context.read<PlCreateBloc>().add(
                                      PlSelectBay(val),
                                    );
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () =>
                                  _showAddBaySheet(context, bayNameController),
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: ColorConstants.primary,
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
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
                                role: data.selectedRole,
                                bayId:
                                    data.selectedRole.toUpperCase() == "WORKER"
                                    ? data.selectedBayId
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
      builder: (sheetContext) => Padding(
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
              "Add New Bay",
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
                  final bayName = bayNameController.text.trim();
                  if (bayName.isNotEmpty) {
                    context.read<PlCreateBloc>().add(
                      PlCreateBay(bayName: bayName),
                    );
                    bayNameController.clear();
                    Navigator.pop(sheetContext);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.primary,
                ),
                child: const Text(
                  "Create Bay",
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
