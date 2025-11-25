// features/plant_head/presentation/pages/requests_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spear_me_app/core/di/di.dart';
import 'package:spear_me_app/features/common/widgets/filter_option.dart';
import 'package:spear_me_app/features/common/widgets/filter_sort_section.dart';
import 'package:spear_me_app/features/plant_head/presentation/pl_requests/bloc/request_bloc.dart';
import 'package:spear_me_app/features/plant_head/presentation/pl_requests/screens/restock_request_card.dart';
import 'package:spear_me_app/features/plant_head/presentation/pl_requests/screens/request_card.dart';

class RequestsScreen extends StatelessWidget {
  const RequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<RequestBloc>()
        ..add(const FetchToolRequests())
        ..add(const FetchRestockRequests()),
      child: const _RequestsScreenView(),
    );
  }
}

class _RequestsScreenView extends StatefulWidget {
  const _RequestsScreenView();

  @override
  State<_RequestsScreenView> createState() => _RequestsScreenViewState();
}

class _RequestsScreenViewState extends State<_RequestsScreenView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _toolSearchController;
  late TextEditingController _restockSearchController;
  late ScrollController _toolScrollController;
  late ScrollController _restockScrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _toolSearchController = TextEditingController();
    _restockSearchController = TextEditingController();
    _toolScrollController = ScrollController();
    _restockScrollController = ScrollController();

    _toolScrollController.addListener(_onToolScroll);
    _restockScrollController.addListener(_onRestockScroll);
  }

  void _onToolScroll() {
    if (_toolScrollController.position.pixels >=
        _toolScrollController.position.maxScrollExtent * 0.9) {
      context.read<RequestBloc>().add(const LoadMoreToolRequests());
    }
  }

  void _onRestockScroll() {
    if (_restockScrollController.position.pixels >=
        _restockScrollController.position.maxScrollExtent * 0.9) {
      context.read<RequestBloc>().add(const LoadMoreRestockRequests());
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _toolSearchController.dispose();
    _restockSearchController.dispose();
    _toolScrollController.dispose();
    _restockScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Requests'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'In-house Requests'),
            Tab(text: 'CO Requests'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildToolRequestsTab(), _buildRestockRequestsTab()],
      ),
    );
  }

  Widget _buildToolRequestsTab() {
    return BlocConsumer<RequestBloc, RequestState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                spacing: 16,
                children: [
                  TextField(
                    controller: _toolSearchController,
                    decoration: InputDecoration(
                      labelText: 'Search by worker name',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onChanged: (value) {
                      context.read<RequestBloc>().add(
                        SearchToolRequests(value),
                      );
                    },
                  ),
                  FilterSortSection(
                    selectedFilterValue: state.toolStatusFilter ?? 'ALL',
                    selectedSortValue:
                        '${state.toolSortBy}_${state.toolSortDir}',
                    filterOptions: const [
                      FilterOption(value: 'ALL', label: 'All Status'),
                      FilterOption(value: 'PENDING', label: 'Pending'),
                      FilterOption(value: 'APPROVED', label: 'Approved'),
                      FilterOption(value: 'REJECTED', label: 'Rejected'),
                    ],
                    sortOptions: const [
                      FilterOption(
                        value: 'createdAt_desc',
                        label: 'Newest First',
                      ),
                      FilterOption(
                        value: 'createdAt_asc',
                        label: 'Oldest First',
                      ),
                      FilterOption(
                        value: 'workerName_asc',
                        label: 'Worker Name (A-Z)',
                      ),
                      FilterOption(
                        value: 'workerName_desc',
                        label: 'Worker Name (Z-A)',
                      ),
                    ],
                    onFilterChanged: (value) {
                      context.read<RequestBloc>().add(
                        FilterToolRequests(value == 'ALL' ? null : value),
                      );
                    },
                    onSortChanged: (value) {
                      final parts = value.split('_');
                      context.read<RequestBloc>().add(
                        SortToolRequests(sortBy: parts[0], sortDir: parts[1]),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: state.isLoadingToolRequests
                  ? const Center(child: CircularProgressIndicator())
                  : state.toolRequests.isEmpty
                  ? const Center(child: Text('No requests found'))
                  : ListView.builder(
                      controller: _toolScrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount:
                          state.toolRequests.length +
                          (state.isLoadingMoreTool ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == state.toolRequests.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return ToolRequestCard(
                          request: state.toolRequests[index],
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRestockRequestsTab() {
    return BlocConsumer<RequestBloc, RequestState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                spacing: 16,
                children: [
                  TextField(
                    controller: _restockSearchController,
                    decoration: InputDecoration(
                      labelText: 'Search by product name',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onChanged: (value) {
                      context.read<RequestBloc>().add(
                        SearchRestockRequests(value),
                      );
                    },
                  ),
                  FilterSortSection(
                    selectedFilterValue: state.restockStatusFilter ?? 'ALL',
                    selectedSortValue:
                        '${state.restockSortBy}_${state.restockSortDir}',
                    filterOptions: const [
                      FilterOption(value: 'ALL', label: 'All Status'),
                      FilterOption(value: 'PENDING', label: 'Pending'),
                      FilterOption(value: 'APPROVED', label: 'Approved'),
                      FilterOption(value: 'COMPLETED', label: 'Completed'),
                    ],
                    sortOptions: const [
                      FilterOption(
                        value: 'requestedAt_desc',
                        label: 'Newest First',
                      ),
                      FilterOption(
                        value: 'requestedAt_asc',
                        label: 'Oldest First',
                      ),
                      FilterOption(
                        value: 'productName_asc',
                        label: 'Product Name (A-Z)',
                      ),
                      FilterOption(
                        value: 'productName_desc',
                        label: 'Product Name (Z-A)',
                      ),
                      FilterOption(
                        value: 'qtyRequested_desc',
                        label: 'Quantity (High-Low)',
                      ),
                      FilterOption(
                        value: 'qtyRequested_asc',
                        label: 'Quantity (Low-High)',
                      ),
                    ],
                    onFilterChanged: (value) {
                      context.read<RequestBloc>().add(
                        FilterRestockRequests(value == 'ALL' ? null : value),
                      );
                    },
                    onSortChanged: (value) {
                      final parts = value.split('_');
                      context.read<RequestBloc>().add(
                        SortRestockRequests(
                          sortBy: parts[0],
                          sortDir: parts[1],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: state.isLoadingRestockRequests
                  ? const Center(child: CircularProgressIndicator())
                  : state.restockRequests.isEmpty
                  ? const Center(child: Text('No requests found'))
                  : ListView.builder(
                      controller: _restockScrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount:
                          state.restockRequests.length +
                          (state.isLoadingMoreRestock ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == state.restockRequests.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return RestockRequestCard(
                          request: state.restockRequests[index],
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
