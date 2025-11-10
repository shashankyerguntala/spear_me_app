import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pl_profile_event.dart';
part 'pl_profile_state.dart';

class PlProfileBloc extends Bloc<PlProfileEvent, PlProfileState> {
  PlProfileBloc() : super(PlProfileInitial()) {
    on<PlProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
