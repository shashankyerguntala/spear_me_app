part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => <Object?>[];
}

class SignUpInitial extends SignUpState {
  final bool isPasswordObscured;

  const SignUpInitial({this.isPasswordObscured = true});

  @override
  List<Object?> get props => <Object?>[isPasswordObscured];
}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final String msg;

  const SignUpSuccess(this.msg);

  @override
  List<Object?> get props => <Object?>[msg];
}

class SignUpFailure extends SignUpState {
  final String message;

  const SignUpFailure(this.message);

  @override
  List<Object?> get props => <Object?>[message];
}

class SignUpPasswordVisibilityChanged extends SignUpState {
  final bool isPasswordObscured;

  const SignUpPasswordVisibilityChanged(this.isPasswordObscured);

  @override
  List<Object?> get props => <Object?>[isPasswordObscured];
}
