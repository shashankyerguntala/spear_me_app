import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pl_create_event.dart';
part 'pl_create_state.dart';

class PlCreateBloc extends Bloc<PlCreateEvent, PlCreateState> {
  PlCreateBloc() : super(PlCreateInitial()) {
    on<PlCreateEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
