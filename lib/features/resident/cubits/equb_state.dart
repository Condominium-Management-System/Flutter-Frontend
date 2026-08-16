
import 'package:equatable/equatable.dart';
import '../models/equb_model.dart';

abstract class EqubState extends Equatable {
  const EqubState();

  @override
  List<Object?> get props => [];
}

class EqubInitial extends EqubState {}

class EqubLoading extends EqubState {}

class EqubListLoaded extends EqubState {
  final List<EqubModel> groups;

  const EqubListLoaded({required this.groups});

  @override
  List<Object?> get props => [groups];
}

class EqubDetailsLoaded extends EqubState {
  final EqubModel group;

  const EqubDetailsLoaded({required this.group});

  @override
  List<Object?> get props => [group];
}

class EqubJoined extends EqubState {}

class EqubError extends EqubState {
  final String message;

  const EqubError({required this.message});

  @override
  List<Object?> get props => [message];
}