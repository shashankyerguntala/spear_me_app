import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/owner/domain/usecase/merchandise_usecase.dart';

part 'add_merchandise_event.dart';
part 'add_merchandise_state.dart';

class AddMerchandiseBloc
    extends Bloc<AddMerchandiseEvent, AddMerchandiseState> {
  final MerchandiseUsecase usecase;

  AddMerchandiseBloc(this.usecase) : super(AddMerchandiseInitial()) {
    on<UploadMerchandiseImage>(_onUploadImage);
    on<SubmitMerchandise>(_onSubmitMerchandise);
  }

  Future<void> _onUploadImage(
    UploadMerchandiseImage event,
    Emitter<AddMerchandiseState> emit,
  ) async {
    emit(AddMerchandiseLoading());

    await Future.delayed(const Duration(seconds: 1));

    emit(const AddMerchandiseSuccess("Image uploaded successfully"));
  }

  Future<void> _onSubmitMerchandise(
    SubmitMerchandise event,
    Emitter<AddMerchandiseState> emit,
  ) async {
    emit(AddMerchandiseLoading());

    final result = await usecase.add(
      name: event.name,
      requiredPoints: event.requiredPoints,
      availableQuantity: event.availableQuantity,
      imageFile: File(event.imagePath),
    );

    result.fold(
      (Failure fail) => emit(AddMerchandiseFailure(fail.message)),
      (String message) => emit(AddMerchandiseSuccess(message)),
    );
  }
}
