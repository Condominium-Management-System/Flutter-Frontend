
import 'package:equatable/equatable.dart';
import '../../auth/models/user_model.dart';

abstract class ResidentState extends Equatable {
  const ResidentState();

  @override
  List<Object?> get props => [];
}

// INITIAL STATE

class ResidentInitial extends ResidentState {}

// LOADING STATE

class ResidentLoading extends ResidentState {}

// PROFILE STATES

class ResidentProfileLoaded extends ResidentState {
  final UserModel user;

  const ResidentProfileLoaded({required this.user});

  @override
  List<Object?> get props => [user];
}

class ResidentProfileUpdated extends ResidentState {
  final UserModel user;

  const ResidentProfileUpdated({required this.user});

  @override
  List<Object?> get props => [user];
}

class ResidentPasswordChanged extends ResidentState {}

// AUTHENTICATED STATE

class ResidentAuthenticated extends ResidentState {
  final UserModel user;

  const ResidentAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

// UNAUTHENTICATED STATE

class ResidentUnauthenticated extends ResidentState {}

// LOGGED OUT STATE

class ResidentLoggedOut extends ResidentState {}

// ERROR STATE

class ResidentError extends ResidentState {
  final String message;

  const ResidentError({required this.message});

  @override
  List<Object?> get props => [message];
}