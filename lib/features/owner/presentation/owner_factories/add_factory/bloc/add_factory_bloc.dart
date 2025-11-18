import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spear_me_app/features/owner/domain/usecase/owner_usecase.dart';

part 'add_factory_event.dart';
part 'add_factory_state.dart';

class AddFactoryBloc extends Bloc<AddFactoryEvent, AddFactoryState> {
  final OwnerUsecase ownerUsecase;

  AddFactoryBloc(this.ownerUsecase) : super(AddFactoryInitial()) {
    on<AddFactoryRequested>(_onAddFactoryRequested);
    on<UpdateFactoryRequested>(_onUpdateFactoryRequested);
  }

  Future<void> _onAddFactoryRequested(
    AddFactoryRequested event,
    Emitter<AddFactoryState> emit,
  ) async {
    emit(AddFactoryLoading());

    final result = await ownerUsecase.createFactory(
      event.name,
      event.city,
      event.address,
      event.email,
    );

    result.fold((failure) {
      emit(AddFactoryFailure(message: failure.message));
    }, (message) => emit(AddFactorySuccess(message)));
  }

  Future<void> _onUpdateFactoryRequested(
    UpdateFactoryRequested event,
    Emitter<AddFactoryState> emit,
  ) async {
    emit(AddFactoryLoading());

    final payload = {
      "name": event.name,
      "city": event.city,
      "address": event.address,
      "plantHeadEmail": event.email,
    };

    final result = await ownerUsecase.updateFactory(event.factoryId, payload);

    result.fold(
      (failure) => emit(AddFactoryFailure(message: failure.message)),
      (message) => emit(AddFactorySuccess(message)),
    );
  }
}
