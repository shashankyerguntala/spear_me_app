part of 'owner_tools_bloc_bloc.dart';

sealed class OwnerToolsBlocState extends Equatable {
  const OwnerToolsBlocState();
  
  @override
  List<Object> get props => [];
}

final class OwnerToolsBlocInitial extends OwnerToolsBlocState {}
