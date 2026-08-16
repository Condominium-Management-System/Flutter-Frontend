
import 'package:equatable/equatable.dart';
import '../models/announcement_model.dart';

abstract class AnnouncementState extends Equatable {
  const AnnouncementState();

  @override
  List<Object?> get props => [];
}

class AnnouncementInitial extends AnnouncementState {}

class AnnouncementLoading extends AnnouncementState {}

class AnnouncementListLoaded extends AnnouncementState {
  final List<AnnouncementModel> announcements;

  const AnnouncementListLoaded({required this.announcements});

  @override
  List<Object?> get props => [announcements];
}

class PinnedAnnouncementsLoaded extends AnnouncementState {
  final List<AnnouncementModel> announcements;

  const PinnedAnnouncementsLoaded({required this.announcements});

  @override
  List<Object?> get props => [announcements];
}

class AnnouncementDetailsLoaded extends AnnouncementState {
  final AnnouncementModel announcement;

  const AnnouncementDetailsLoaded({required this.announcement});

  @override
  List<Object?> get props => [announcement];
}

class AnnouncementError extends AnnouncementState {
  final String message;

  const AnnouncementError({required this.message});

  @override
  List<Object?> get props => [message];
}