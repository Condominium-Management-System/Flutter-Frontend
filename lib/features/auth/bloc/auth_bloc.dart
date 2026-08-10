
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../repositories/auth_repository.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/connectivity_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = getIt<AuthRepository>();
  final AuthService _authService = getIt<AuthService>();
  final ConnectivityService _connectivityService = getIt<ConnectivityService>();

  AuthBloc() : super(AuthInitial()) {
    on<AuthCheckStatus>(_onCheckStatus);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthRefreshTokenRequested>(_onRefreshTokenRequested);
    on<AuthForgotPasswordRequested>(_onForgotPasswordRequested);
    on<AuthResetPasswordRequested>(_onResetPasswordRequested);
    on<AuthChangePasswordRequested>(_onChangePasswordRequested);
    on<AuthGetProfileRequested>(_onGetProfileRequested);
    on<AuthUpdateProfileRequested>(_onUpdateProfileRequested);
    on<AuthClearError>(_onClearError);
  }

  // CHECK AUTH STATUS
  Future<void> _onCheckStatus(
    AuthCheckStatus event,
    Emitter<AuthState> emit,
  ) async {
    try {
      // Check internet connection
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const AuthError(message: 'No internet connection.'));
        return;
      }

      final isLoggedIn = await _authRepository.isLoggedIn();
      
      if (isLoggedIn) {
        final user = await _authRepository.getUser();
        if (user != null) {
          emit(AuthAuthenticated(user: user));
          return;
        }
      }
      
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthUnauthenticated());
    }
  }

  // LOGIN
  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    try {
      // Check internet connection
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const AuthError(message: 'No internet connection.'));
        return;
      }

      final response = await _authRepository.login(event.request);
      
      if (response.success && response.data != null) {
        // Save remember me preference
        await _authRepository.setRememberMe(event.rememberMe);
        
        if (event.rememberMe) {
          await _authRepository.saveCredentials(
            event.request.email,
            event.request.password,
          );
        } else {
          await _authRepository.clearCredentials();
        }
        
        emit(AuthLoginSuccess(data: response.data!));
        emit(AuthAuthenticated(user: response.data!.user));
      } else {
        emit(AuthError(message: response.message));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // REGISTER
  Future<void> _onRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const AuthError(message: 'No internet connection.'));
        return;
      }

      final response = await _authRepository.register(event.request);
      
      if (response.success && response.data != null) {
        emit(AuthRegisterSuccess(data: response.data!));
      } else {
        emit(AuthError(message: response.message));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // LOGOUT
  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _authRepository.logout();
      emit(AuthLoggedOut());
      emit(AuthUnauthenticated());
    } catch (e) {
      // Even if logout fails, clear local state
      await _authService.logout();
      emit(AuthLoggedOut());
      emit(AuthUnauthenticated());
    }
  }

  // REFRESH TOKEN
  Future<void> _onRefreshTokenRequested(
    AuthRefreshTokenRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final newToken = await _authRepository.refreshToken(event.refreshToken);
      if (newToken != null) {
        emit(AuthTokenRefreshed(accessToken: newToken));
      } else {
        emit(const AuthError(message: 'Failed to refresh token.'));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // FORGOT PASSWORD
  Future<void> _onForgotPasswordRequested(
    AuthForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const AuthError(message: 'No internet connection.'));
        return;
      }

      final response = await _authRepository.forgotPassword(event.request);
      
      if (response.success) {
        emit(AuthForgotPasswordSuccess(response: response));
      } else {
        emit(AuthError(message: response.message));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // RESET PASSWORD
  Future<void> _onResetPasswordRequested(
    AuthResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const AuthError(message: 'No internet connection.'));
        return;
      }

      final response = await _authRepository.resetPassword(event.request);
      
      if (response.success) {
        emit(AuthResetPasswordSuccess(response: response));
      } else {
        emit(AuthError(message: response.message));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // CHANGE PASSWORD
  Future<void> _onChangePasswordRequested(
    AuthChangePasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const AuthError(message: 'No internet connection.'));
        return;
      }

      emit(const AuthError(message: 'Change password is not available yet.'));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // GET PROFILE
  Future<void> _onGetProfileRequested(
    AuthGetProfileRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        final cachedUser = await _authRepository.getUser();
        if (cachedUser != null) {
          emit(AuthProfileLoaded(user: cachedUser));
          return;
        }
        emit(const AuthError(message: 'No internet connection.'));
        return;
      }

      final user = await _authRepository.getUser();
      if (user != null) {
        emit(AuthProfileLoaded(user: user));
      } else {
        emit(const AuthError(message: 'Profile not found.'));
      }
    } catch (e) {
      // Try to load from cache
      final cachedUser = await _authRepository.getUser();
      if (cachedUser != null) {
        emit(AuthProfileLoaded(user: cachedUser));
      } else {
        emit(AuthError(message: e.toString()));
      }
    }
  }

  // UPDATE PROFILE
  Future<void> _onUpdateProfileRequested(
    AuthUpdateProfileRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const AuthError(message: 'No internet connection.'));
        return;
      }
      
      emit(const AuthError(message: 'Profile update is not available yet.'));
      return;
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }


  // CLEAR ERROR
  void _onClearError(
    AuthClearError event,
    Emitter<AuthState> emit,
  ) {
    // Re-emit current state without error
    final currentState = state;
    if (currentState is AuthError) {
      emit(AuthInitial());
    } else {
      emit(currentState);
    }
  }
}