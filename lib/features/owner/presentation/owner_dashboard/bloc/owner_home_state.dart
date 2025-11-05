part of 'owner_home_bloc.dart';

sealed class OwnerHomeState extends Equatable {
  const OwnerHomeState();
  
  @override
  List<Object> get props => [];
}

final class OwnerHomeInitial extends OwnerHomeState {}
