part of 'create_plant_head_bloc.dart';

abstract class CreatePlantHeadState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreatePlantHeadInitial extends CreatePlantHeadState {}

class CreatePlantHeadLoading extends CreatePlantHeadState {}

class CreatePlantHeadSuccess extends CreatePlantHeadState {
  final String message;
  CreatePlantHeadSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CreatePlantHeadFailure extends CreatePlantHeadState {
  final String message;
  CreatePlantHeadFailure(this.message);

  @override
  List<Object?> get props => [message];
}
