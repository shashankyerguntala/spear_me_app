part of 'add_merchandise_bloc.dart';

abstract class AddMerchandiseEvent extends Equatable {
  const AddMerchandiseEvent();

  @override
  List<Object?> get props => [];
}

class UploadMerchandiseImage extends AddMerchandiseEvent {
  final String imagePath;

  const UploadMerchandiseImage(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

class SubmitMerchandise extends AddMerchandiseEvent {
  final String name;
  final int requiredPoints;
  final int availableQuantity;
  final String imagePath;

  const SubmitMerchandise({
    required this.name,
    required this.requiredPoints,
    required this.availableQuantity,
    required this.imagePath,
  });

  @override
  List<Object?> get props => [
    name,
    requiredPoints,
    availableQuantity,
    imagePath,
  ];
}
