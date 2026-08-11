

import 'package:equatable/equatable.dart';
import '../models/reset_password_model.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object?> get props => [];
}

// INITIAL STATE

class ResetPasswordInitial extends ResetPasswordState {}

// LOADING STATE

class ResetPasswordLoading extends ResetPasswordState {}

// SUCCESS STATE

class ResetPasswordSuccess extends ResetPasswordState {
  final ResetPasswordResponse response;

  const ResetPasswordSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

// ERROR STATE

class ResetPasswordError extends ResetPasswordState {
  final String message;

  const ResetPasswordError({required this.message});

  @override
  List<Object?> get props => [message];
}