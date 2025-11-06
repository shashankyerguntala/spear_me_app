import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spear_me_app/features/owner/domain/usecase/owner_usecase.dart';
import 'package:spear_me_app/core/network/failure.dart';

part 'add_central_office_event.dart';
part 'add_central_office_state.dart';

class AddCentralOfficeBloc
    extends Bloc<AddCentralOfficeEvent, AddCentralOfficeState> {
  final OwnerUsecase ownerUsecase;

  AddCentralOfficeBloc({required this.ownerUsecase})
      : super(AddCentralOfficeInitial()) {
    on<AddCentralOfficeRequested>(_onAddCentralOfficeRequested);
  }

  Future<void> _onAddCentralOfficeRequested(
    AddCentralOfficeRequested event,
    Emitter<AddCentralOfficeState> emit,
  ) async {
    emit(AddCentralOfficeLoading());

    final result = await ownerUsecase.createCentralOfficer(
      event.name,
      event.email,
      event.phone,
    );

    result.fold(
      (Failure failure) => emit(AddCentralOfficeFailure(failure.message)),
      (String message) => emit(AddCentralOfficeSuccess(message)),
    );
  }
}
