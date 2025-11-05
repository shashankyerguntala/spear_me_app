part of 'sign_in_bloc.dart';

sealed class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => <Object?>[];
}

class SignInInitial extends SignInState {
  final bool isPasswordObscured;

  const SignInInitial({this.isPasswordObscured = true});

  @override
  List<Object?> get props => <Object?>[isPasswordObscured];
}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {
  const SignInSuccess();

  @override
  List<Object?> get props => <Object?>[];
}

class SignInFailure extends SignInState {
  final String message;

  const SignInFailure(this.message);

  @override
  List<Object?> get props => <Object?>[message];
}

class SignInPasswordVisibilityChanged extends SignInState {
  final bool isPasswordObscured;

  // ignore: avoid_positional_boolean_parameters
  const SignInPasswordVisibilityChanged(this.isPasswordObscured);

  @override
  List<Object?> get props => <Object?>[isPasswordObscured];
}
