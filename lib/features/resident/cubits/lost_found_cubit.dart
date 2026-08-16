
import 'package:equatable/equatable.dart';
import '../models/lost_found_model.dart';

abstract class LostFoundState extends Equatable {
  const LostFoundState();

  @override
  List<Object?> get props => [];
}

class LostFoundInitial extends LostFoundState {}

class LostFoundLoading extends LostFoundState {}

class LostFoundListLoaded extends LostFoundState {
  final List<LostFoundModel> items;

  const LostFoundListLoaded({required this.items});

  @override
  List<Object?> get props => [items];
}

class LostFoundDetailsLoaded extends LostFoundState {
  final LostFoundModel item;

  const LostFoundDetailsLoaded({required this.item});

  @override
  List<Object?> get props => [item];
}

class LostFoundCreated extends LostFoundState {
  final LostFoundModel item;

  const LostFoundCreated({required this.item});

  @override
  List<Object?> get props => [item];
}

class LostFoundMyItemsLoaded extends LostFoundState {
  final List<LostFoundModel> items;

  const LostFoundMyItemsLoaded({required this.items});

  @override
  List<Object?> get props => [items];
}

class LostFoundClaimed extends LostFoundState {}

class LostFoundError extends LostFoundState {
  final String message;

  const LostFoundError({required this.message});

  @override
  List<Object?> get props => [message];
}