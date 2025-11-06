import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/features/authentication/domain/usecase/auth_usecase.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthUsecase authUsecase;
  bool isPasswordObscured = true;

  SignUpBloc(this.authUsecase) : super(const SignUpInitial()) {
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
  ) async {
    emit(SignUpLoading());
    final Either<Failure, String> result = await authUsecase.register(
      event.username,
      event.email,
      event.number,
      event.password,
    );
    return result.fold(
      (Failure fail) => emit(SignUpFailure(fail.message)),
      (String msg) => emit(SignUpSuccess(msg)),
    );
  }
}
