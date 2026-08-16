
import 'package:equatable/equatable.dart';

abstract class ResidentEvent extends Equatable {
  const ResidentEvent();

  @override
  List<Object?> get props => [];
}

// PROFILE EVENTS

class ResidentGetProfile extends ResidentEvent {}

class ResidentUpdateProfile extends ResidentEvent {
  final String? fullName;
  final String? phoneNumber;
  final String? profilePhotoPath;

  const ResidentUpdateProfile({
    this.fullName,
    this.phoneNumber,
    this.profilePhotoPath,
  });

  @override
  List<Object?> get props => [fullName, phoneNumber, profilePhotoPath];
}

class ResidentChangePassword extends ResidentEvent {
  final String oldPassword;
  final String newPassword;

  const ResidentChangePassword({
    required this.oldPassword,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [oldPassword, newPassword];
}

// SESSION EVENTS
class ResidentLogout extends ResidentEvent {}

class ResidentCheckStatus extends ResidentEvent {}

// ERROR EVENTS

class ResidentClearError extends ResidentEvent {}