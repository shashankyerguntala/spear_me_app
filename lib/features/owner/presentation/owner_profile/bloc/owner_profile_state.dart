part of 'owner_profile_bloc.dart';

sealed class OwnerProfileState extends Equatable {
  const OwnerProfileState();

  @override
  List<Object?> get props => [];
}

class OwnerProfileInitial extends OwnerProfileState {}

class OwnerProfileLoading extends OwnerProfileState {}

class OwnerProfileFailure extends OwnerProfileState {
  final String message;
  const OwnerProfileFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class OwnerProfileLoaded extends OwnerProfileState {
  final OwnerProfileEntity profile;
  final String? message;

  const OwnerProfileLoaded(this.profile, {this.message});

  @override
  List<Object?> get props => [profile, message];
}

class OwnerProfileUploading extends OwnerProfileState {
  final OwnerProfileEntity profile;

  const OwnerProfileUploading(this.profile);

  @override
  List<Object?> get props => [profile];
}

class LogoutSuccessful extends OwnerProfileState {}
