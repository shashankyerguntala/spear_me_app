part of 'add_factory_bloc.dart';

abstract class AddFactoryEvent extends Equatable {
  const AddFactoryEvent();

  @override
  List<Object?> get props => [];
}

class AddFactoryRequested extends AddFactoryEvent {
  final String name;
  final String city;
  final String address;
  final String email;

  const AddFactoryRequested({
    required this.name,
    required this.city,
    required this.address,
    required this.email,
  });

  @override
  List<Object?> get props => [name, city, address, email];
}
