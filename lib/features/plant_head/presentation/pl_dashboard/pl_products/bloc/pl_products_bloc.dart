import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spear_me_app/features/owner/domain/entity/product_entity.dart';
import 'package:spear_me_app/features/plant_head/domain/usecases/get_usecase.dart';

part 'pl_products_event.dart';
part 'pl_products_state.dart';

class PlProductsBloc extends Bloc<PlProductsEvent, PlProductsState> {
  final GetUsecase getUsecase;
  PlProductsBloc(this.getUsecase) : super(PlProductsInitial()) {
    on<FetchProductsPlantHead>(fetchProductsPlantHead);
    // on<LowStockProductsPlantHead>(lowStockProductsPlantHead);
    // on<FetchProductsPlantHead>(fetchProductsPlantHead);
  }

  Future<void> fetchProductsPlantHead(
    FetchProductsPlantHead event,
    Emitter<PlProductsState> emit,
  ) async {
    emit(PlLoadingState());
    final result = await getUsecase.getProducts();

    return result.fold(
      (fail) => emit(PlErrorState(message: fail.message)),
      (List<ProductEntity> products) => emit(PlLoadedState(products: products)),
    );
  }

  // Future<void> lowStockProductsPlantHead(
  //   LowStockProductsPlantHead event,
  //   Emitter<PlProductsState> emit,
  // ) async{
  //     final result = await getUsecase.getProducts();

  //   return result.fold(
  //     (fail) => emit,
  //     (List<ProductEntity> products) => emit(PlLoadedState(products: products)),
  //   );
  // }
}
