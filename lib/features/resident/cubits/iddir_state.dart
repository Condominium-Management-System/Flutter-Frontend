
import 'package:equatable/equatable.dart';
import '../models/iddir_model.dart';

abstract class IddirState extends Equatable {
  const IddirState();

  @override
  List<Object?> get props => [];
}

class IddirInitial extends IddirState {}

class IddirLoading extends IddirState {}

class IddirListLoaded extends IddirState {
  final List<IddirModel> groups;

  const IddirListLoaded({required this.groups});

  @override
  List<Object?> get props => [groups];
}

class IddirDetailsLoaded extends IddirState {
  final IddirModel group;

  const IddirDetailsLoaded({required this.group});

  @override
  List<Object?> get props => [group];
}

class IddirJoined extends IddirState {}

class IddirError extends IddirState {
  final String message;

  const IddirError({required this.message});

  @override
  List<Object?> get props => [message];
}