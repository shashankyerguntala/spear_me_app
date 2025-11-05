import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  bool isPasswordObscured = true;
  int? uid;
  String? role;
  SignInBloc() : super(const SignInInitial()) {
    on<ShowPasswordEvent>((ShowPasswordEvent event, Emitter<SignInState> emit) {
      isPasswordObscured = !isPasswordObscured;
      emit(SignInPasswordVisibilityChanged(isPasswordObscured));
    });

    on<SignInRequested>((
      SignInRequested event,
      Emitter<SignInState> emit,
    ) async {
      emit(SignInLoading());
      await Future.delayed(Duration(seconds: 3));
      emit(SignInSuccess());
    });
  }
}
