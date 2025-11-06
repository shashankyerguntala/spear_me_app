import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_factory_event.dart';
part 'add_factory_state.dart';

class AddFactoryBloc extends Bloc<AddFactoryEvent, AddFactoryState> {
  AddFactoryBloc() : super(AddFactoryInitial()) {
    on<AddFactoryEvent>((AddFactoryEvent event, Emitter<AddFactoryState> emit) {
      // TODO: implement event handler
    });
  }
}
