part of 'owner_home_bloc.dart';

sealed class OwnerHomeState extends Equatable {
  const OwnerHomeState();

  @override
  List<Object> get props => <Object>[];
}

final class OwnerHomeInitial extends OwnerHomeState {}

final class OwnerLoading extends OwnerHomeState {}

final class OwnerLoaded extends OwnerHomeState {}
