
import 'package:equatable/equatable.dart';
import '../models/neighbor_model.dart';

abstract class NeighborState extends Equatable {
  const NeighborState();

  @override
  List<Object?> get props => [];
}

class NeighborInitial extends NeighborState {}

class NeighborLoading extends NeighborState {}

class NeighborListLoaded extends NeighborState {
  final List<NeighborModel> neighbors;

  const NeighborListLoaded({required this.neighbors});

  @override
  List<Object?> get props => [neighbors];
}

class NeighborDetailsLoaded extends NeighborState {
  final NeighborModel neighbor;

  const NeighborDetailsLoaded({required this.neighbor});

  @override
  List<Object?> get props => [neighbor];
}

class NeighborError extends NeighborState {
  final String message;

  const NeighborError({required this.message});

  @override
  List<Object?> get props => [message];
}