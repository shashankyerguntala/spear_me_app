part of 'add_merchandise_bloc.dart';

abstract class AddMerchandiseEvent extends Equatable {
  const AddMerchandiseEvent();

  @override
  List<Object?> get props => [];
}

class PickMerchandiseImage extends AddMerchandiseEvent {
  final File file;
  const PickMerchandiseImage(this.file);

  @override
  List<Object?> get props => [file];
}

class SubmitMerchandise extends AddMerchandiseEvent {
  final String name;
  final int requiredPoints;
  final int availableQuantity;

  const SubmitMerchandise({
    required this.name,
    required this.requiredPoints,
    required this.availableQuantity,
  });

  @override
  List<Object?> get props => [name, requiredPoints, availableQuantity];
}

class UpdateMerchandise extends AddMerchandiseEvent {
  final int id;
  final String name;
  final int requiredPoints;
  final int availableQuantity;

  const UpdateMerchandise({
    required this.id,
    required this.name,
    required this.requiredPoints,
    required this.availableQuantity,
  });

  @override
  List<Object?> get props => [id, name, requiredPoints, availableQuantity];
}
