
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_axis/features/auth/models/register_model.dart';
import '../repositories/register_repositories.dart';
import '../../../core/di/service_locator.dart';

// Local minimal register state definitions (replace missing/incorrect import)
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterError extends RegisterState {
  final String? message;
  RegisterError({this.message});
}

class RegisterSuccess extends RegisterState {
  final dynamic data;

  RegisterSuccess({required this.data});
}

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepository _registerRepository = getIt<RegisterRepository>();

  RegisterCubit() : super(RegisterInitial());

  // REGISTER
  Future<void> register({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String fan,
    required String password,
    required String condoCode,
  }) async {
    emit(RegisterLoading());
    
    try {
      final request = RegisterRequest(
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        fan: fan,
        password: password,
        condoCode: condoCode,
      );
      
      final response = await _registerRepository.register(request);
      
      if (response.success && response.data != null) {
        emit(RegisterSuccess(data: response.data!));
      } else {
        emit(RegisterError(message: response.message));
      }
    } catch (e) {
      emit(RegisterError(message: e.toString()));
    }
  }

  // CLEAR ERROR
  void clearError() {
    if (state is RegisterError) {
      emit(RegisterInitial());
    }
  }

  // RESET STATE
  void reset() {
    emit(RegisterInitial());
  }
}