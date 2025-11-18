import 'package:get_it/get_it.dart';
import 'package:spear_me_app/core/network/dio_client.dart';

import 'package:spear_me_app/features/authentication/data/data_source/auth_data_source.dart';
import 'package:spear_me_app/features/authentication/data/repo_impl/auth_repo_impl.dart';
import 'package:spear_me_app/features/authentication/domain/repository/auth_repository.dart';
import 'package:spear_me_app/features/authentication/domain/usecase/auth_usecase.dart';
import 'package:spear_me_app/features/authentication/presentation/sign_in/bloc/sign_in_bloc.dart';
import 'package:spear_me_app/features/authentication/presentation/sign_up/bloc/sign_up_bloc.dart';

import 'package:spear_me_app/features/owner/data/data_sources/remote_data_source/owner_data_source.dart';
import 'package:spear_me_app/features/owner/data/repo_impl/owner_repo_impl.dart';
import 'package:spear_me_app/features/owner/domain/repository/owner_repository.dart';
import 'package:spear_me_app/features/owner/domain/usecase/owner_usecase.dart';
import 'package:spear_me_app/features/owner/domain/usecase/tools_usecase.dart';
import 'package:spear_me_app/features/owner/presentation/owner_dashboard/bloc/owner_home_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/add_factory/bloc/add_factory_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/create_plant_head/bloc/create_plant_head_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/factory_details/bloc/factory_details_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_factories/factory_home/bloc/owner_factories_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_central_office/owner_central_office_home/bloc/owner_central_office_home_bloc.dart';

import 'package:spear_me_app/features/owner/data/data_sources/remote_data_source/products_data_source.dart';
import 'package:spear_me_app/features/owner/data/repo_impl/product_repo_impl.dart';
import 'package:spear_me_app/features/owner/domain/repository/product_repository.dart';
import 'package:spear_me_app/features/owner/domain/usecase/product_usecase.dart';
import 'package:spear_me_app/features/owner/presentation/owner_products/owner_products_home/bloc/owner_products_home_bloc.dart';

import 'package:spear_me_app/features/owner/presentation/owner_tools/tools_home/bloc/tools_bloc.dart';

import 'package:spear_me_app/features/owner/data/data_sources/remote_data_source/merchandise_data_source.dart';
import 'package:spear_me_app/features/owner/data/repo_impl/merchandise_repo_impl.dart';
import 'package:spear_me_app/features/owner/domain/repository/merchandise_repository.dart';
import 'package:spear_me_app/features/owner/domain/usecase/merchandise_usecase.dart';
import 'package:spear_me_app/features/owner/presentation/owner_merchandise/add_merchandise/bloc/add_merchandise_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_merchandise/merchandise_home/bloc/merchandise_home_bloc.dart';

import 'package:spear_me_app/features/plant_head/data/data_source/add_data_source.dart';
import 'package:spear_me_app/features/plant_head/data/data_source/get_data_source.dart';
import 'package:spear_me_app/features/plant_head/data/repo_impl/add_repo_impl.dart';
import 'package:spear_me_app/features/plant_head/data/repo_impl/get_repo_impl.dart';
import 'package:spear_me_app/features/plant_head/domain/repository/add_repository.dart';
import 'package:spear_me_app/features/plant_head/domain/repository/get_repository.dart';
import 'package:spear_me_app/features/plant_head/domain/usecases/add_usecase.dart';
import 'package:spear_me_app/features/plant_head/domain/usecases/get_usecase.dart';
import 'package:spear_me_app/features/plant_head/presentation/pl_create/bloc/pl_create_bloc.dart';
import 'package:spear_me_app/features/plant_head/presentation/pl_employees/bloc/pl_employees_bloc.dart';
import 'package:spear_me_app/features/plant_head/presentation/pl_dashboard/pl_products/bloc/pl_products_bloc.dart';

import 'package:spear_me_app/features/owner/presentation/owner_profile/bloc/owner_profile_bloc.dart';

final GetIt di = GetIt.instance;

