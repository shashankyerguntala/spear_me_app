import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pl_dashboard_event.dart';
part 'pl_dashboard_state.dart';

class PlDashboardBloc extends Bloc<PlDashboardEvent, PlDashboardState> {
  PlDashboardBloc() : super(PlDashboardInitial()) {
    on<PlDashboardEvent>((event, emit) {});
  }
}
