part of 'factory_details_bloc.dart';

abstract class FactoryDetailsState extends Equatable {
  const FactoryDetailsState();

  @override
  List<Object?> get props => [];
}

class FactoryDetailsInitial extends FactoryDetailsState {}

class FactoryDetailsLoading extends FactoryDetailsState {}

class FactoryDetailsSuccess extends FactoryDetailsState {
  final FactoryDetailsEntity factory;

  const FactoryDetailsSuccess({required this.factory});

  @override
  List<Object?> get props => [factory];
}

class FactoryDetailsFailure extends FactoryDetailsState {
  final String message;

  const FactoryDetailsFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class FactoryDeleting extends FactoryDetailsState {}

class FactoryDeletedSuccessfully extends FactoryDetailsState {
  final String msg;

  const FactoryDeletedSuccessfully({required this.msg});
}

class FactoryDeleteFailure extends FactoryDetailsState {
  final String msg;

  const FactoryDeleteFailure({required this.msg});
}
