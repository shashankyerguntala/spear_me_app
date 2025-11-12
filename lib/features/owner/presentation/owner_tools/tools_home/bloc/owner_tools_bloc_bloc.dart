import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'owner_tools_bloc_event.dart';
part 'owner_tools_bloc_state.dart';

class OwnerToolsBlocBloc extends Bloc<OwnerToolsBlocEvent, OwnerToolsBlocState> {
  OwnerToolsBlocBloc() : super(OwnerToolsBlocInitial()) {
    on<OwnerToolsBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
