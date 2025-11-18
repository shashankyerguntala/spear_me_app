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
  late final ScrollController scrollController;

  bool canLoadMore = true;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(onScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void onScroll() {
    if (!scrollController.hasClients) {
      return;
    }

    final maxScroll = scrollController.position.maxScrollExtent;
    final current = scrollController.position.pixels;

    if (current >= maxScroll - 100) {
      final bloc = context.read<PlEmployeesBloc>();
      final state = bloc.state;

      if (!state.lastPage && !state.isLoadingMore && canLoadMore) {
        canLoadMore = false;
        bloc.add(const LoadMoreEmployees());

        Future.delayed(const Duration(seconds: 2), () {
          canLoadMore = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlEmployeesBloc, PlEmployeesState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          HelperFunctions.showSnackBar(
            context,
            message: state.errorMessage!,
            isError: true,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorConstants.surface,

          // TODO(Shashank): Extract string constants and make sure appropriate textstyle is provided as per UI design
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

                SingleChildScrollView(
                  child: Row(
                    children: [
                      _filterChip(context, state, "ALL"),
                      const SizedBox(width: 8),
                      _filterChip(context, state, "WORKER"),
                      const SizedBox(width: 8),
                      _filterChip(context, state, "CHIEF_SUPERVISOR"),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                Expanded(
                  child: state.isLoading && state.employees.isEmpty
                      ? OwnerEmployeesShimmer()
                      : state.employees.isEmpty
                      ? const Center(child: Text("No employees found"))
                      : ListView.separated(
                          controller: scrollController,
                          itemCount:
                              state.employees.length +
                              (state.isLoadingMore ? 1 : 0),
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (_, index) {
                            if (index == state.employees.length &&
                                state.isLoadingMore) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Center(
                                  child: SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                              );
                            }

                            final emp = state.employees[index];
                            return PlEmployeeCard(employee: emp);
                          },
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
      label: Text(
        role,
        style: TextStyle(
          color: isSelected ? Colors.white : ColorConstants.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
      selected: isSelected,
      onSelected: (_) {
        context.read<PlEmployeesBloc>().add(SelectRole(role));
      },

      selectedColor: ColorConstants.primary,
      backgroundColor: ColorConstants.cardBg,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      side: BorderSide(
        color: isSelected
            ? ColorConstants.primary
            : ColorConstants.textSecondary.withAlpha(120),
      ),
    );
  }
}
