part of 'pl_profile_bloc.dart';

sealed class PlProfileState extends Equatable {
  const PlProfileState();
  
  @override
  List<Object> get props => [];
}

final class PlProfileInitial extends PlProfileState {}
