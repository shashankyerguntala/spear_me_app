part of 'add_factory_bloc.dart';

abstract class AddFactoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddFactoryRequested extends AddFactoryEvent {
  final String name;
  final String city;
  final String address;
  final String email;

  AddFactoryRequested({
    required this.name,
    required this.city,
    required this.address,
    required this.email,
  });

  @override
  List<Object?> get props => [name, city, address, email];
}

class UpdateFactoryRequested extends AddFactoryEvent {
  final int factoryId;
  final String name;
  final String city;
  final String address;
  final String email;

  UpdateFactoryRequested({
    required this.factoryId,
    required this.name,
    required this.city,
    required this.address,
    required this.email,
  });

  @override
  List<Object?> get props => [factoryId, name, city, address, email];
}
