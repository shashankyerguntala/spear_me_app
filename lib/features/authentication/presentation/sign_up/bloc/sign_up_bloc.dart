import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  bool isPasswordObscured = true;

  SignUpBloc() : super(const SignUpInitial()) {
    on<ShowPasswordEvent>(showPasswordEvent);

    on<SignUpRequested>(signUpRequested);
  }

  Future<void> showPasswordEvent(
    ShowPasswordEvent event,
    Emitter<SignUpState> emit,
  ) async {}

  Future<void> signUpRequested(
    SignUpRequested event,
    Emitter<SignUpState> emit,
  ) async {}
}
