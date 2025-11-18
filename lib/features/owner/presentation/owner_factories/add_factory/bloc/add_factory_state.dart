part of 'add_factory_bloc.dart';

abstract class AddFactoryState extends Equatable {
  const AddFactoryState();

  @override
  List<Object?> get props => [];
}

class AddFactoryInitial extends AddFactoryState {}

class AddFactoryLoading extends AddFactoryState {}

class AddFactorySuccess extends AddFactoryState {
  final String message;

  const AddFactorySuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class AddFactoryFailure extends AddFactoryState {
  final String message;

  const AddFactoryFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
