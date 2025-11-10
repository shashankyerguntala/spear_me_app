import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spear_me_app/features/owner/domain/entity/product_category_entity.dart';
import 'package:spear_me_app/features/owner/domain/usecase/product_usecase.dart';

part 'owner_add_product_event.dart';
part 'owner_add_product_state.dart';

class OwnerAddProductBloc
    extends Bloc<OwnerAddProductEvent, OwnerAddProductState> {
  final ProductsUsecase usecase;

  OwnerAddProductBloc({required this.usecase})
      : super(const OwnerAddProductInitial()) {
    on<FetchCategoriesRequested>(_onFetchCategoriesRequested);
    on<ImageSelected>(_onImageSelected);
    on<CategorySelected>(_onCategorySelected);
    on<AddProductRequested>(_onAddProductRequested);
  }

  Future<void> _onFetchCategoriesRequested(
    FetchCategoriesRequested event,
    Emitter<OwnerAddProductState> emit,
  ) async {
    if (state is OwnerAddProductInitial) {
      final currentState = state as OwnerAddProductInitial;
      emit(currentState.copyWith(isFetchingCategories: true));

      final result = await usecase.getCategories();

      result.fold(
        (failure) => emit(CategoryFetchFailure(failure.message)),
        (categories) {
          emit(
            currentState.copyWith(
              categories: categories,
              isFetchingCategories: false,
            ),
          );
        },
      );
    }
  }

  void _onImageSelected(
    ImageSelected event,
    Emitter<OwnerAddProductState> emit,
  ) {
    if (state is OwnerAddProductInitial) {
      final currentState = state as OwnerAddProductInitial;
      emit(currentState.copyWith(imagePath: event.imagePath));
    } else if (state is OwnerAddProductFailure) {
      final currentState = state as OwnerAddProductFailure;
      emit(
        OwnerAddProductInitial(
          categories: currentState.categories,
          imagePath: event.imagePath,
          selectedCategory: currentState.selectedCategory,
        ),
      );
    }
  }

  void _onCategorySelected(
    CategorySelected event,
    Emitter<OwnerAddProductState> emit,
  ) {
    if (state is OwnerAddProductInitial) {
      final currentState = state as OwnerAddProductInitial;
      emit(currentState.copyWith(selectedCategory: event.category));
    } else if (state is OwnerAddProductFailure) {
      final currentState = state as OwnerAddProductFailure;
      emit(
        OwnerAddProductInitial(
          categories: currentState.categories,
          imagePath: currentState.imagePath,
          selectedCategory: event.category,
        ),
      );
    }
  }

  Future<void> _onAddProductRequested(
    AddProductRequested event,
    Emitter<OwnerAddProductState> emit,
  ) async {
    // Preserve current selections during loading
    List<ProductCategoryEntity> categories = [];
    String? currentImagePath;
    ProductCategoryEntity? currentCategory;

    if (state is OwnerAddProductInitial) {
      final currentState = state as OwnerAddProductInitial;
      categories = currentState.categories;
      currentImagePath = currentState.imagePath;
      currentCategory = currentState.selectedCategory;
    }

    emit(
      OwnerAddProductLoading(
        categories: categories,
        imagePath: currentImagePath,
        selectedCategory: currentCategory,
      ),
    );

    final result = await usecase.addProduct(
      name: event.name,
      description: event.description,
      price: event.price,
      rewardPts: event.rewardPts,
      categoryId: event.categoryId,
      threshold: event.threshold,
      imagePath: event.imagePath,
    );

    result.fold(
      (failure) => emit(
        OwnerAddProductFailure(
          failure.message,
          categories: categories,
          imagePath: currentImagePath,
          selectedCategory: currentCategory,
        ),
      ),
      (message) => emit(OwnerAddProductSuccess(message)),
    );
  }
}