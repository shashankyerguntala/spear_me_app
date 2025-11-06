part of 'add_central_office_bloc.dart';

abstract class AddCentralOfficeState extends Equatable {
  const AddCentralOfficeState();

  @override
  List<Object?> get props => [];
}

class AddCentralOfficeInitial extends AddCentralOfficeState {}

class AddCentralOfficeLoading extends AddCentralOfficeState {}

class AddCentralOfficeSuccess extends AddCentralOfficeState {
  final String message;

  const AddCentralOfficeSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class AddCentralOfficeFailure extends AddCentralOfficeState {
  final String message;

  const AddCentralOfficeFailure(this.message);

  @override
  List<Object?> get props => [message];
}
