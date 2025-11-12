part of 'add_merchandise_bloc.dart';

abstract class AddMerchandiseState extends Equatable {
  const AddMerchandiseState();

  @override
  List<Object?> get props => [];
}

class AddMerchandiseInitial extends AddMerchandiseState {}

class AddMerchandiseLoading extends AddMerchandiseState {}

class AddMerchandiseSuccess extends AddMerchandiseState {
  final String message;

  const AddMerchandiseSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class AddMerchandiseFailure extends AddMerchandiseState {
  final String error;

  const AddMerchandiseFailure(this.error);

  @override
  List<Object?> get props => [error];
}
