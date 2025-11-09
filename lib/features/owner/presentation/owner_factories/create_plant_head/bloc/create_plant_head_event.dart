part of 'create_plant_head_bloc.dart';

abstract class CreatePlantHeadEvent extends Equatable {
  const CreatePlantHeadEvent();
  @override
  List<Object?> get props => [];
}

class CreatePlantHeadRequested extends CreatePlantHeadEvent {
  final String username;
  final String email;

  const CreatePlantHeadRequested({required this.username, required this.email});
}
