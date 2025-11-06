import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'owner_central_office_home_event.dart';
part 'owner_central_office_home_state.dart';

class OwnerCentralOfficeHomeBloc extends Bloc<OwnerCentralOfficeHomeEvent, OwnerCentralOfficeHomeState> {
  OwnerCentralOfficeHomeBloc() : super(OwnerCentralOfficeHomeInitial()) {
    on<OwnerCentralOfficeHomeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
