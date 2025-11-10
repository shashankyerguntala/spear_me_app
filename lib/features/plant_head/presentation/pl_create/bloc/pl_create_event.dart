part of 'pl_create_bloc.dart';

abstract class PlCreateEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlSelectRole extends PlCreateEvent {
  final String role;
  PlSelectRole(this.role);
}

class PlFetchBays extends PlCreateEvent {}

class PlCreateBay extends PlCreateEvent {
  final int plantHeadId;
  final String bayName;
  PlCreateBay(this.plantHeadId, this.bayName);
}

class PlCreateStaff extends PlCreateEvent {
  final String name;
  final String email;
  final String role;
  final int? bayId;

  PlCreateStaff({
    required this.name,
    required this.email,
    required this.role,
    this.bayId,
  });
}

class PlSelectBay extends PlCreateEvent {
  final int bayId;
  PlSelectBay(this.bayId);
}
