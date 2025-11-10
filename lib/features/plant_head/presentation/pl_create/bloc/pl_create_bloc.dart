import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spear_me_app/features/plant_head/domain/entity/bay_entity.dart';
import 'package:spear_me_app/features/plant_head/domain/usecases/add_usecase.dart';

part 'pl_create_event.dart';
part 'pl_create_state.dart';

class PlCreateBloc extends Bloc<PlCreateEvent, PlCreateState> {
  final AddUsecase usecase;

  PlCreateBloc(this.usecase) : super(const PlCreateDataState()) {
    on<PlFetchBays>(_onFetchBays);
    on<PlCreateBay>(_onCreateBay);
    on<PlCreateStaff>(_onCreateStaff);
    on<PlSelectRole>(_onSelectRole);
    on<PlSelectBay>(_onSelectBay);
  }

  Future<void> _onFetchBays(
    PlFetchBays event,
    Emitter<PlCreateState> emit,
  ) async {
    final current = state as PlCreateDataState;
    emit(current.copyWith(isLoading: true));

    final result = await usecase.getBays();

    result.fold((failure) => emit(PlCreateFailure(failure.message)), (bays) {
      emit(
        current.copyWith(
          isLoading: false,
          bays: bays,
          selectedBayId: bays.isNotEmpty ? bays.first.id : null,
        ),
      );
      if (bays.isEmpty) {
        emit(const PlCreateFailure("No bays available"));
      }
    });
  }

  void _onSelectRole(PlSelectRole event, Emitter<PlCreateState> emit) {
    final current = state as PlCreateDataState;
    emit(current.copyWith(selectedRole: event.role));

    if (event.role.toUpperCase() == "WORKER" && current.bays.isEmpty) {
      add(PlFetchBays());
    }
  }

  void _onSelectBay(PlSelectBay event, Emitter<PlCreateState> emit) {
    final current = state as PlCreateDataState;
    emit(current.copyWith(selectedBayId: event.bayId));
  }

  Future<void> _onCreateBay(
    PlCreateBay event,
    Emitter<PlCreateState> emit,
  ) async {
    final current = state as PlCreateDataState;
    emit(current.copyWith(isLoading: true));

    final result = await usecase.createBay(
      plantHeadId: 2,//! why will i give u ID extract from token 
      bayName: event.bayName,
    );

    result.fold((failure) => emit(PlCreateFailure(failure.message)), (_) async {
      final baysResult = await usecase.getBays();
      baysResult.fold((failure) => emit(PlCreateFailure(failure.message)), (
        bays,
      ) {
        BayEntity updated = bays.last;
        emit(
          current.copyWith(
            isLoading: false,
            bays: bays,
            selectedBayId: updated.id,
          ),
        );
        emit(const PlCreateSuccess("Bay created successfully"));
      });
    });
  }

  Future<void> _onCreateStaff(
    PlCreateStaff event,
    Emitter<PlCreateState> emit,
  ) async {
    if (event.name.isEmpty) {
      return emit(const PlCreateFailure("Name cannot be empty"));
    }
    if (event.email.isEmpty) {
      return emit(const PlCreateFailure("Email cannot be empty"));
    }
    if (event.role.toUpperCase() == "WORKER" && event.bayId == null) {
      return emit(const PlCreateFailure("Please select a bay for worker"));
    }

    final current = state as PlCreateDataState;
    emit(current.copyWith(isLoading: true));

    final result = event.role.toUpperCase() == "WORKER"
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
      emit(current.copyWith(isLoading: false));
      emit(PlCreateSuccess(message));
    });
  }
}
