
import 'package:equatable/equatable.dart';
import '../models/login_model.dart';
import '../models/register_model.dart';
import '../models/forgot_password_model.dart';
import '../models/reset_password_model.dart';
import '../models/change_password_model.dart';
import '../models/profile_model.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

// AUTH EVENTS

class AuthLoginRequested extends AuthEvent {
  final LoginRequest request;
  final bool rememberMe;

  const AuthLoginRequested({
    required this.request,
    this.rememberMe = false,
  });

  @override
  List<Object?> get props => [request, rememberMe];
}

class AuthRegisterRequested extends AuthEvent {
  final RegisterRequest request;

  const AuthRegisterRequested({required this.request});

  @override
  List<Object?> get props => [request];
}

class AuthLogoutRequested extends AuthEvent {}

class AuthCheckStatus extends AuthEvent {}

class AuthRefreshTokenRequested extends AuthEvent {
  final String refreshToken;

  const AuthRefreshTokenRequested({required this.refreshToken});

  @override
  List<Object?> get props => [refreshToken];
}

// PASSWORD EVENTS
class AuthForgotPasswordRequested extends AuthEvent {
  final ForgotPasswordRequest request;

  const AuthForgotPasswordRequested({required this.request});

  @override
  List<Object?> get props => [request];
}

class AuthResetPasswordRequested extends AuthEvent {
  final ResetPasswordRequest request;

  const AuthResetPasswordRequested({required this.request});

  @override
  List<Object?> get props => [request];
}

class AuthChangePasswordRequested extends AuthEvent {
  final ChangePasswordRequest request;

  const AuthChangePasswordRequested({required this.request});

  @override
  List<Object?> get props => [request];
}

// PROFILE EVENTS

class AuthGetProfileRequested extends AuthEvent {}

class AuthUpdateProfileRequested extends AuthEvent {
  final ProfileUpdateRequest request;
  final String? profilePhotoPath;
  final String? frontIdPath;
  final String? backIdPath;

  const AuthUpdateProfileRequested({
    required this.request,
    this.profilePhotoPath,
    this.frontIdPath,
    this.backIdPath,
  });

  @override
  List<Object?> get props => [
        request,
        profilePhotoPath,
        frontIdPath,
        backIdPath,
      ];
}

class AuthClearError extends AuthEvent {}