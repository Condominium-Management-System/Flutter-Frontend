
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_axis/features/auth/models/forgot_password_model.dart';
import 'forgot_password_state.dart';
import '../repositories/password_repositories.dart';
import '../../../core/di/service_locator.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final PasswordRepository _passwordRepository = getIt<PasswordRepository>();

  ForgotPasswordCubit() : super(ForgotPasswordInitial());

  // FORGOT PASSWORD
  Future<void> forgotPassword(String email) async {
    emit(ForgotPasswordLoading());
    
    try {
      final request = ForgotPasswordRequest(email: email);
      final response = await _passwordRepository.forgotPassword(request);
      
      if (response.success) {
        emit(ForgotPasswordSuccess(response: response));
      } else {
        emit(ForgotPasswordError(message: response.message));
      }
    } catch (e) {
      emit(ForgotPasswordError(message: e.toString()));
    }
  }

  // CLEAR ERROR
  void clearError() {
    if (state is ForgotPasswordError) {
      emit(ForgotPasswordInitial());
    }
  }

  // RESET STATE
  void reset() {
    emit(ForgotPasswordInitial());
  }
}