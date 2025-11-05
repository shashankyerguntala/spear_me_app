import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'owner_home_event.dart';
part 'owner_home_state.dart';

class OwnerHomeBloc extends Bloc<OwnerHomeEvent, OwnerHomeState> {
  OwnerHomeBloc() : super(OwnerHomeInitial()) {
    on<OwnerInitialEvent>((
      OwnerHomeEvent event,
      Emitter<OwnerHomeState> emit,
    ) async {
      emit(OwnerLoading());
      await Future.delayed(Duration(seconds: 1));
      emit(OwnerLoaded());
    });
  }
}
