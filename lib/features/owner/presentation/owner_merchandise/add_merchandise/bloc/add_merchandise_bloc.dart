import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_merchandise_event.dart';
part 'add_merchandise_state.dart';

class AddMerchandiseBloc extends Bloc<AddMerchandiseEvent, AddMerchandiseState> {
  AddMerchandiseBloc() : super(AddMerchandiseInitial()) {
    on<AddMerchandiseEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
