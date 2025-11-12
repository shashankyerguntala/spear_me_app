import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spear_me_app/features/owner/domain/entity/tools_category_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/tools_entity.dart';
import 'package:spear_me_app/features/owner/domain/usecase/tools_usecase.dart';

part 'tools_event.dart';
part 'tools_state.dart';

class ToolsBloc extends Bloc<ToolsEvent, ToolsState> {
  final ToolUsecase usecase;

  ToolsBloc(this.usecase) : super(const ToolsState()) {
    on<FetchToolCategories>(_onFetchCategories);
    on<FetchTools>(_onFetchTools);
    on<SearchTools>(
      _onSearchTools,
      transformer: _debounce(const Duration(milliseconds: 500)),
    );
    on<SortTools>(_onSortTools);
    on<FilterTools>(_onFilterTools);
    on<LoadMoreTools>(
      _onLoadMoreTools,
      transformer: _throttle(const Duration(seconds: 2)),
    );
  }

  Future<void> _onFetchCategories(
    FetchToolCategories event,
    Emitter<ToolsState> emit,
  ) async {
    emit(state.copyWith(isLoadingCategories: true));

    final result = await usecase.getCategories();

    result.fold(
      (fail) => emit(
        state.copyWith(isLoadingCategories: false, errorMessage: fail.message),
      ),
      (categories) => emit(
        state.copyWith(
          isLoadingCategories: false,
          categories: [
            ToolCategoryEntity(id: 0, name: "All", description: ""),
            ...categories,
          ],
        ),
      ),
    );
  }

  Future<void> _onFetchTools(FetchTools event, Emitter<ToolsState> emit) async {
    emit(state.copyWith(isLoadingTools: true, page: 0));

    final result = await usecase.getAllTools(
      searchName: state.searchKeyword?.isEmpty == true
          ? null
          : state.searchKeyword,
      categoryName: event.categoryName == "All" ? null : event.categoryName,
      type: state.filter,
      size: state.pageSize,
      sortBy: state.sortBy ?? "createdAt",
      sortDir: state.sortDir,
    );

    result.fold(
      (fail) => emit(
        state.copyWith(isLoadingTools: false, errorMessage: fail.message),
      ),
      (tools) => emit(
        state.copyWith(
          isLoadingTools: false,
          tools: tools,
          page: 0,
          lastPage: tools.length < state.pageSize,
        ),
      ),
    );
  }

  Future<void> _onSearchTools(
    SearchTools event,
    Emitter<ToolsState> emit,
  ) async {
    emit(state.copyWith(searchKeyword: event.query));
    add(FetchTools(categoryName: state.selectedCategoryName ?? "All"));
  }

  Future<void> _onSortTools(SortTools event, Emitter<ToolsState> emit) async {
    emit(state.copyWith(sortBy: event.sortBy, sortDir: event.sortDir));
    add(FetchTools(categoryName: state.selectedCategoryName ?? "All"));
  }

  Future<void> _onFilterTools(
    FilterTools event,
    Emitter<ToolsState> emit,
  ) async {
    emit(state.copyWith(filter: event.filter));
    add(FetchTools(categoryName: state.selectedCategoryName ?? "All"));
  }

  Future<void> _onLoadMoreTools(
    LoadMoreTools event,
    Emitter<ToolsState> emit,
  ) async {
    if (state.lastPage || state.isLoadingMore || state.isLoadingTools) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = state.page + 1;

    final result = await usecase.getAllTools(
      searchName: state.searchKeyword?.isEmpty == true
          ? null
          : state.searchKeyword,
      categoryName: state.selectedCategoryName == "All"
          ? null
          : state.selectedCategoryName,
      type: state.filter,
      page: nextPage,
      size: state.pageSize,
      sortBy: state.sortBy ?? "createdAt",
      sortDir: state.sortDir,
    );

    result.fold(
      (fail) => emit(
        state.copyWith(isLoadingMore: false, errorMessage: fail.message),
      ),
      (tools) => emit(
        state.copyWith(
          isLoadingMore: false,
          tools: [...state.tools, ...tools],
          page: nextPage,
          lastPage: tools.length < state.pageSize,
        ),
      ),
    );
  }

  EventTransformer<E> _debounce<E>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
  }

  EventTransformer<E> _throttle<E>(Duration duration) {
    return (events, mapper) => events.throttleTime(duration).switchMap(mapper);
  }
}
