// features/plant_head/presentation/bloc/request_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spear_me_app/features/plant_head/domain/entity/tool_request_entity.dart';
import 'package:spear_me_app/features/plant_head/domain/usecases/tool_request_usecase.dart';

part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  final RequestUseCase useCase;

  RequestBloc(this.useCase) : super(const RequestState()) {
    on<FetchToolRequests>(_onFetchToolRequests);
    on<FetchRestockRequests>(_onFetchRestockRequests);
    on<SearchToolRequests>(
      _onSearchToolRequests,
      transformer: _debounce(const Duration(milliseconds: 500)),
    );
    on<SearchRestockRequests>(
      _onSearchRestockRequests,
      transformer: _debounce(const Duration(milliseconds: 500)),
    );
    on<FilterToolRequests>(_onFilterToolRequests);
    on<FilterRestockRequests>(_onFilterRestockRequests);
    on<SortToolRequests>(_onSortToolRequests);
    on<SortRestockRequests>(_onSortRestockRequests);
    on<LoadMoreToolRequests>(
      _onLoadMoreToolRequests,
      transformer: _throttle(const Duration(seconds: 2)),
    );
    on<LoadMoreRestockRequests>(
      _onLoadMoreRestockRequests,
      transformer: _throttle(const Duration(seconds: 2)),
    );
    on<ApproveToolRequest>(_onApproveToolRequest);
    on<RejectToolRequest>(_onRejectToolRequest);
    on<CompleteRestockRequest>(_onCompleteRestockRequest);
  }

  Future<void> _onFetchToolRequests(
    FetchToolRequests event,
    Emitter<RequestState> emit,
  ) async {
    emit(state.copyWith(isLoadingToolRequests: true, toolPage: 0));

    final result = await useCase.getToolRequests(
      searchWorker: state.searchToolQuery?.isEmpty == true
          ? null
          : state.searchToolQuery,
      status: state.toolStatusFilter,
      page: 0,
      size: state.pageSize,
      sortBy: state.toolSortBy,
      sortDir: state.toolSortDir,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoadingToolRequests: false,
          errorMessage: failure.message,
        ),
      ),
      (requests) => emit(
        state.copyWith(
          isLoadingToolRequests: false,
          toolRequests: requests,
          toolPage: 0,
          toolLastPage: requests.length < state.pageSize,
        ),
      ),
    );
  }

  Future<void> _onFetchRestockRequests(
    FetchRestockRequests event,
    Emitter<RequestState> emit,
  ) async {
    emit(state.copyWith(isLoadingRestockRequests: true, restockPage: 0));

    final result = await useCase.getRestockRequests(
      searchProduct: state.searchRestockQuery?.isEmpty == true
          ? null
          : state.searchRestockQuery,
      status: state.restockStatusFilter,
      page: 0,
      size: state.pageSize,
      sortBy: state.restockSortBy,
      sortDir: state.restockSortDir,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoadingRestockRequests: false,
          errorMessage: failure.message,
        ),
      ),
      (requests) => emit(
        state.copyWith(
          isLoadingRestockRequests: false,
          restockRequests: requests,
          restockPage: 0,
          restockLastPage: requests.length < state.pageSize,
        ),
      ),
    );
  }

  Future<void> _onSearchToolRequests(
    SearchToolRequests event,
    Emitter<RequestState> emit,
  ) async {
    emit(state.copyWith(searchToolQuery: event.query));
    add(const FetchToolRequests());
  }

  Future<void> _onSearchRestockRequests(
    SearchRestockRequests event,
    Emitter<RequestState> emit,
  ) async {
    emit(state.copyWith(searchRestockQuery: event.query));
    add(const FetchRestockRequests());
  }

  Future<void> _onFilterToolRequests(
    FilterToolRequests event,
    Emitter<RequestState> emit,
  ) async {
    emit(state.copyWith(toolStatusFilter: event.status));
    add(const FetchToolRequests());
  }

  Future<void> _onFilterRestockRequests(
    FilterRestockRequests event,
    Emitter<RequestState> emit,
  ) async {
    emit(state.copyWith(restockStatusFilter: event.status));
    add(const FetchRestockRequests());
  }

  Future<void> _onSortToolRequests(
    SortToolRequests event,
    Emitter<RequestState> emit,
  ) async {
    emit(state.copyWith(toolSortBy: event.sortBy, toolSortDir: event.sortDir));
    add(const FetchToolRequests());
  }

  Future<void> _onSortRestockRequests(
    SortRestockRequests event,
    Emitter<RequestState> emit,
  ) async {
    emit(
      state.copyWith(
        restockSortBy: event.sortBy,
        restockSortDir: event.sortDir,
      ),
    );
    add(const FetchRestockRequests());
  }

  Future<void> _onLoadMoreToolRequests(
    LoadMoreToolRequests event,
    Emitter<RequestState> emit,
  ) async {
    if (state.toolLastPage ||
        state.isLoadingMoreTool ||
        state.isLoadingToolRequests) {
      return;
    }

    emit(state.copyWith(isLoadingMoreTool: true));

    final nextPage = state.toolPage + 1;

    final result = await useCase.getToolRequests(
      searchWorker: state.searchToolQuery?.isEmpty == true
          ? null
          : state.searchToolQuery,
      status: state.toolStatusFilter,
      page: nextPage,
      size: state.pageSize,
      sortBy: state.toolSortBy,
      sortDir: state.toolSortDir,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(isLoadingMoreTool: false, errorMessage: failure.message),
      ),
      (requests) => emit(
        state.copyWith(
          isLoadingMoreTool: false,
          toolRequests: [...state.toolRequests, ...requests],
          toolPage: nextPage,
          toolLastPage: requests.length < state.pageSize,
        ),
      ),
    );
  }

  Future<void> _onLoadMoreRestockRequests(
    LoadMoreRestockRequests event,
    Emitter<RequestState> emit,
  ) async {
    if (state.restockLastPage ||
        state.isLoadingMoreRestock ||
        state.isLoadingRestockRequests) {
      return;
    }

    emit(state.copyWith(isLoadingMoreRestock: true));

    final nextPage = state.restockPage + 1;

    final result = await useCase.getRestockRequests(
      searchProduct: state.searchRestockQuery?.isEmpty == true
          ? null
          : state.searchRestockQuery,
      status: state.restockStatusFilter,
      page: nextPage,
      size: state.pageSize,
      sortBy: state.restockSortBy,
      sortDir: state.restockSortDir,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoadingMoreRestock: false,
          errorMessage: failure.message,
        ),
      ),
      (requests) => emit(
        state.copyWith(
          isLoadingMoreRestock: false,
          restockRequests: [...state.restockRequests, ...requests],
          restockPage: nextPage,
          restockLastPage: requests.length < state.pageSize,
        ),
      ),
    );
  }

  Future<void> _onApproveToolRequest(
    ApproveToolRequest event,
    Emitter<RequestState> emit,
  ) async {
    final result = await useCase.approveToolRequest(requestId: event.requestId);

    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (_) {
        final updatedRequests = state.toolRequests
            .where((req) => req.requestId != event.requestId)
            .toList();
        emit(state.copyWith(toolRequests: updatedRequests));
      },
    );
  }

  Future<void> _onRejectToolRequest(
    RejectToolRequest event,
    Emitter<RequestState> emit,
  ) async {
    final result = await useCase.rejectToolRequest(
      requestId: event.requestId,
      reason: event.reason,
    );

    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (_) {
        final updatedRequests = state.toolRequests
            .where((req) => req.requestId != event.requestId)
            .toList();
        emit(state.copyWith(toolRequests: updatedRequests));
      },
    );
  }

  Future<void> _onCompleteRestockRequest(
    CompleteRestockRequest event,
    Emitter<RequestState> emit,
  ) async {
    final result = await useCase.completeRestockRequest(
      requestId: event.requestId,
    );

    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (updatedRequest) {
        final updatedRequests = state.restockRequests.map((req) {
          if (req.id == event.requestId) {
            return updatedRequest;
          }
          return req;
        }).toList();
        emit(state.copyWith(restockRequests: updatedRequests));
      },
    );
  }

  EventTransformer<E> _debounce<E>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
  }

  EventTransformer<E> _throttle<E>(Duration duration) {
    return (events, mapper) => events.throttleTime(duration).switchMap(mapper);
  }
}
