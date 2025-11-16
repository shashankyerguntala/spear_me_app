import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/owner/domain/entity/factory_details_entity.dart';
import 'package:spear_me_app/features/owner/domain/usecase/owner_usecase.dart';

part 'factory_details_event.dart';
part 'factory_details_state.dart';

class FactoryDetailsBloc
    extends Bloc<FactoryDetailsEvent, FactoryDetailsState> {
  final OwnerUsecase usecase;

  FactoryDetailsBloc({required this.usecase}) : super(FactoryDetailsInitial()) {
    on<FetchFactoryDetailsEvent>(_onFetchFactoryDetails);
    on<DeleteFactoryEvent>(deleteFactoryEvent);
  }

  Future<void> _onFetchFactoryDetails(
    FetchFactoryDetailsEvent event,
    Emitter<FactoryDetailsState> emit,
  ) async {
    emit(FactoryDetailsLoading());

    final Either<Failure, FactoryDetailsEntity> result = await usecase
        .getFactoryDetails(event.factoryId);

    result.fold(
      (failure) => emit(FactoryDetailsFailure(message: failure.message)),
      (factory) => emit(FactoryDetailsSuccess(factory: factory)),
    );
  }

  Future<void> deleteFactoryEvent(
    DeleteFactoryEvent event,
    Emitter<FactoryDetailsState> emit,
  ) async {
    emit(FactoryDeleting());

    final result = await usecase.deleteFactory(event.factId);

    result.fold(
      (failure) => emit(FactoryDeleteFailure(msg: failure.message)),
      (msg) => emit(FactoryDeletedSuccessfully(msg: msg)),
    );
  }
}
