import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spear_me_app/features/owner/domain/entity/product_category_entity.dart';
import 'package:spear_me_app/features/owner/domain/entity/paged_products_entity.dart';
import 'package:spear_me_app/features/owner/domain/usecase/product_usecase.dart';

part 'owner_products_home_event.dart';
part 'owner_products_home_state.dart';

class OwnerProductsHomeBloc
    extends Bloc<OwnerProductsHomeEvent, OwnerProductsHomeState> {
  final ProductsUsecase usecase;

  String? _currentSearch;
  String? _currentCategory;
  int _currentPage = 0;

  OwnerProductsHomeBloc(this.usecase) : super(const OwnerProductsHomeState()) {
    on<FetchProductCategories>(_onFetchCategories);
    on<FetchProducts>(_onFetchProducts);
    on<DeleteProduct>(_onDeleteProduct);
  }

  Future<void> _onFetchCategories(
    FetchProductCategories event,
    Emitter<OwnerProductsHomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await usecase.getCategories();

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (categories) =>
          emit(state.copyWith(isLoading: false, categories: categories)),
    );
  }

  Future<void> _onFetchProducts(
    FetchProducts event,
    Emitter<OwnerProductsHomeState> emit,
  ) async {
    _currentSearch = event.search;
    _currentCategory = event.categoryName;
    _currentPage = event.page;

    emit(state.copyWith(isLoading: true));

    final result = await usecase.getProducts(
      search: event.search,
      categoryName: event.categoryName,
      page: event.page,
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (products) => emit(state.copyWith(isLoading: false, products: products)),
    );
  }

  Future<void> _onDeleteProduct(
    DeleteProduct event,
    Emitter<OwnerProductsHomeState> emit,
  ) async {
    emit(state.copyWith(isDeleting: true));

    final result = await usecase.deleteProduct(event.productId);

    result.fold(
      (failure) =>
          emit(state.copyWith(isDeleting: false, deleteError: failure.message)),
      (message) async {
        emit(state.copyWith(isDeleting: false, deleteSuccess: message));

        add(
          FetchProducts(
            search: _currentSearch,
            categoryName: _currentCategory,
            page: _currentPage,
          ),
        );
      },
    );
  }
}
