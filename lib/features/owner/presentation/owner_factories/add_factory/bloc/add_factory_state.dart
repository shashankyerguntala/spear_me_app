part of 'add_factory_bloc.dart';

sealed class AddFactoryState extends Equatable {
  const AddFactoryState();
  
  @override
  List<Object> get props => <Object>[];
}

final class AddFactoryInitial extends AddFactoryState {}
