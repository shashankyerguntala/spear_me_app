part of 'owner_factories_bloc.dart';

sealed class OwnerFactoriesState extends Equatable {
  const OwnerFactoriesState();
  
  @override
  List<Object> get props => <Object>[];
}

final class OwnerFactoriesInitial extends OwnerFactoriesState {}
