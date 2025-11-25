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
    on<FilterByCategory>(_onFilterByCategory);
    on<LoadMoreTools>(
      _onLoadMoreTools,
      transformer: _throttle(const Duration(seconds: 2)),
    );
    on<EditToolEvent>(_onEditTool);
    on<AddCategoryEvent>(_onAddCategory);
    on<UpdateCategoryEvent>(_onUpdateCategory);
    on<DeleteCategoryEvent>(_onDeleteCategory);
  }

  Future<void> _onEditTool(
    EditToolEvent event,
    Emitter<ToolsState> emit,
  ) async {
    emit(state.copyWith(isLoadingTools: true, errorMessage: null));

    final result = await usecase.updateTool(
      toolId: event.tool.id,
      name: event.tool.name,
      categoryId: 0,
      toolType: event.tool.type ?? "",
      isExpensive: event.tool.isExpensive ?? "NO",
      threshold: event.tool.threshold ?? 0,
    );

    result.fold(
      (fail) => emit(
        state.copyWith(isLoadingTools: false, errorMessage: fail.message),
      ),
      (success) {
        final updated = state.tools.map((t) {
          if (t.id == event.tool.id) {
            return event.tool;
          }
          return t;
        }).toList();

        emit(
          state.copyWith(
            isLoadingTools: false,
            tools: updated,
            errorMessage: null,
          ),
        );
      },
    );
  }

  Future<void> _onAddCategory(
    AddCategoryEvent event,
    Emitter<ToolsState> emit,
  ) async {
    emit(
      state.copyWith(
        isAddingCategory: true,
        errorMessage: null,
        successMessage: null,
      ),
    );

    final result = await usecase.addCategory(
      name: event.name,
      description: event.description,
    );

    result.fold(
      (fail) => emit(
        state.copyWith(isAddingCategory: false, errorMessage: fail.message),
      ),
      (success) {
        emit(state.copyWith(isAddingCategory: false, successMessage: success));
        add(FetchToolCategories());
      },
    );
  }

  Future<void> _onUpdateCategory(
    UpdateCategoryEvent event,
    Emitter<ToolsState> emit,
  ) async {
    emit(
      state.copyWith(
        isUpdatingCategory: true,
        errorMessage: null,
        successMessage: null,
      ),
    );

    final result = await usecase.updateCategory(
      id: event.id,
      name: event.name,
      description: event.description,
    );

    result.fold(
      (fail) => emit(
        state.copyWith(isUpdatingCategory: false, errorMessage: fail.message),
      ),
      (success) {
        emit(
          state.copyWith(isUpdatingCategory: false, successMessage: success),
        );
        add(FetchToolCategories());
      },
    );
  }

  Future<void> _onDeleteCategory(
    DeleteCategoryEvent event,
    Emitter<ToolsState> emit,
  ) async {
    emit(
      state.copyWith(
        isDeletingCategory: true,
        errorMessage: null,
        successMessage: null,
      ),
    );

    final result = await usecase.deleteCategory(event.categoryId);

    result.fold(
      (fail) => emit(
        state.copyWith(isDeletingCategory: false, errorMessage: fail.message),
      ),
      (success) {
        emit(
          state.copyWith(isDeletingCategory: false, successMessage: success),
        );
        add(FetchToolCategories());
        add(const FetchTools(categoryName: null));
      },
    );
  }

  Future<void> _onFetchCategories(
    FetchToolCategories event,
    Emitter<ToolsState> emit,
  ) async {
    emit(state.copyWith(isLoadingCategories: true, errorMessage: null));

    final result = await usecase.getCategories();

    result.fold(
      (fail) => emit(
        state.copyWith(isLoadingCategories: false, errorMessage: fail.message),
      ),
      (categories) => emit(
        state.copyWith(
          isLoadingCategories: false,
          categories: categories,
          errorMessage: null,
        ),
      ),
    );
  }

  Future<void> _onFetchTools(FetchTools event, Emitter<ToolsState> emit) async {
    emit(
      state.copyWith(
        isLoadingTools: true,
        page: 0,
        errorMessage: null,
        selectedCategoryName: event.categoryName,
      ),
    );

    final typeFilter = _getTypeFilter(state.filter);

    final result = await usecase.getAllTools(
      searchName: state.searchKeyword?.isEmpty == true
          ? null
          : state.searchKeyword,
      categoryName: event.categoryName,
      type: typeFilter,
      page: 0,
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
          errorMessage: null,
        ),
      ),
    );
  }

  Future<void> _onSearchTools(
    SearchTools event,
    Emitter<ToolsState> emit,
  ) async {
    emit(state.copyWith(searchKeyword: event.query, errorMessage: null));
    add(FetchTools(categoryName: state.selectedCategoryName));
  }

  Future<void> _onSortTools(SortTools event, Emitter<ToolsState> emit) async {
    emit(
      state.copyWith(
        sortBy: event.sortBy,
        sortDir: event.sortDir,
        errorMessage: null,
      ),
    );
    add(FetchTools(categoryName: state.selectedCategoryName));
  }

  Future<void> _onFilterTools(
    FilterTools event,
    Emitter<ToolsState> emit,
  ) async {
    emit(state.copyWith(filter: event.filter, errorMessage: null));
    add(FetchTools(categoryName: state.selectedCategoryName));
  }

  Future<void> _onFilterByCategory(
    FilterByCategory event,
    Emitter<ToolsState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedCategoryName: event.categoryName,
        errorMessage: null,
      ),
    );
    add(FetchTools(categoryName: event.categoryName));
  }

  Future<void> _onLoadMoreTools(
    LoadMoreTools event,
    Emitter<ToolsState> emit,
  ) async {
    if (state.lastPage || state.isLoadingMore || state.isLoadingTools) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true, errorMessage: null));

    final nextPage = state.page + 1;
    final typeFilter = _getTypeFilter(state.filter);

    final result = await usecase.getAllTools(
      searchName: state.searchKeyword?.isEmpty == true
          ? null
          : state.searchKeyword,
      categoryName: state.selectedCategoryName,
      type: typeFilter,
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
          errorMessage: null,
        ),
      ),
    );
  }

  String? _getTypeFilter(String? filter) {
    if (filter == null || filter == "All" || filter.isEmpty) {
      return null;
    }

    return filter;
  }

  EventTransformer<E> _debounce<E>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
  }

  EventTransformer<E> _throttle<E>(Duration duration) {
    return (events, mapper) => events.throttleTime(duration).switchMap(mapper);
  }
}
