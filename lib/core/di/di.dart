import 'package:get_it/get_it.dart';
import 'package:spear_me_app/features/authentication/presentation/sign_in/bloc/sign_in_bloc.dart';
import 'package:spear_me_app/features/authentication/presentation/sign_up/bloc/sign_up_bloc.dart';
import 'package:spear_me_app/features/owner/presentation/owner_dashboard/bloc/owner_home_bloc.dart';

final GetIt di = GetIt.instance;

// ignore: avoid_classes_with_only_static_members
class Di {
  static Future<void> init() async {
    di.registerCachedFactory(() => SignInBloc());
    di.registerCachedFactory(() => OwnerHomeBloc());
    di.registerCachedFactory(() => SignUpBloc());
    
  }
}
