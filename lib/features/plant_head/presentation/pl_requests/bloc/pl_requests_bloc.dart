import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pl_requests_event.dart';
part 'pl_requests_state.dart';

class PlRequestsBloc extends Bloc<PlRequestsEvent, PlRequestsState> {
  PlRequestsBloc() : super(PlRequestsInitial()) {
    on<PlRequestsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
