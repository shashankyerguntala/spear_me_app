import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/features/owner/presentation/owner_employees/bloc/owner_employees_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_employees/screens/owner_employees_shimmer.dart';

class OwnerEmployees extends StatelessWidget {
  const OwnerEmployees({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          OwnerEmployeesBloc(usecase: di())..add(const FetchEmployees()),
      child: const _OwnerEmployeesBody(),
    );
  }
}

class _OwnerEmployeesBody extends StatefulWidget {
  const _OwnerEmployeesBody();

  @override
  State<_OwnerEmployeesBody> createState() => _OwnerEmployeesBodyState();
}

class _OwnerEmployeesBodyState extends State<_OwnerEmployeesBody> {
  final TextEditingController searchController = TextEditingController();
  String selectedRole = "";
  final int factoryId = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Employees")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: (value) {
                context.read<OwnerEmployeesBloc>().add(
                  FetchEmployees(
                    search: value.trim(),
                    role: selectedRole.isEmpty ? null : selectedRole,
                    factoryId: factoryId,
                  ),
                );
              },
              decoration: InputDecoration(
                hintText: 'Search employees...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                const Text("Filter by Role: "),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: selectedRole.isEmpty ? null : selectedRole,
                  hint: const Text("All Roles"),
                  items: const [
                    DropdownMenuItem(value: "", child: Text("All Roles")),
                    DropdownMenuItem(
                      value: "PLANT_HEAD",
                      child: Text("Plant Head"),
                    ),
                    DropdownMenuItem(
                      value: "DISTRIBUTOR",
                      child: Text("Distributor"),
                    ),
                    DropdownMenuItem(
                      value: "CENTRAL_OFFICE",
                      child: Text("Central Office"),
                    ),
                    DropdownMenuItem(value: "OWNER", child: Text("Owner")),
                  ],
                  onChanged: (value) {
                    setState(() => selectedRole = value ?? "");
                    context.read<OwnerEmployeesBloc>().add(
                      FetchEmployees(
                        search: searchController.text.trim(),
                        role: selectedRole.isEmpty ? null : selectedRole,
                        factoryId: factoryId,
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            Expanded(
              child: BlocBuilder<OwnerEmployeesBloc, OwnerEmployeesState>(
                builder: (context, state) {
                  if (state is OwnerEmployeesLoading) {
                    return const OwnerEmployeesShimmer();
                  }

                  if (state is OwnerEmployeesFailure) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (state is OwnerEmployeesLoaded) {
                    final employees = state.employees;

                    if (employees.isEmpty) {
                      return const Center(child: Text("No Employees Found"));
                    }

                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: employees.length,
                            itemBuilder: (_, i) {
                              final emp = employees[i];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.grey.shade300,
                                    child: Text(
                                      emp.username.isNotEmpty
                                          ? emp.username[0].toUpperCase()
                                          : "U",
                                    ),
                                  ),
                                  title: Text(emp.username),
                                  subtitle: Text(emp.email),
                                  trailing: Text(emp.role),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
