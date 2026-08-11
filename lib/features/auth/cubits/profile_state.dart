
import 'package:equatable/equatable.dart';
import '../models/user_model.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

// INITIAL STATE

class ProfileInitial extends ProfileState {}

// LOADING STATE

class ProfileLoading extends ProfileState {}

// LOADED STATE

class ProfileLoaded extends ProfileState {
  final UserModel user;

  const ProfileLoaded({required this.user});

  @override
  List<Object?> get props => [user];
}

// UPDATED STATE

class ProfileUpdated extends ProfileState {
  final UserModel user;

  const ProfileUpdated({required this.user});

  @override
  List<Object?> get props => [user];
}

// ERROR STATE

class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message});

  @override
  List<Object?> get props => [message];
}