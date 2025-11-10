import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spear_me_app/features/plant_head/domain/entity/bay_entity.dart';
import 'package:spear_me_app/features/plant_head/domain/usecases/add_usecase.dart';

part 'pl_create_event.dart';
part 'pl_create_state.dart';

class PlCreateBloc extends Bloc<PlCreateEvent, PlCreateState> {
  final AddUsecase usecase;

  PlCreateBloc(this.usecase) : super(PlCreateLoading()) {
    on<PlFetchBays>(_onFetchBays);

    on<PlCreateBay>(_onCreateBay);
    on<PlCreateStaff>(_onCreateStaff);
    on<PlSelectRole>((event, emit) {
      if (state is PlCreateLoaded) {
        final s = state as PlCreateLoaded;
        emit(s.copyWith(selectedRole: event.role));
      }
    });
    on<PlSelectBay>((event, emit) {
      if (state is PlCreateLoaded) {
        final s = state as PlCreateLoaded;
        emit(s.copyWith(selectedBayId: event.bayId));
      }
    });
  }

  Future<void> _onFetchBays(
    PlFetchBays event,
    Emitter<PlCreateState> emit,
  ) async {
    emit(PlCreateLoading());

    final result = await usecase.getBays();

    result.fold(
      (failure) => emit(PlCreateFailure(failure.message)),
      (bays) =>
          emit(PlCreateLoaded(bays: bays, selectedRole: "CHIEF_SUPERVISOR")),
    );
  }

  Future<void> _onCreateBay(
    PlCreateBay event,
    Emitter<PlCreateState> emit,
  ) async {
    if (state is! PlCreateLoaded) {
      return;
    }

    emit(PlCreateLoading());

    final result = await usecase.createBay(
      plantHeadId: event.plantHeadId,
      bayName: event.bayName,
    );

    result.fold((failure) => emit(PlCreateFailure(failure.message)), (
      msg,
    ) async {
      add(PlFetchBays());
      emit(PlCreateSuccess(msg: msg));
    });
  }

  Future<void> _onCreateStaff(
    PlCreateStaff event,
    Emitter<PlCreateState> emit,
  ) async {
    emit(PlCreateLoading());

    if (event.role == "WORKER" && event.bayId == null) {
      emit(PlCreateFailure("Select a Bay for Worker"));
      return;
    }

    final result = event.role == "WORKER"
        ? await usecase.addWorker(
            name: event.name,
            email: event.email,
            bayId: event.bayId!,
          )
        : await usecase.addChiefSupervisor(
            name: event.name,
            email: event.email,
          );

    result.fold((failure) => emit(PlCreateFailure(failure.message)), (message) {
      emit(PlCreateSuccess(msg: message));
      add(PlFetchBays());
    });
  }
}