class Di {
  static Future<void> init() async {
    //! DIO CLIENT
    di.registerLazySingleton<DioClient>(() => DioClient());

    //! DATA SOURCES
    di.registerLazySingleton<AuthDataSource>(
      () => AuthDataSource(dioClient: di<DioClient>()),
    );

    di.registerLazySingleton<OwnerDataSource>(
      () => OwnerDataSource(dioClient: di<DioClient>()),
    );

    di.registerLazySingleton<ProductsDataSource>(
      () => ProductsDataSource(di<DioClient>()),
    );

    di.registerLazySingleton<AddDataSource>(
      () => AddDataSource(di<DioClient>()),
    );

    di.registerLazySingleton<GetDataSource>(
      () => GetDataSource(di<DioClient>()),
    );

    di.registerLazySingleton<MerchandiseDataSource>(
      () => MerchandiseDataSource(di<DioClient>()),
    );

    //! REPOSITORIES
    di.registerLazySingleton<AuthRepository>(
      () => AuthRepoImpl(authDataSource: di<AuthDataSource>()),
    );

    di.registerLazySingleton<OwnerRepository>(
      () => OwnerRepoImpl(ownerDataSource: di<OwnerDataSource>()),
    );

    di.registerLazySingleton<ProductsRepository>(
      () => ProductsRepositoryImpl(di<ProductsDataSource>()),
    );

    di.registerLazySingleton<AddRepository>(
      () => AddRepositoryImpl(di<AddDataSource>()),
    );

    di.registerLazySingleton<GetRepository>(
      () => GetRepoImpl(di<GetDataSource>()),
    );

    di.registerLazySingleton<MerchandiseRepository>(
      () => MerchandiseRepositoryImpl(di<MerchandiseDataSource>()),
    );

    //! USECASES
    di.registerLazySingleton<AuthUsecase>(
      () => AuthUsecase(authRepository: di<AuthRepository>()),
    );

    di.registerLazySingleton<OwnerUsecase>(
      () => OwnerUsecase(ownerRepository: di<OwnerRepository>()),
    );

    di.registerLazySingleton<ProductsUsecase>(
      () => ProductsUsecase(di<ProductsRepository>()),
    );

    di.registerLazySingleton<AddUsecase>(() => AddUsecase(di<AddRepository>()));

    di.registerLazySingleton<GetUsecase>(() => GetUsecase(di<GetRepository>()));

    di.registerLazySingleton<MerchandiseUsecase>(
      () => MerchandiseUsecase(di<MerchandiseRepository>()),
    );
    //! BLOC
    di.registerFactory<SignInBloc>(() => SignInBloc(di<AuthUsecase>()));
    di.registerFactory<SignUpBloc>(() => SignUpBloc(di<AuthUsecase>()));

    di.registerFactory<OwnerHomeBloc>(() => OwnerHomeBloc());

    di.registerFactory<OwnerCentralOfficeHomeBloc>(
      () => OwnerCentralOfficeHomeBloc(ownerUsecase: di<OwnerUsecase>()),
    );

    di.registerFactory<OwnerFactoriesBloc>(
      () => OwnerFactoriesBloc(usecase: di<OwnerUsecase>()),
    );

    di.registerFactory<AddFactoryBloc>(
      () => AddFactoryBloc(di<OwnerUsecase>()),
    );

    di.registerFactory<CreatePlantHeadBloc>(
      () => CreatePlantHeadBloc(usecase: di<OwnerUsecase>()),
    );

    di.registerFactory<FactoryDetailsBloc>(
      () => FactoryDetailsBloc(usecase: di<OwnerUsecase>()),
    );

    di.registerFactory<OwnerProductsHomeBloc>(
      () => OwnerProductsHomeBloc(di<ProductsUsecase>()),
    );

    di.registerFactory<ToolsBloc>(() => ToolsBloc(di<ToolUsecase>()));

    di.registerFactory<PlCreateBloc>(() => PlCreateBloc(di<AddUsecase>()));
    di.registerFactory<PlEmployeesBloc>(
      () => PlEmployeesBloc(di<GetUsecase>()),
    );
    di.registerFactory<PlProductsBloc>(() => PlProductsBloc(di<GetUsecase>()));

    di.registerFactory<OwnerProfileBloc>(
      () => OwnerProfileBloc(di<OwnerUsecase>(), di<AuthUsecase>()),
    );

    di.registerFactory<MerchandiseHomeBloc>(
      () => MerchandiseHomeBloc(usecase: di<MerchandiseUsecase>()),
    );

    di.registerFactory<AddMerchandiseBloc>(
      () => AddMerchandiseBloc(di<MerchandiseUsecase>()),
    );
  }
}
