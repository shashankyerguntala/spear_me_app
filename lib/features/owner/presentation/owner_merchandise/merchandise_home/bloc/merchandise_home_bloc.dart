import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spear_me_app/core/network/debouncer.dart';
import 'package:spear_me_app/features/owner/domain/entity/merchandise_entity.dart';
import 'package:spear_me_app/features/owner/domain/usecase/merchandise_usecase.dart';

part 'merchandise_home_event.dart';
part 'merchandise_home_state.dart';

class MerchandiseHomeBloc
    extends Bloc<MerchandiseHomeEvent, MerchandiseHomeState> {
  final MerchandiseUsecase usecase;

  MerchandiseHomeBloc({required this.usecase})
    : super(MerchandiseHomeState.initial()) {
    on<FetchMerchandise>(
      _onFetchMerchandise,
      transformer: throttleDroppable(throttleDuration),
    );

    on<LoadMoreMerchandise>(
      _onLoadMoreMerchandise,
      transformer: throttleDroppable(throttleDuration),
    );

    on<UpdateSearchQuery>(
      _onUpdateSearchQuery,
      transformer: debounce(debounceDuration),
    );

    on<UpdateCategoryFilter>(_onUpdateCategoryFilter);

    on<SortMerchandise>(_onSortMerchandise);

    on<ResetMerchandiseFilters>(_onResetFilters);

    on<DeleteMerchandise>(_deleteMerchandise);
  }

  Future<void> _onFetchMerchandise(
    FetchMerchandise event,
    Emitter<MerchandiseHomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await usecase.getAllMerchandise(
      search: state.searchQuery.isEmpty ? null : state.searchQuery.trim(),
      page: 0,
      size: 10,
      sort: state.sortBy.isEmpty ? null : state.sortBy,
      asc: state.ascending,
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (paged) {
        emit(
          state.copyWith(
            isLoading: false,
            items: paged.content,
            page: 0,
            totalPages: paged.totalPages,
            hasMoreData: paged.pageNumber < (paged.totalPages - 1),
          ),
        );
      },
    );
  }

  Future<void> _onLoadMoreMerchandise(
    LoadMoreMerchandise event,
    Emitter<MerchandiseHomeState> emit,
  ) async {
    if (!state.hasMoreData || state.isLoadingMore) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = state.page + 1;

    final result = await usecase.getAllMerchandise(
      search: state.searchQuery.isEmpty ? null : state.searchQuery.trim(),
      page: nextPage,
      size: 10,
      sort: state.sortBy.isEmpty ? null : state.sortBy,
      asc: state.ascending,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(isLoadingMore: false, errorMessage: failure.message),
      ),
      (paged) {
        emit(
          state.copyWith(
            isLoadingMore: false,
            items: [...state.items, ...paged.content],
            page: nextPage,
            totalPages: paged.totalPages,
            hasMoreData: nextPage < (paged.totalPages - 1),
          ),
        );
      },
    );
  }

  void _onUpdateSearchQuery(
    UpdateSearchQuery event,
    Emitter<MerchandiseHomeState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query, page: 0));
    add(const FetchMerchandise());
  }

  void _onUpdateCategoryFilter(
    UpdateCategoryFilter event,
    Emitter<MerchandiseHomeState> emit,
  ) {
    emit(state.copyWith(selectedCategory: event.category, page: 0));
    add(const FetchMerchandise());
  }

  void _onSortMerchandise(
    SortMerchandise event,
    Emitter<MerchandiseHomeState> emit,
  ) {
    emit(
      state.copyWith(sortBy: event.sortBy, ascending: event.ascending, page: 0),
    );
    add(const FetchMerchandise());
  }

  void _onResetFilters(
    ResetMerchandiseFilters event,
    Emitter<MerchandiseHomeState> emit,
  ) {
    emit(
      state.copyWith(
        searchQuery: '',
        selectedCategory: '',
        sortBy: '',
        ascending: true,
        page: 0,
      ),
    );
    add(const FetchMerchandise());
  }

  Future<void> _deleteMerchandise(
    DeleteMerchandise event,
    Emitter<MerchandiseHomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await usecase.delete(event.merchandiseId);

    result.fold(
      (fail) =>
          emit(state.copyWith(isLoading: false, errorMessage: fail.message)),
      (msg) {
        emit(state.copyWith(isLoading: false, successMessage: msg));
        add(const FetchMerchandise());
      },
    );
  }
}
