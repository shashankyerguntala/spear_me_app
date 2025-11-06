part of 'add_central_office_bloc.dart';

abstract class AddCentralOfficeEvent extends Equatable {
  const AddCentralOfficeEvent();

  @override
  List<Object> get props => [];
}

class AddCentralOfficeRequested extends AddCentralOfficeEvent {
  final String name;
  final String email;
  final int phone;

  const AddCentralOfficeRequested({
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  List<Object> get props => [name, email, phone];
}
