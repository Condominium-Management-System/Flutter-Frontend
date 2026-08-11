
import 'package:equatable/equatable.dart';
import '../models/login_model.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

// INITIAL STATE

class LoginInitial extends LoginState {}

// LOADING STATE

class LoginLoading extends LoginState {}

// REMEMBER ME LOADED

class LoginRememberMeLoaded extends LoginState {
  final String email;
  final String password;
  final bool rememberMe;

  const LoginRememberMeLoaded({
    required this.email,
    required this.password,
    required this.rememberMe,
  });

  @override
  List<Object?> get props => [email, password, rememberMe];
}

// SUCCESS STATE

class LoginSuccess extends LoginState {
  final LoginData data;

  const LoginSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

// ERROR STATE

class LoginError extends LoginState {
  final String message;

  const LoginError({required this.message});

  @override
  List<Object?> get props => [message];
}