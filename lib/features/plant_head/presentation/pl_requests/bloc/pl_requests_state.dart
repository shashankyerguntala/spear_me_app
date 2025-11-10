part of 'pl_requests_bloc.dart';

sealed class PlRequestsState extends Equatable {
  const PlRequestsState();
  
  @override
  List<Object> get props => [];
}

final class PlRequestsInitial extends PlRequestsState {}
