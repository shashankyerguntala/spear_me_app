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
    : super(const MerchandiseHomeInitial()) {
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
    on<ResetMerchandiseFilters>(_onResetMerchandiseFilters);
  }

  Future<void> _onFetchMerchandise(
    FetchMerchandise event,
    Emitter<MerchandiseHomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await usecase.getAllMerchandise(
      search: state.searchQuery.trim().isEmpty
          ? null
          : state.searchQuery.trim(),
      page: 0,
      size: 10,
      sort: state.sortBy,
      asc: state.ascending,
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (paged) => emit(
        state.copyWith(
          isLoading: false,
          items: paged.content,
          page: 0,
          totalPages: paged.totalPages,
          hasMoreData: paged.pageNumber < paged.totalPages - 1,
        ),
      ),
    );
  }

  Future<void> _onLoadMoreMerchandise(
    LoadMoreMerchandise event,
    Emitter<MerchandiseHomeState> emit,
  ) async {
    if (state.isLoadingMore || !state.hasMoreData) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = state.page + 1;

    final result = await usecase.getAllMerchandise(
      search: state.searchQuery.trim().isEmpty
          ? null
          : state.searchQuery.trim(),
      page: nextPage,
      size: 10,
      sort: state.sortBy,
      asc: state.ascending,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(isLoadingMore: false, errorMessage: failure.message),
      ),
      (paged) {
        final updated = List<MerchandiseEntity>.from(state.items)
          ..addAll(paged.content);

        emit(
          state.copyWith(
            isLoadingMore: false,
            items: updated,
            page: nextPage,
            totalPages: paged.totalPages,
            hasMoreData: nextPage < paged.totalPages - 1,
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

  void _onResetMerchandiseFilters(
    ResetMerchandiseFilters event,
    Emitter<MerchandiseHomeState> emit,
  ) {
    emit(const MerchandiseHomeInitial());
    add(const FetchMerchandise());
  }
}
