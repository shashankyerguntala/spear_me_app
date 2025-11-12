part of 'add_tools_bloc.dart';

sealed class AddToolsState extends Equatable {
  const AddToolsState();
  
  @override
  List<Object> get props => [];
}

final class AddToolsInitial extends AddToolsState {}
