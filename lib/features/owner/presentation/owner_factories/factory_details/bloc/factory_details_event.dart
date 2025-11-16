part of 'factory_details_bloc.dart';

abstract class FactoryDetailsEvent extends Equatable {
  const FactoryDetailsEvent();

  @override
  List<Object?> get props => [];
}

final class FetchFactoryDetailsEvent extends FactoryDetailsEvent {
  final int factoryId;

  const FetchFactoryDetailsEvent(this.factoryId);

  @override
  List<Object?> get props => [factoryId];
}

final class DeleteFactoryEvent extends FactoryDetailsEvent {
  final int factId;

  const DeleteFactoryEvent({required this.factId});
}
