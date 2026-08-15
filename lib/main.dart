
// ignore_for_file: unused_import, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/di/service_locator.dart' hide getIt;
import 'features/auth/auth.dart';
import 'features/auth/config/auth_routes.dart';
import 'features/auth/config/auth_theme.dart';
import 'shared/theme/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize service locator
  await setupServiceLocator();

  // Register auth dependencies
  AuthDependencies.register();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => getIt<AuthBloc>()..add(AuthCheckStatus()),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => getIt<LoginCubit>(),
        ),
        BlocProvider<RegisterCubit>(
          create: (context) => getIt<RegisterCubit>(),
        ),
        BlocProvider<ForgotPasswordCubit>(
          create: (context) => getIt<ForgotPasswordCubit>(),
        ),
        BlocProvider<ResetPasswordCubit>(
          create: (context) => getIt<ResetPasswordCubit>(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => getIt<ProfileCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'YE KONDOMINIUM',
        debugShowCheckedModeBanner: false,
        theme: AuthTheme.darkTheme,
        home: const SplashScreen(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case AuthRoutes.login:
              return MaterialPageRoute(
                builder: (_) => const LoginScreen(),
              );
            case AuthRoutes.register:
              return MaterialPageRoute(
                builder: (_) => const RegisterScreen(),
              );
            case AuthRoutes.forgotPassword:
              return MaterialPageRoute(
                builder: (_) => const ForgotPasswordScreen(),
              );
            case AuthRoutes.resetPassword:
              final token = settings.arguments as String? ?? '';
              return MaterialPageRoute(
                builder: (_) => ResetPasswordScreen(token: token),
              );
            case AuthRoutes.profile:
              return MaterialPageRoute(
                builder: (_) => const ProfileScreen(),
              );
            case AuthRoutes.editProfile:
              return MaterialPageRoute(
                builder: (_) => const EditProfileScreen(),
              );
            case AuthRoutes.changePassword:
              return MaterialPageRoute(
                builder: (_) => const ChangePasswordScreen(),
              );
            default:
              return null;
          }
        },
      ),
    );
  }
}