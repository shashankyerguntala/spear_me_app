import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:spear_me_app/features/owner/domain/usecase/product_usecase.dart';

part 'owner_add_category_event.dart';
part 'owner_add_category_state.dart';

class OwnerAddCategoryBloc
    extends Bloc<OwnerAddCategoryEvent, OwnerAddCategoryState> {
  final ProductsUsecase usecase;

  OwnerAddCategoryBloc(this.usecase) : super(OwnerAddCategoryInitial()) {
    on<AddCategoryRequested>(_onAddCategoryRequested);
  }

  Future<void> _onAddCategoryRequested(
    AddCategoryRequested event,
    Emitter<OwnerAddCategoryState> emit,
  ) async {
    emit(OwnerAddCategoryLoading());

    final result = await usecase.createCategory(
      event.categoryName,
      event.description,
    );

    result.fold(
      (failure) => emit(OwnerAddCategoryFailure(failure.message)),
      (message) => emit(OwnerAddCategorySuccess(message)),
    );
  }
}
