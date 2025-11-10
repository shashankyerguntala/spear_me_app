part of 'pl_tools_bloc.dart';

sealed class PlToolsState extends Equatable {
  const PlToolsState();
  
  @override
  List<Object> get props => [];
}

final class PlToolsInitial extends PlToolsState {}
