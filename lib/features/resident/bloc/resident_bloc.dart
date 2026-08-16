
// ignore_for_file: duplicate_import

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_axis/features/auth/models/user_model.dart';
import 'resident_event.dart';
import 'resident_state.dart';
import '../repositories/resident_repository.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/connectivity_service.dart';
import '../../auth/models/user_model.dart';

class ResidentBloc extends Bloc<ResidentEvent, ResidentState> {
  final ResidentRepository _residentRepository = getIt<ResidentRepository>();
  final ConnectivityService _connectivityService = getIt<ConnectivityService>();

  ResidentBloc() : super(ResidentInitial()) {
    on<ResidentCheckStatus>(_onCheckStatus);
    on<ResidentGetProfile>(_onGetProfile);
    on<ResidentUpdateProfile>(_onUpdateProfile);
    on<ResidentChangePassword>(_onChangePassword);
    on<ResidentLogout>(_onLogout);
    on<ResidentClearError>(_onClearError);
  }

  // CHECK STATUS
  Future<void> _onCheckStatus(
    ResidentCheckStatus event,
    Emitter<ResidentState> emit,
  ) async {
    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const ResidentError(message: 'No internet connection.'));
        return;
      }

      final isLoggedIn = await _residentRepository.isLoggedIn();
      if (isLoggedIn) {
        final user = await _residentRepository.getCachedProfile();
        if (user != null) {
          emit(ResidentAuthenticated(user: user));
          return;
        }
        // Try to fetch fresh profile
        add(ResidentGetProfile());
      } else {
        emit(ResidentUnauthenticated());
      }
    } catch (e) {
      emit(ResidentUnauthenticated());
    }
  }

  // GET PROFILE
  Future<void> _onGetProfile(
    ResidentGetProfile event,
    Emitter<ResidentState> emit,
  ) async {
    emit(ResidentLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        final cachedUser = await _residentRepository.getCachedProfile();
        if (cachedUser != null) {
          emit(ResidentProfileLoaded(user: cachedUser));
          return;
        }
        emit(const ResidentError(message: 'No internet connection.'));
        return;
      }

      final user = await _residentRepository.getProfile();
      emit(ResidentProfileLoaded(user: user));
      emit(ResidentAuthenticated(user: user));
    } catch (e) {
      final cachedUser = await _residentRepository.getCachedProfile();
      if (cachedUser != null) {
        emit(ResidentProfileLoaded(user: cachedUser));
      } else {
        emit(ResidentError(message: e.toString()));
      }
    }
  }

  // UPDATE PROFILE
  Future<void> _onUpdateProfile(
    ResidentUpdateProfile event,
    Emitter<ResidentState> emit,
  ) async {
    emit(ResidentLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const ResidentError(message: 'No internet connection.'));
        return;
      }

      final response = await _residentRepository.updateProfile(
        fullName: event.fullName,
        phoneNumber: event.phoneNumber,
        profilePhotoPath: event.profilePhotoPath,
      );

      if (response.success && response.data != null) {
        final dynamic data = response.data!;
        final UserModel user;
        if (data is Map<String, dynamic>) {
          user = UserModel.fromJson(data);
        } else if (data is UserModel) {
          user = data;
        } else {
          throw Exception('Unexpected profile data type');
        }
        emit(ResidentProfileUpdated(user: user));
        emit(ResidentAuthenticated(user: user));
      } else {
        emit(ResidentError(message: response.message));
      }
    } catch (e) {
      emit(ResidentError(message: e.toString()));
    }
  }

  // CHANGE PASSWORD
  Future<void> _onChangePassword(
    ResidentChangePassword event,
    Emitter<ResidentState> emit,
  ) async {
    emit(ResidentLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const ResidentError(message: 'No internet connection.'));
        return;
      }

      final response = await _residentRepository.changePassword(
        oldPassword: event.oldPassword,
        newPassword: event.newPassword,
      );

      if (response.success) {
        emit(ResidentPasswordChanged());
      } else {
        emit(ResidentError(message: response.message));
      }
    } catch (e) {
      emit(ResidentError(message: e.toString()));
    }
  }
  
// LOGOUT
Future<void> _onLogout(
  ResidentLogout event,
  Emitter<ResidentState> emit,
) async {
  try {
    await _residentRepository.logout();
    emit(ResidentLoggedOut());
    emit(ResidentUnauthenticated());
    // The UI will handle navigation in the BlocConsumer listener
  } catch (e) {
    await _residentRepository.clearCache();
    emit(ResidentLoggedOut());
    emit(ResidentUnauthenticated());
  }
}

  // CLEAR ERROR
  void _onClearError(
    ResidentClearError event,
    Emitter<ResidentState> emit,
  ) {
    final currentState = state;
    if (currentState is ResidentError) {
      emit(ResidentInitial());
    }
  }
}