import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pl_tools_event.dart';
part 'pl_tools_state.dart';

class PlToolsBloc extends Bloc<PlToolsEvent, PlToolsState> {
  PlToolsBloc() : super(PlToolsInitial()) {
    on<PlToolsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
