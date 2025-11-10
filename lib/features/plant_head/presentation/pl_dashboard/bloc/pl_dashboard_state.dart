part of 'pl_dashboard_bloc.dart';

sealed class PlDashboardState extends Equatable {
  const PlDashboardState();
  
  @override
  List<Object> get props => [];
}

final class PlDashboardInitial extends PlDashboardState {}
