
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_axis/features/auth/models/login_model.dart';
import 'login_state.dart';
import '../repositories/login_repositories.dart';
import '../../../core/di/service_locator.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _loginRepository = getIt<LoginRepository>();

  LoginCubit() : super(LoginInitial());
  // LOGIN
  Future<void> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    emit(LoginLoading());
    
    try {
      final request = LoginRequest(
        email: email,
        password: password,
      );
      
      final response = await _loginRepository.login(request);
      
      if (response.success && response.data != null) {
        // Save remember me preference
        await _loginRepository.setRememberMe(rememberMe);
        
        if (rememberMe) {
          await _loginRepository.saveCredentials(email, password);
        } else {
          await _loginRepository.clearCredentials();
        }
        
        emit(LoginSuccess(data: response.data!));
      } else {
        emit(LoginError(message: response.message));
      }
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }

  // CHECK REMEMBER ME
  Future<void> loadSavedCredentials() async {
    final credentials = await _loginRepository.getCredentials();
    final rememberMe = await _loginRepository.getRememberMe();
    
    if (rememberMe && credentials['email']!.isNotEmpty) {
      emit(LoginRememberMeLoaded(
        email: credentials['email']!,
        password: credentials['password']!,
        rememberMe: true,
      ));
    }
  }

  // LOGOUT
  Future<void> logout() async {
    await _loginRepository.logout();
    emit(LoginInitial());
  }

  // CLEAR ERROR
  void clearError() {
    if (state is LoginError) {
      emit(LoginInitial());
    }
  }
}