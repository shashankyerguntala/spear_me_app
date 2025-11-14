import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spear_me_app/features/owner/domain/entity/tools_category_entity.dart';
import 'package:spear_me_app/features/owner/domain/usecase/tools_usecase.dart';
import 'package:spear_me_app/core/network/failure.dart';

part 'add_tools_event.dart';
part 'add_tools_state.dart';

class AddToolsBloc extends Bloc<AddToolsEvent, AddToolsState> {
  final ToolUsecase usecase;

  AddToolsBloc(this.usecase) : super(const AddToolsState()) {
    on<FetchToolCategories>(_onFetchCategories);
    on<CreateTool>(_onCreateTool);
  }

  Future<void> _onFetchCategories(
    FetchToolCategories event,
    Emitter<AddToolsState> emit,
  ) async {
    emit(state.copyWith(isLoadingCategories: true));

    final result = await usecase.getCategories();
    result.fold(
      (Failure failure) => emit(
        state.copyWith(
          isLoadingCategories: false,
          errorMessage: failure.message,
        ),
      ),
      (List<ToolCategoryEntity> categories) {
        emit(
          state.copyWith(isLoadingCategories: false, categories: categories),
        );
      },
    );
  }

  Future<void> _onCreateTool(
    CreateTool event,
    Emitter<AddToolsState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true));

    final result = await usecase.createTool(
      name: event.name,
      categoryId: event.categoryId,
      type: event.type,
      isExpensive: event.isExpensive,
      threshold: event.threshold,
    );

    result.fold(
      (Failure failure) => emit(
        state.copyWith(isSubmitting: false, errorMessage: failure.message),
      ),
      (String message) =>
          emit(state.copyWith(isSubmitting: false, successMessage: message)),
    );
  }
}
