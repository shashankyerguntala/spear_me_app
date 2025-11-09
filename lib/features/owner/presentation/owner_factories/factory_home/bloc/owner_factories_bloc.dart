// owner_factories_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spear_me_app/features/owner/domain/usecase/owner_usecase.dart';
import 'package:spear_me_app/features/owner/domain/entity/factory_entity.dart';

part 'owner_factories_event.dart';
part 'owner_factories_state.dart';

class OwnerFactoriesBloc
    extends Bloc<OwnerFactoriesEvent, OwnerFactoriesState> {
  final OwnerUsecase ownerUsecase;

  OwnerFactoriesBloc({required this.ownerUsecase})
    : super(OwnerFactoriesLoading()) {
    on<FetchFactories>(_onFetchFactories);
  }

  Future<void> _onFetchFactories(
    FetchFactories event,
    Emitter<OwnerFactoriesState> emit,
  ) async {
    emit(OwnerFactoriesLoading());

    final result = await ownerUsecase.getFactories(
      event.search,
      event.page,
      size: event.size,
      sort: event.sort,
    );

    result.fold(
      (failure) => emit(OwnerFactoriesFailure(failure.message)),
      (pagedData) => emit(
        OwnerFactoriesLoaded(
          factories: pagedData.factories,
          page: pagedData.page,
          totalPages: pagedData.totalPages,
          appliedSearch: event.search,
          appliedSort: event.sort,
        ),
      ),
    );
  }
}
