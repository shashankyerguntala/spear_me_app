part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class SignUpRequested extends SignUpEvent {
  final String username;
  final String email;
  final int number;
  final String password;

  const SignUpRequested({
    required this.username,
    required this.email,
    required this.number,
    required this.password,
  });

  @override
  List<Object?> get props => <Object?>[username, email, number, password];
}

class ShowPasswordEvent extends SignUpEvent {}
