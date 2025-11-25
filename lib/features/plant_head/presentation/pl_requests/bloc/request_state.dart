part of 'request_bloc.dart';

class RequestState extends Equatable {
  final List<ToolRequestEntity> toolRequests;
  final List<RestockRequestEntity> restockRequests;
  final bool isLoadingToolRequests;
  final bool isLoadingRestockRequests;
  final bool isLoadingMoreTool;
  final bool isLoadingMoreRestock;
  final String? errorMessage;
  final String? searchToolQuery;
  final String? searchRestockQuery;
  final String? toolStatusFilter;
  final String? restockStatusFilter;
  final String toolSortBy;
  final String toolSortDir;
  final String restockSortBy;
  final String restockSortDir;
  final int toolPage;
  final int restockPage;
  final int pageSize;
  final bool toolLastPage;
  final bool restockLastPage;

  const RequestState({
    this.toolRequests = const [],
    this.restockRequests = const [],
    this.isLoadingToolRequests = false,
    this.isLoadingRestockRequests = false,
    this.isLoadingMoreTool = false,
    this.isLoadingMoreRestock = false,
    this.errorMessage,
    this.searchToolQuery,
    this.searchRestockQuery,
    this.toolStatusFilter,
    this.restockStatusFilter,
    this.toolSortBy = 'createdAt',
    this.toolSortDir = 'desc',
    this.restockSortBy = 'requestedAt',
    this.restockSortDir = 'desc',
    this.toolPage = 0,
    this.restockPage = 0,
    this.pageSize = 10,
    this.toolLastPage = false,
    this.restockLastPage = false,
  });

  RequestState copyWith({
    List<ToolRequestEntity>? toolRequests,
    List<RestockRequestEntity>? restockRequests,
    bool? isLoadingToolRequests,
    bool? isLoadingRestockRequests,
    bool? isLoadingMoreTool,
    bool? isLoadingMoreRestock,
    String? errorMessage,
    String? searchToolQuery,
    String? searchRestockQuery,
    String? toolStatusFilter,
    String? restockStatusFilter,
    String? toolSortBy,
    String? toolSortDir,
    String? restockSortBy,
    String? restockSortDir,
    int? toolPage,
    int? restockPage,
    int? pageSize,
    bool? toolLastPage,
    bool? restockLastPage,
  }) {
    return RequestState(
      toolRequests: toolRequests ?? this.toolRequests,
      restockRequests: restockRequests ?? this.restockRequests,
      isLoadingToolRequests:
          isLoadingToolRequests ?? this.isLoadingToolRequests,
      isLoadingRestockRequests:
          isLoadingRestockRequests ?? this.isLoadingRestockRequests,
      isLoadingMoreTool: isLoadingMoreTool ?? this.isLoadingMoreTool,
      isLoadingMoreRestock: isLoadingMoreRestock ?? this.isLoadingMoreRestock,
      errorMessage: errorMessage,
      searchToolQuery: searchToolQuery ?? this.searchToolQuery,
      searchRestockQuery: searchRestockQuery ?? this.searchRestockQuery,
      toolStatusFilter: toolStatusFilter ?? this.toolStatusFilter,
      restockStatusFilter: restockStatusFilter ?? this.restockStatusFilter,
      toolSortBy: toolSortBy ?? this.toolSortBy,
      toolSortDir: toolSortDir ?? this.toolSortDir,
      restockSortBy: restockSortBy ?? this.restockSortBy,
      restockSortDir: restockSortDir ?? this.restockSortDir,
      toolPage: toolPage ?? this.toolPage,
      restockPage: restockPage ?? this.restockPage,
      pageSize: pageSize ?? this.pageSize,
      toolLastPage: toolLastPage ?? this.toolLastPage,
      restockLastPage: restockLastPage ?? this.restockLastPage,
    );
  }

  @override
  List<Object?> get props => [
    toolRequests,
    restockRequests,
    isLoadingToolRequests,
    isLoadingRestockRequests,
    isLoadingMoreTool,
    isLoadingMoreRestock,
    errorMessage,
    searchToolQuery,
    searchRestockQuery,
    toolStatusFilter,
    restockStatusFilter,
    toolSortBy,
    toolSortDir,
    restockSortBy,
    restockSortDir,
    toolPage,
    restockPage,
    pageSize,
    toolLastPage,
    restockLastPage,
  ];
}
