import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/owner/domain/entity/merchandise_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/paginated_merchandise_entity.dart';
import 'package:spear_me_app/features/owner/domain/usecase/merchandise_usecase.dart';

part 'merchandise_home_event.dart';
part 'merchandise_home_state.dart';

class MerchandiseHomeBloc
    extends Bloc<MerchandiseHomeEvent, MerchandiseHomeState> {
  final MerchandiseUsecase usecase;

  MerchandiseHomeBloc(this.usecase) : super(const MerchandiseHomeState()) {
    on<FetchMerchandise>(
      _onFetchMerchandise,
      transformer: (events, mapper) {
        final debounced = events
            .where((e) => e.isLoadMore == false)
            .debounceTime(const Duration(milliseconds: 400));

        final throttled = events
            .where((e) => e.isLoadMore == true)
            .throttleTime(const Duration(seconds: 2));

        return MergeStream([debounced, throttled]).asyncExpand(mapper);
      },
    );
  }

  Future<void> _onFetchMerchandise(
    FetchMerchandise event,
    Emitter<MerchandiseHomeState> emit,
  ) async {
    if (event.isLoadMore) {
      if (state.lastPage || state.isLoadingMore) {
        return;
      }

      emit(state.copyWith(isLoadingMore: true));
      final nextPage = state.page + 1;

      final result = await usecase.getAll(page: nextPage);
      result.fold(
        (fail) => emit(
          state.copyWith(isLoadingMore: false, errorMessage: fail.message),
        ),
        (data) => emit(
          state.copyWith(
            isLoadingMore: false,
            items: [...state.items, ...data.content],
            page: data.pageNumber,
            lastPage: data.last,
            totalPages: data.totalPages,
          ),
        ),
      );
      return;
    }

    emit(state.copyWith(isLoading: true, page: 0));

    final Either<Failure, PaginatedMerchandiseEntity> result = await usecase
        .getAll();

    result.fold(
      (fail) =>
          emit(state.copyWith(isLoading: false, errorMessage: fail.message)),
      (data) => emit(
        state.copyWith(
          isLoading: false,
          items: data.content,
          page: data.pageNumber,
          lastPage: data.last,
          totalPages: data.totalPages,
        ),
      ),
    );
  }
}
