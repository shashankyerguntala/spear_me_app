part of 'owner_profile_bloc.dart';

sealed class OwnerProfileEvent extends Equatable {
  const OwnerProfileEvent();

  @override
  List<Object?> get props => [];
}

class FetchOwnerProfile extends OwnerProfileEvent {}

class UpdateProfileImage extends OwnerProfileEvent {
  final String filePath;
  const UpdateProfileImage(this.filePath);

  @override
  List<Object?> get props => [filePath];
}

class LogoutEvent extends OwnerProfileEvent {}
