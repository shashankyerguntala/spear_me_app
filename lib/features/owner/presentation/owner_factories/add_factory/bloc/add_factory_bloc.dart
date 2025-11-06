import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spear_me_app/features/owner/domain/usecase/owner_usecase.dart';
import 'package:spear_me_app/core/network/failure.dart';

part 'add_factory_event.dart';
part 'add_factory_state.dart';

class AddFactoryBloc extends Bloc<AddFactoryEvent, AddFactoryState> {
  final OwnerUsecase ownerUsecase;

  AddFactoryBloc(this.ownerUsecase) : super(AddFactoryInitial()) {
    on<AddFactoryRequested>(_onAddFactoryRequested);
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

    result.fold(
      (Failure failure) => emit(AddFactoryFailure(failure.message)),
      (String message) => emit(AddFactorySuccess(message)),
    );
  }
}
