// ============================================
// FILE: lib/core/di/service_locator.dart
// PURPOSE: Service locator for dependency injection
// ============================================

// ignore_for_file: unnecessary_import

import 'package:get_it/get_it.dart';
import '../storage/secure_storage.dart';
import '../storage/shared_prefs.dart';
import '../services/auth_service.dart';
import '../services/token_service.dart';
import '../services/connectivity_service.dart';
import '../services/validation_service.dart';

// IMPORT SERVICES (API)
import '../../features/auth/services/auth_api_service.dart';
import '../../features/auth/services/login_api_service.dart';
import '../../features/auth/services/register_api_service.dart';
import '../../features/auth/services/password_api_service.dart';
import '../../features/auth/services/profile_api_service.dart';

// IMPORT REPOSITORIES
import '../../features/auth/auth.dart';
import '../../features/auth/repositories/auth_repository.dart';
import '../../features/auth/repositories/login_repositories.dart';
import '../../features/auth/repositories/register_repositories.dart';
import '../../features/auth/repositories/password_repositories.dart';
import '../../features/auth/repositories/profile_repositories.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // STORAGE
  await SharedPrefs.init();
  getIt.registerLazySingleton<SecureStorage>(() => SecureStorage());
  getIt.registerLazySingleton<SharedPrefs>(() => SharedPrefs());

  // CORE SERVICES
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<TokenService>(() => TokenService());
  getIt.registerLazySingleton<ConnectivityService>(() => ConnectivityService());
  getIt.registerLazySingleton<ValidationService>(() => ValidationService());

  // API SERVICES
  getIt.registerLazySingleton<AuthApiService>(() => AuthApiService());
  getIt.registerLazySingleton<LoginApiService>(() => LoginApiService());
  getIt.registerLazySingleton<RegisterApiService>(() => RegisterApiService());
  getIt.registerLazySingleton<PasswordApiService>(() => PasswordApiService());
  getIt.registerLazySingleton<ProfileApiService>(() => ProfileApiService());

  // REPOSITORIES
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());
  getIt.registerLazySingleton<LoginRepository>(() => LoginRepository());
  getIt.registerLazySingleton<RegisterRepository>(() => RegisterRepository());
  getIt.registerLazySingleton<PasswordRepository>(() => PasswordRepository());
  getIt.registerLazySingleton<ProfileRepository>(() => ProfileRepository());
}