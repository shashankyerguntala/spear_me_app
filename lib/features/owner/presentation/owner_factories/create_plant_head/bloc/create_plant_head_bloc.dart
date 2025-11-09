import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/owner/domain/usecase/owner_usecase.dart';

part 'create_plant_head_event.dart';
part 'create_plant_head_state.dart';

class CreatePlantHeadBloc
    extends Bloc<CreatePlantHeadEvent, CreatePlantHeadState> {
  final OwnerUsecase usecase;

  CreatePlantHeadBloc({required this.usecase})
    : super(CreatePlantHeadInitial()) {
    on<CreatePlantHeadRequested>((event, emit) async {
      emit(CreatePlantHeadLoading());

      final result = await usecase.createPlantHead(
        username: event.username,
        email: event.email,
      );

      result.fold(
        (Failure failure) => emit(CreatePlantHeadFailure(failure.message)),
        (successMsg) => emit(CreatePlantHeadSuccess(successMsg)),
      );
    });
  }
}
