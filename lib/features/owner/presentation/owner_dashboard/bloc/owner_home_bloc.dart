import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'owner_home_event.dart';
part 'owner_home_state.dart';

class OwnerHomeBloc extends Bloc<OwnerHomeEvent, OwnerHomeState> {
  OwnerHomeBloc() : super(OwnerHomeInitial()) {
    on<OwnerHomeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
