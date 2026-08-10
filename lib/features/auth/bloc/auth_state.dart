
import 'package:equatable/equatable.dart';
import '../models/user_model.dart';
import '../models/login_model.dart';
import '../models/register_model.dart';
import '../models/forgot_password_model.dart';
import '../models/reset_password_model.dart';
import '../models/change_password_model.dart';
import '../models/profile_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}
// INITIAL STATE

class AuthInitial extends AuthState {}

// LOADING STATES

class AuthLoading extends AuthState {}

// AUTH STATES

class AuthAuthenticated extends AuthState {
  final UserModel user;

  const AuthAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

// LOGIN STATES

class AuthLoginSuccess extends AuthState {
  final LoginData data;

  const AuthLoginSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

// REGISTER STATES
class AuthRegisterSuccess extends AuthState {
  final RegisterData data;

  const AuthRegisterSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

// PASSWORD STATES

class AuthForgotPasswordSuccess extends AuthState {
  final ForgotPasswordResponse response;

  const AuthForgotPasswordSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

class AuthResetPasswordSuccess extends AuthState {
  final ResetPasswordResponse response;

  const AuthResetPasswordSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

class AuthChangePasswordSuccess extends AuthState {
  final ChangePasswordResponse response;

  const AuthChangePasswordSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

// PROFILE STATES

class AuthProfileLoaded extends AuthState {
  final UserModel user;

  const AuthProfileLoaded({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthProfileUpdated extends AuthState {
  final ProfileUpdateResponse response;

  const AuthProfileUpdated({required this.response});

  @override
  List<Object?> get props => [response];
}

// TOKEN STATES

class AuthTokenRefreshed extends AuthState {
  final String accessToken;

  const AuthTokenRefreshed({required this.accessToken});

  @override
  List<Object?> get props => [accessToken];
}

// LOGOUT STATE

class AuthLoggedOut extends AuthState {}

// ERROR STATE
class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}