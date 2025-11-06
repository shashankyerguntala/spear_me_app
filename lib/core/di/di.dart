import 'package:get_it/get_it.dart';
import 'package:spear_me_app/core/network/dio_client.dart';
import 'package:spear_me_app/features/authentication/data/data_source/auth_data_source.dart';
import 'package:spear_me_app/features/authentication/data/repo_impl/auth_repo_impl.dart';
import 'package:spear_me_app/features/authentication/domain/repository/auth_repository.dart';
import 'package:spear_me_app/features/authentication/domain/usecase/auth_usecase.dart';
import 'package:spear_me_app/features/authentication/presentation/sign_in/bloc/sign_in_bloc.dart';
import 'package:spear_me_app/features/authentication/presentation/sign_up/bloc/sign_up_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_dashboard/bloc/owner_home_bloc.dart';

final GetIt di = GetIt.instance;

// ignore: avoid_classes_with_only_static_members
class Di {
  static Future<void> init() async {
    //!dioclient
    di.registerLazySingleton(() => DioClient());

    //!data sources
    di.registerLazySingleton(() => AuthDataSource(dioClient: di()));

    //! Repositories

    di.registerLazySingleton<AuthRepository>(
      () => AuthRepoImpl(authDataSource: di()),
    );

    //! usecases
    di.registerLazySingleton(() => AuthUsecase(authRepository: di()));
    //! bloc
    di.registerCachedFactory(() => SignInBloc(di()));
    di.registerCachedFactory(() => OwnerHomeBloc());
    di.registerCachedFactory(() => SignUpBloc(di()));
  }
}
