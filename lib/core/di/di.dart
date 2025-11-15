import 'package:get_it/get_it.dart';
import 'package:spear_me_app/core/network/dio_client.dart';
import 'package:spear_me_app/features/authentication/data/data_source/auth_data_source.dart';
import 'package:spear_me_app/features/authentication/data/repo_impl/auth_repo_impl.dart';
import 'package:spear_me_app/features/authentication/domain/repository/auth_repository.dart';
import 'package:spear_me_app/features/authentication/domain/usecase/auth_usecase.dart';
import 'package:spear_me_app/features/authentication/presentation/sign_in/bloc/sign_in_bloc.dart';
import 'package:spear_me_app/features/authentication/presentation/sign_up/bloc/sign_up_bloc.dart';
import 'package:spear_me_app/features/owner/data/data_sources/remote_data_source/merchandise_data_source.dart';
import 'package:spear_me_app/features/owner/data/data_sources/remote_data_source/owner_data_source.dart';
import 'package:spear_me_app/features/owner/data/data_sources/remote_data_source/products_data_source.dart';
import 'package:spear_me_app/features/owner/data/repo_impl/merchandise_repo_impl.dart';
import 'package:spear_me_app/features/owner/data/repo_impl/owner_repo_impl.dart';
import 'package:spear_me_app/features/owner/data/repo_impl/product_repo_impl.dart';
import 'package:spear_me_app/features/owner/domain/repository/merchandise_repository.dart';
import 'package:spear_me_app/features/owner/domain/repository/owner_repository.dart';
import 'package:spear_me_app/features/owner/domain/repository/product_repository.dart';
import 'package:spear_me_app/features/owner/domain/usecase/merchandise_usecase.dart';
import 'package:spear_me_app/features/owner/domain/usecase/owner_usecase.dart';
import 'package:spear_me_app/features/owner/domain/usecase/product_usecase.dart';
import 'package:spear_me_app/features/owner/presentation/owner_central_office/owner_central_office_home/bloc/owner_central_office_home_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_dashboard/bloc/owner_home_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/add_factory/bloc/add_factory_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/create_plant_head/bloc/create_plant_head_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/factory_details/bloc/factory_details_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_merchandise/add_merchandise/bloc/add_merchandise_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_merchandise/merchandise_home/bloc/merchandise_home_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_products/owner_products_home/bloc/owner_products_home_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_profile/bloc/owner_profile_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_tools/tools_home/bloc/tools_bloc.dart';
import 'package:spear_me_app/features/plant_head/data/data_source/add_data_source.dart';
import 'package:spear_me_app/features/plant_head/data/data_source/get_data_source.dart';
import 'package:spear_me_app/features/plant_head/data/repo_impl/add_repo_impl.dart';
import 'package:spear_me_app/features/plant_head/data/repo_impl/get_repo_impl.dart';
import 'package:spear_me_app/features/plant_head/domain/repository/add_repository.dart';
import 'package:spear_me_app/features/plant_head/domain/repository/get_repository.dart';
import 'package:spear_me_app/features/plant_head/domain/usecases/add_usecase.dart';
import 'package:spear_me_app/features/plant_head/domain/usecases/get_usecase.dart';
import 'package:spear_me_app/features/plant_head/presentation/pl_create/bloc/pl_create_bloc.dart';
import 'package:spear_me_app/features/plant_head/presentation/pl_dashboard/pl_products/bloc/pl_products_bloc.dart';
import 'package:spear_me_app/features/plant_head/presentation/pl_employees/bloc/pl_employees_bloc.dart';

final GetIt di = GetIt.instance;

// ignore: avoid_classes_with_only_static_members
class Di {
  static Future<void> init() async {
    //!dioclient
    di.registerLazySingleton(() => DioClient());

    //!data sources
    di.registerLazySingleton(() => AuthDataSource(dioClient: di()));
    di.registerLazySingleton(() => OwnerDataSource(dioClient: di()));
    di.registerLazySingleton(() => ProductsDataSource(di()));
    di.registerLazySingleton(() => AddDataSource(di()));
    di.registerLazySingleton(() => GetDataSource(di()));
    di.registerLazySingleton(() => MerchandiseDataSource(di()));

    //! Repositories

    di.registerLazySingleton<AuthRepository>(
      () => AuthRepoImpl(authDataSource: di()),
    );
    di.registerLazySingleton<OwnerRepository>(
      () => OwnerRepoImpl(ownerDataSource: di()),
    );
    di.registerLazySingleton<ProductsRepository>(
      () => ProductsRepositoryImpl(di()),
    );
    di.registerLazySingleton<AddRepository>(() => AddRepositoryImpl(di()));
    di.registerLazySingleton<GetRepository>(() => GetRepoImpl(di()));
    di.registerLazySingleton<MerchandiseRepository>(
      () => MerchandiseRepositoryImpl(di()),
    );

    //! usecases
    di.registerLazySingleton(() => AuthUsecase(authRepository: di()));
    di.registerLazySingleton(() => OwnerUsecase(ownerRepository: di()));
    di.registerLazySingleton(() => ProductsUsecase(di()));
    di.registerLazySingleton(() => AddUsecase(di()));
    di.registerLazySingleton(() => GetUsecase(di()));
    di.registerLazySingleton(() => MerchandiseUsecase(di()));

    //! bloc
    di.registerCachedFactory(() => SignInBloc(di()));
    di.registerCachedFactory(() => OwnerHomeBloc());
    di.registerCachedFactory(() => SignUpBloc(di()));
    di.registerCachedFactory(
      () => OwnerCentralOfficeHomeBloc(ownerUsecase: di()),
    );
    di.registerCachedFactory(() => AddFactoryBloc(di()));
    di.registerCachedFactory(() => CreatePlantHeadBloc(usecase: di()));
    di.registerCachedFactory(() => OwnerProductsHomeBloc(di()));
    di.registerCachedFactory(() => PlCreateBloc(di()));
    di.registerCachedFactory(() => PlEmployeesBloc(di()));
    di.registerCachedFactory(() => OwnerProfileBloc(di(), di()));
    di.registerCachedFactory(() => PlProductsBloc(di()));
    di.registerCachedFactory(() => MerchandiseHomeBloc(usecase: di()));
    di.registerCachedFactory(() => AddMerchandiseBloc(di()));
    di.registerCachedFactory(() => ToolsBloc(di()));
    di.registerCachedFactory(
      () => FactoryDetailsBloc(getFactoryDetailsUsecase: di()),
    );
  }
}
