
// ignore_for_file: unused_import

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_axis/features/auth/cubits/register_state.dart';
import 'package:home_axis/features/auth/models/reset_password_model.dart';
import 'reset_password_state.dart';
import '../repositories/password_repositories.dart';
import '../../../core/di/service_locator.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final PasswordRepository _passwordRepository = getIt<PasswordRepository>();

  ResetPasswordCubit() : super(ResetPasswordInitial());

  // RESET PASSWORD
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    emit(ResetPasswordLoading());
    
    try {
      final request = ResetPasswordRequest(
        token: token,
        password: newPassword,
      );
      
      final response = await _passwordRepository.resetPassword(request);
      
      if (response.success) {
        emit(ResetPasswordSuccess(response: response));
      } else {
        emit(ResetPasswordError(message: response.message));
      }
    } catch (e) {
      emit(ResetPasswordError(message: e.toString()));
    }
  }

  // CLEAR ERROR
  void clearError() {
    if (state is ResetPasswordError) {
      emit(ResetPasswordInitial());
    }
  }

  // RESET STATE
  void reset() {
    emit(ResetPasswordInitial());
  }
}