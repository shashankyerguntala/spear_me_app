import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spear_me_app/core/network/failure.dart';
import 'package:spear_me_app/core/shared_prefs/auth_local_storage.dart';
import 'package:spear_me_app/features/authentication/domain/entity/login_response_entity.dart';
import 'package:spear_me_app/features/authentication/domain/usecase/auth_usecase.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

// TODO(Shashank): make sure the user's login session is persistent and not lost on app restart.
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  bool isPasswordObscured = true;
  final AuthUsecase authUsecase;
  SignInBloc(this.authUsecase) : super(const SignInInitial()) {
    on<ShowPasswordEvent>((ShowPasswordEvent event, Emitter<SignInState> emit) {
      isPasswordObscured = !isPasswordObscured;
      emit(
        SignInPasswordVisibilityChanged(isPasswordObscured: isPasswordObscured),
      );
    });

    on<SignInRequested>((
      SignInRequested event,
      Emitter<SignInState> emit,
    ) async {
      emit(SignInLoading());
      final Either<Failure, LoginResponseEntity> result = await authUsecase
          .login(event.email, event.password);
      return await result.fold(
        (Failure fail) {
          return emit(SignInFailure(fail.message));
        },
        (LoginResponseEntity response) async {
          if (!response.success) {
            return emit(SignInFailure(response.message));
          }
          await AuthLocalStorage.saveToken(response.token);
          return emit(SignInSuccess(response.role));
        },
      );
    });
  }
}
