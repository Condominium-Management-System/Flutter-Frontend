
import 'package:get_it/get_it.dart';
import '../bloc/auth_bloc.dart';
import '../cubits/login_cubit.dart';
import '../cubits/register_cubit.dart';
import '../cubits/forgot_password_cubit.dart';
import '../cubits/reset_password_cubit.dart';
import '../cubits/profile_cubit.dart';

final GetIt getIt = GetIt.instance;

class AuthDependencies {
  static void register() {
    // BLoC
    getIt.registerFactory<AuthBloc>(() => AuthBloc());
    
    // Cubits
    getIt.registerFactory<LoginCubit>(() => LoginCubit());
    getIt.registerFactory<RegisterCubit>(() => RegisterCubit());
    getIt.registerFactory<ForgotPasswordCubit>(() => ForgotPasswordCubit());
    getIt.registerFactory<ResetPasswordCubit>(() => ResetPasswordCubit());
    getIt.registerFactory<ProfileCubit>(() => ProfileCubit());
  }
}