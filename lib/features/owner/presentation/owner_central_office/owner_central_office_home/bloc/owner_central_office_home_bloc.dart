import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/owner/domain/entity/central_office_entity.dart';
import 'package:spear_me_app/features/owner/domain/usecase/owner_usecase.dart';

part 'owner_central_office_home_event.dart';
part 'owner_central_office_home_state.dart';

class OwnerCentralOfficeHomeBloc
    extends Bloc<OwnerCentralOfficeHomeEvent, OwnerCentralOfficeHomeState> {
  final OwnerUsecase ownerUsecase;

  OwnerCentralOfficeHomeBloc({required this.ownerUsecase})
    : super(OwnerCentralOfficeHomeInitial()) {
    on<FetchCentralOffices>(_onFetchOffices);
  }

  Future<void> _onFetchOffices(
    FetchCentralOffices event,
    Emitter<OwnerCentralOfficeHomeState> emit,
  ) async {
    emit(OwnerCentralOfficeHomeLoading());

    final result = await ownerUsecase.getCentralOffice();

    result.fold(
      (Failure failure) => emit(OwnerCentralOfficeHomeFailure(failure.message)),
      (offices) => emit(OwnerCentralOfficeHomeLoaded(offices)),
    );
  }
}
