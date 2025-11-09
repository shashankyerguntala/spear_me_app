part of 'owner_central_office_home_bloc.dart';

abstract class OwnerCentralOfficeHomeEvent extends Equatable {
  const OwnerCentralOfficeHomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchCentralOffices extends OwnerCentralOfficeHomeEvent {}
