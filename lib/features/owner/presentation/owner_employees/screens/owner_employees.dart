import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spear_me_app/core/constants/string_constants/string_constants.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/core/helper_functions.dart';
import 'package:spear_me_app/features/common/widgets/confirmation_dialogue.dart';
import 'package:spear_me_app/features/common/widgets/filter_sort_section.dart';
import 'package:spear_me_app/features/owner/data/data_sources/local_data_source/roles_list_employees.dart';
import 'package:spear_me_app/features/owner/data/data_sources/local_data_source/sort_options_employees.dart';
import 'package:spear_me_app/features/owner/presentation/owner_employees/bloc/owner_employees_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_employees/widgets/employee_card.dart';
import 'package:spear_me_app/features/common/widgets/search_field_widget.dart';
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
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<OwnerEmployeesBloc>().add(const LoadMoreEmployees());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) {
      return false;
    }
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConstants.employees),
        elevation: 0,
      ),
      body: BlocConsumer<OwnerEmployeesBloc, OwnerEmployeesState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            HelperFunctions.showSnackBar(
              context,
              message: state.errorMessage!,
              isError: true,
            );
          }
          if (state.successMessage != null) {
            HelperFunctions.showSnackBar(
              context,
              message: state.successMessage!,
              isError: false,
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Column(
                  children: [
                    SearchField(
                      controller: _searchController,
                      onChanged: (value) {
                        context.read<OwnerEmployeesBloc>().add(
                          UpdateSearchQuery(query: value),
                        );
                      },
                      onClear: () {
                        _searchController.clear();
                        context.read<OwnerEmployeesBloc>().add(
                          const UpdateSearchQuery(query: ''),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    FilterSortSection(
                      selectedFilterValue: state.selectedRole,
                      selectedSortValue: state.sortBy,
                      filterOptions: roleOptions,
                      sortOptions: sortOptions,
                      onFilterChanged: (role) {
                        context.read<OwnerEmployeesBloc>().add(
                          UpdateRoleFilter(role: role),
                        );
                      },
                      onSortChanged: (sort) {
                        context.read<OwnerEmployeesBloc>().add(
                          SortEmployees(sortBy: sort, ascending: true),
                        );
                      },
                      filterLabel: StringConstants.filterByRole,
                      sortLabel: StringConstants.sortBy,
                    ),
                  ],
                ),
              ),
              Expanded(child: _buildEmployeeList(context, state)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmployeeList(BuildContext context, OwnerEmployeesState state) {
    if (state.isLoading && state.employees.isEmpty || state.isFiringEmployee) {
      return const OwnerEmployeesShimmer();
    }

    if (state.employees.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_search, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No Employees Found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your search or filters',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () async {
            context.read<OwnerEmployeesBloc>().add(const FetchEmployees());
          },
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            itemCount: state.employees.length + (state.hasMoreData ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= state.employees.length) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              final employee = state.employees[index];
              return EmployeeCard(
                employee: employee,
                onFireEmployee: () => ConfirmationDialog.show(
                  context: context,
                  title: StringConstants.removeEmployee,
                  message: StringConstants.removeEmployeeMsg(employee.username),
                  confirmText: StringConstants.remove,
                  confirmColor: Colors.red,
                  icon: Icons.warning_amber_rounded,
                  iconColor: Colors.red,
                  onConfirm: () {
                    context.read<OwnerEmployeesBloc>().add(
                      FireEmployee(employee.id),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
