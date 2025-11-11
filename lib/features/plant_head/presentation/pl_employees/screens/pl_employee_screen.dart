import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spear_me_app/core/constants/color_constants.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/core/helper_functions.dart';
import 'package:spear_me_app/features/owner/presentation/owner_employees/screens/owner_employees_shimmer.dart';
import 'package:spear_me_app/features/plant_head/presentation/pl_employees/bloc/pl_employees_bloc.dart';
import 'package:spear_me_app/features/plant_head/presentation/pl_employees/widgets/pl_employee_card.dart';

class PlEmployeeScreen extends StatelessWidget {
  const PlEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<PlEmployeesBloc>()..add(const FetchEmployees()),
      child: const _PlEmployeeBody(),
    );
  }
}

class _PlEmployeeBody extends StatefulWidget {
  const _PlEmployeeBody();

  @override
  State<_PlEmployeeBody> createState() => _PlEmployeeBodyState();
}

class _PlEmployeeBodyState extends State<_PlEmployeeBody> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlEmployeesBloc, PlEmployeesState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          HelperFunctions.showSnackBar(context, message: state.errorMessage!);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorConstants.surface,
          appBar: AppBar(title: const Text("Employees"), centerTitle: true),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  onChanged: (value) => context.read<PlEmployeesBloc>().add(
                    SearchEmployees(value),
                  ),
                  decoration: InputDecoration(
                    hintText: "Search by name or email",
                    suffixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    _filterChip(context, state, "ALL"),
                    const SizedBox(width: 8),
                    _filterChip(context, state, "WORKER"),
                    const SizedBox(width: 8),
                    _filterChip(context, state, "CHIEF_SUPERVISOR"),
                  ],
                ),
                const SizedBox(height: 16),

                Expanded(
                  child: state.isLoading && state.employees.isEmpty
                      ? OwnerEmployeesShimmer()
                      : state.employees.isEmpty
                      ? const Center(child: Text("No employees found"))
                      : ListView.separated(
                          itemCount: state.employees.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (_, index) {
                            final emp = state.employees[index];
                            return PlEmployeeCard(employee: emp);
                          },
                        ),
                ),

                if (!state.lastPage)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.isLoadingMore
                          ? null
                          : () => context.read<PlEmployeesBloc>().add(
                              const LoadMoreEmployees(),
                            ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.primary,
                      ),
                      child: state.isLoadingMore
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text("Load More"),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _filterChip(
    BuildContext context,
    PlEmployeesState state,
    String role,
  ) {
    final isSelected = state.roleFilter == role;

    return ChoiceChip(
      label: Text(role),
      selected: isSelected,
      onSelected: (_) {
        context.read<PlEmployeesBloc>().add(SelectRole(role));
      },
      selectedColor: ColorConstants.primary,
    );
  }
}
