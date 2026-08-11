
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';
import '../repositories/profile_repositories.dart';
import '../../../core/di/service_locator.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository = getIt<ProfileRepository>();

  ProfileCubit() : super(ProfileInitial());

  // GET PROFILE
  Future<void> getProfile() async {
    emit(ProfileLoading());
    
    try {
      final user = await _profileRepository.getProfile();
      emit(ProfileLoaded(user: user));
    } catch (e) {
      // Try to load from cache
      try {
        final cachedUser = await _profileRepository.getCachedProfile();
        if (cachedUser != null) {
          emit(ProfileLoaded(user: cachedUser));
          return;
        }
      } catch (_) {
        // ignore
      }
      emit(ProfileError(message: e.toString()));
    }
  }

  // UPDATE PROFILE
  Future<void> updateProfile({
    String? fullName,
    String? phoneNumber,
    String? profilePhotoPath,
    String? frontIdPath,
    String? backIdPath,
  }) async {
    emit(ProfileLoading());
    
    try {
      final response = await _profileRepository.updateProfile(
        fullName: fullName,
        phoneNumber: phoneNumber,
        profilePhotoPath: profilePhotoPath,
        frontIdPath: frontIdPath,
        backIdPath: backIdPath,
      );
      
      if (response.success && response.data != null) {
        emit(ProfileUpdated(user: response.data!));
      } else {
        emit(ProfileError(message: response.message));
      }
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  // CLEAR ERROR
  void clearError() {
    if (state is ProfileError) {
      emit(ProfileInitial());
    }
  }

  // RESET STATE
  void reset() {
    emit(ProfileInitial());
  }
}