
import 'package:equatable/equatable.dart';
import '../models/forgot_password_model.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object?> get props => [];
}

// INITIAL STATE

class ForgotPasswordInitial extends ForgotPasswordState {}

// LOADING STATE

class ForgotPasswordLoading extends ForgotPasswordState {}

// SUCCESS STATE

class ForgotPasswordSuccess extends ForgotPasswordState {
  final ForgotPasswordResponse response;

  const ForgotPasswordSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

// ERROR STATE

class ForgotPasswordError extends ForgotPasswordState {
  final String message;

  const ForgotPasswordError({required this.message});

  @override
  List<Object?> get props => [message];
}