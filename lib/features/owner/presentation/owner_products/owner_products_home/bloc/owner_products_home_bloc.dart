import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spear_me_app/features/owner/domain/entity/product_category_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/product_entity.dart';
import 'package:spear_me_app/features/owner/domain/usecase/product_usecase.dart';

part 'owner_products_home_event.dart';
part 'owner_products_home_state.dart';

class OwnerProductsHomeBloc
    extends Bloc<OwnerProductsHomeEvent, OwnerProductsHomeState> {
  final ProductsUsecase usecase;

  OwnerProductsHomeBloc(this.usecase) : super(const OwnerProductsHomeState()) {
    on<FetchProductCategories>(_onFetchCategories);
    on<FetchProducts>(_onFetchProducts);
    on<SearchProducts>(
      _onSearchProducts,
      transformer: _debounce(const Duration(milliseconds: 500)),
    );
    on<FilterByCategory>(_onFilterByCategory);
    on<LoadMoreProducts>(
      _onLoadMoreProducts,
      transformer: _throttle(const Duration(seconds: 2)),
    );
    on<AddCategoryEvent>(_onAddCategory);
    on<UpdateCategoryEvent>(_onUpdateCategory);
    on<DeleteCategoryEvent>(_onDeleteCategory);
    on<DeleteProduct>(_onDeleteProduct);
  }

  Future<void> _onAddCategory(
    AddCategoryEvent event,
    Emitter<OwnerProductsHomeState> emit,
  ) async {
    emit(
      state.copyWith(isAddingCategory: true, error: null, successMessage: null),
    );

    final result = await usecase.createCategory(event.name, event.description);

    result.fold(
      (fail) =>
          emit(state.copyWith(isAddingCategory: false, error: fail.message)),
      (success) {
        emit(state.copyWith(isAddingCategory: false, successMessage: success));
        add(FetchProductCategories());
      },
    );
  }

  Future<void> _onUpdateCategory(
    UpdateCategoryEvent event,
    Emitter<OwnerProductsHomeState> emit,
  ) async {
    emit(
      state.copyWith(
        isUpdatingCategory: true,
        error: null,
        successMessage: null,
      ),
    );

    final result = await usecase.updateCategory(
      event.id,
      event.name,
      event.description,
    );

    result.fold(
      (fail) =>
          emit(state.copyWith(isUpdatingCategory: false, error: fail.message)),
      (success) {
        emit(
          state.copyWith(isUpdatingCategory: false, successMessage: success),
        );
        add(FetchProductCategories());
      },
    );
  }

  Future<void> _onDeleteCategory(
    DeleteCategoryEvent event,
    Emitter<OwnerProductsHomeState> emit,
  ) async {
    emit(
      state.copyWith(
        isDeletingCategory: true,
        error: null,
        successMessage: null,
      ),
    );

    final result = await usecase.deleteCategory(event.categoryId);

    result.fold(
      (fail) =>
          emit(state.copyWith(isDeletingCategory: false, error: fail.message)),
      (success) {
        emit(
          state.copyWith(isDeletingCategory: false, successMessage: success),
        );
        add(FetchProductCategories());
        add(const FetchProducts(categoryName: null));
      },
    );
  }

  Future<void> _onFetchCategories(
    FetchProductCategories event,
    Emitter<OwnerProductsHomeState> emit,
  ) async {
    emit(state.copyWith(isLoadingCategories: true, error: null));

    final result = await usecase.getCategories();

    result.fold(
      (fail) =>
          emit(state.copyWith(isLoadingCategories: false, error: fail.message)),
      (categories) => emit(
        state.copyWith(
          isLoadingCategories: false,
          categories: categories,
          error: null,
        ),
      ),
    );
  }

  Future<void> _onFetchProducts(
    FetchProducts event,
    Emitter<OwnerProductsHomeState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        page: 0,
        error: null,
        selectedCategoryName: event.categoryName,
      ),
    );

    final result = await usecase.getProducts(
      search: state.searchKeyword?.isEmpty == true ? null : state.searchKeyword,
      categoryName: event.categoryName,
      page: 0,
      size: state.pageSize,
    );

    result.fold(
      (fail) => emit(state.copyWith(isLoading: false, error: fail.message)),
      (pagedProducts) {
        final products = pagedProducts.content;
        emit(
          state.copyWith(
            isLoading: false,
            products: products,
            page: 0,
            lastPage: products.length < state.pageSize,
            error: null,
          ),
        );
      },
    );
  }

  Future<void> _onSearchProducts(
    SearchProducts event,
    Emitter<OwnerProductsHomeState> emit,
  ) async {
    emit(state.copyWith(searchKeyword: event.query, error: null));
    add(FetchProducts(categoryName: state.selectedCategoryName));
  }

  Future<void> _onFilterByCategory(
    FilterByCategory event,
    Emitter<OwnerProductsHomeState> emit,
  ) async {
    emit(state.copyWith(selectedCategoryName: event.categoryName, error: null));
    add(FetchProducts(categoryName: event.categoryName));
  }

  Future<void> _onLoadMoreProducts(
    LoadMoreProducts event,
    Emitter<OwnerProductsHomeState> emit,
  ) async {
    if (state.lastPage || state.isLoadingMore || state.isLoading) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true, error: null));

    final nextPage = state.page + 1;

    final result = await usecase.getProducts(
      search: state.searchKeyword?.isEmpty == true ? null : state.searchKeyword,
      categoryName: state.selectedCategoryName,
      page: nextPage,
      size: state.pageSize,
    );

    result.fold(
      (fail) => emit(state.copyWith(isLoadingMore: false, error: fail.message)),
      (pagedProducts) {
        final newProducts = pagedProducts.content;
        emit(
          state.copyWith(
            isLoadingMore: false,
            products: [...state.products, ...newProducts],
            page: nextPage,
            lastPage: newProducts.length < state.pageSize,
            error: null,
          ),
        );
      },
    );
  }

  Future<void> _onDeleteProduct(
    DeleteProduct event,
    Emitter<OwnerProductsHomeState> emit,
  ) async {
    emit(state.copyWith(isDeleting: true, deleteError: null));

    final result = await usecase.deleteProduct(event.productId);

    result.fold(
      (fail) =>
          emit(state.copyWith(isDeleting: false, deleteError: fail.message)),
      (message) {
        emit(state.copyWith(isDeleting: false, deleteSuccess: message));
        add(FetchProducts(categoryName: state.selectedCategoryName));
      },
    );
  }

  EventTransformer<E> _debounce<E>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
  }

  EventTransformer<E> _throttle<E>(Duration duration) {
    return (events, mapper) => events.throttleTime(duration).switchMap(mapper);
  }
}
