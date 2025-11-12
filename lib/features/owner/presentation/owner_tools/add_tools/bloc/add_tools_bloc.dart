import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_tools_event.dart';
part 'add_tools_state.dart';

class AddToolsBloc extends Bloc<AddToolsEvent, AddToolsState> {
  AddToolsBloc() : super(AddToolsInitial()) {
    on<AddToolsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
