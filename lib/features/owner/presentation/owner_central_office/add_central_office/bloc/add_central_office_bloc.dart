import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_central_office_event.dart';
part 'add_central_office_state.dart';

class AddCentralOfficeBloc extends Bloc<AddCentralOfficeEvent, AddCentralOfficeState> {
  AddCentralOfficeBloc() : super(AddCentralOfficeInitial()) {
    on<AddCentralOfficeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
