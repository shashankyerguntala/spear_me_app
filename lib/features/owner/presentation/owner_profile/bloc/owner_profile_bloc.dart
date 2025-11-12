import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spear_me_app/features/owner/domain/entity/owner_entity.dart';
import 'package:spear_me_app/features/owner/domain/usecase/owner_usecase.dart';

part 'owner_profile_event.dart';
part 'owner_profile_state.dart';

class OwnerProfileBloc extends Bloc<OwnerProfileEvent, OwnerProfileState> {
  final OwnerUsecase usecase;

  OwnerProfileBloc(this.usecase) : super(OwnerProfileInitial()) {
    on<FetchOwnerProfile>(_onFetchOwnerProfile);
    on<UpdateProfileImage>(_onUpdateProfileImage);
  }

  Future<void> _onFetchOwnerProfile(
    FetchOwnerProfile event,
    Emitter<OwnerProfileState> emit,
  ) async {
    emit(OwnerProfileLoading());

    final result = await usecase.getOwnerProfile();

    result.fold(
      (failure) => emit(OwnerProfileFailure(failure.message)),
      (profile) => emit(OwnerProfileLoaded(profile)),
    );
  }

  Future<void> _onUpdateProfileImage(
    UpdateProfileImage event,
    Emitter<OwnerProfileState> emit,
  ) async {
    final current = state is OwnerProfileLoaded
        ? (state as OwnerProfileLoaded).profile
        : null;

    if (current != null) {
      emit(OwnerProfileUploading(current));
    }

    final uploadResult = await usecase.uploadProfileImage(event.filePath);

    await uploadResult.fold(
      (failure) {
        emit(OwnerProfileFailure(failure.message));
      },
      //! get or else and .isleft
      (message) async {
        final refreshed = await usecase.getOwnerProfile();

        refreshed.fold(
          (failure) {
            emit(OwnerProfileFailure(failure.message));
          },
          (profile) {
            emit(OwnerProfileLoaded(profile, message: message));
          },
        );
      },
    );
  }
}
