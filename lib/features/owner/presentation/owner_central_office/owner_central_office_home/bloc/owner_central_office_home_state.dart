part of 'owner_central_office_home_bloc.dart';

abstract class OwnerCentralOfficeHomeState extends Equatable {
  const OwnerCentralOfficeHomeState();

  @override
  List<Object?> get props => [];
}

class OwnerCentralOfficeHomeInitial extends OwnerCentralOfficeHomeState {}

class OwnerCentralOfficeHomeLoading extends OwnerCentralOfficeHomeState {}

class OwnerCentralOfficeHomeLoaded extends OwnerCentralOfficeHomeState {
  final List<CentralOfficeEntity> offices;

  const OwnerCentralOfficeHomeLoaded(this.offices);

  @override
  List<Object?> get props => [offices];
}

class OwnerCentralOfficeHomeFailure extends OwnerCentralOfficeHomeState {
  final String message;

  const OwnerCentralOfficeHomeFailure(this.message);

  @override
  List<Object?> get props => [message];
}
