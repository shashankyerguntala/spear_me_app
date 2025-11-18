import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spear_me_app/features/owner/domain/usecase/merchandise_usecase.dart';

part 'add_merchandise_event.dart';
part 'add_merchandise_state.dart';

class AddMerchandiseBloc
    extends Bloc<AddMerchandiseEvent, AddMerchandiseState> {
  final MerchandiseUsecase usecase;

  AddMerchandiseBloc(this.usecase) : super(const AddMerchandiseInitial()) {
    on<PickMerchandiseImage>(_onPickImage);
    on<SubmitMerchandise>(_onSubmitMerchandise);
    on<UpdateMerchandise>(_onUpdateMerchandise);
  }

  Future<void> _onPickImage(
    PickMerchandiseImage event,
    Emitter<AddMerchandiseState> emit,
  ) async {
    emit(state.copyWith(image: event.file));
  }

  Future<void> _onSubmitMerchandise(
    SubmitMerchandise event,
    Emitter<AddMerchandiseState> emit,
  ) async {
    if (state.image == null) {
      emit(state.copyWith(error: "Please select an image."));
      return;
    }

    emit(state.copyWith(isLoading: true));

    final result = await usecase.add(
      name: event.name,
      requiredPoints: event.requiredPoints,
      availableQuantity: event.availableQuantity,
      imageFile: state.image!,
    );

    result.fold(
      (fail) => emit(state.copyWith(isLoading: false, error: fail.message)),
      (msg) => emit(state.copyWith(isLoading: false, success: msg)),
    );
  }

  Future<void> _onUpdateMerchandise(
    UpdateMerchandise event,
    Emitter<AddMerchandiseState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await usecase.update(
      id: event.id,
      name: event.name,
      requiredPoints: event.requiredPoints,
      availableQuantity: event.availableQuantity,
      imageFile: state.image,
    );

    result.fold(
      (fail) => emit(state.copyWith(isLoading: false, error: fail.message)),
      (msg) => emit(state.copyWith(isLoading: false, success: msg)),
    );
  }
}
