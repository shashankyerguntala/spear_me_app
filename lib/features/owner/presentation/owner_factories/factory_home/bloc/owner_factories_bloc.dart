import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'owner_factories_event.dart';
part 'owner_factories_state.dart';

class OwnerFactoriesBloc extends Bloc<OwnerFactoriesEvent, OwnerFactoriesState> {
  OwnerFactoriesBloc() : super(OwnerFactoriesInitial()) {
    on<OwnerFactoriesEvent>((OwnerFactoriesEvent event, Emitter<OwnerFactoriesState> emit) {
      // TODO: implement event handler
    });
  }
}
