import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spear_me_app/core/network/debouncer.dart';
import 'package:spear_me_app/features/owner/domain/usecase/owner_usecase.dart';
import 'package:spear_me_app/features/owner/domain/entity/factory_entity.dart';

part 'owner_factories_event.dart';
part 'owner_factories_state.dart';

class OwnerFactoriesBloc
    extends Bloc<OwnerFactoriesEvent, OwnerFactoriesState> {
  final OwnerUsecase usecase;

  OwnerFactoriesBloc({required this.usecase})
    : super(const OwnerFactoriesInitial()) {
    on<FetchFactories>(
      _onFetchFactories,
      transformer: throttleDroppable(throttleDuration),
    );

    on<LoadMoreFactories>(
      _onLoadMoreFactories,
      transformer: throttleDroppable(throttleDuration),
    );

    on<UpdateFactorySearch>(
      _onUpdateFactorySearch,
      transformer: debounce(debounceDuration),
    );

    on<UpdateFactorySort>(_onUpdateFactorySort);
    on<UpdateFactoryFilter>(_onUpdateFactoryFilter);
    on<ResetFactoryFilters>(_onResetFactoryFilters);
  }

  Future<void> _onFetchFactories(
    FetchFactories event,
    Emitter<OwnerFactoriesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, page: 0));

    final query = _buildSearchQuery();
    final sort = _buildSortValue();
    final result = await usecase.getFactories(query, 0, size: 10, sort: sort);

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (paged) => emit(
        state.copyWith(
          isLoading: false,
          factories: paged.factories,
          page: 0,
          totalPages: paged.totalPages,
          hasMoreData: 0 < paged.totalPages - 1,
        ),
      ),
    );
  }

  Future<void> _onLoadMoreFactories(
    LoadMoreFactories event,
    Emitter<OwnerFactoriesState> emit,
  ) async {
    if (state.isLoadingMore || !state.hasMoreData) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = state.page + 1;

    final result = await usecase.getFactories(
      state.searchQuery.isEmpty ? null : state.searchQuery.trim(),
      nextPage,
      size: 10,
      sort: state.sortBy.isEmpty ? null : state.sortBy,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(isLoadingMore: false, errorMessage: failure.message),
      ),
      (paged) {
        final updated = [...state.factories, ...paged.factories];

        emit(
          state.copyWith(
            isLoadingMore: false,
            factories: updated,
            page: nextPage,
            totalPages: paged.totalPages,
            hasMoreData: nextPage < paged.totalPages - 1,
          ),
        );
      },
    );
  }

  void _onUpdateFactorySearch(
    UpdateFactorySearch event,
    Emitter<OwnerFactoriesState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query, page: 0));
    add(const FetchFactories());
  }

  void _onUpdateFactorySort(
    UpdateFactorySort event,
    Emitter<OwnerFactoriesState> emit,
  ) {
    emit(
      state.copyWith(sortBy: event.sortBy, ascending: event.ascending, page: 0),
    );
    add(const FetchFactories());
  }

  void _onUpdateFactoryFilter(
    UpdateFactoryFilter event,
    Emitter<OwnerFactoriesState> emit,
  ) {
    emit(state.copyWith(selectedFilter: event.filter, page: 0));

    add(const FetchFactories());
  }

  void _onResetFactoryFilters(
    ResetFactoryFilters event,
    Emitter<OwnerFactoriesState> emit,
  ) {
    emit(const OwnerFactoriesInitial());
    add(const FetchFactories());
  }

  String? _buildSearchQuery() {
    final search = state.searchQuery.trim();
    final city = state.selectedFilter.trim();

    if (search.isEmpty && city.isEmpty) {
      return null;
    }

    if (search.isNotEmpty && city.isNotEmpty) {
      return "$search $city";
    }

    return search.isNotEmpty ? search : city;
  }

  String? _buildSortValue() {
    final dir = state.sortBy.trim().toLowerCase();
    if (dir.isEmpty) {
      return null;
    }

    if (dir == 'asc' || dir == 'desc') {
      return 'name,$dir';
    }

    final direction = state.ascending ? 'asc' : 'desc';
    return '$dir,$direction';
  }
}
