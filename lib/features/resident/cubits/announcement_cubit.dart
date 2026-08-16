
import 'package:flutter_bloc/flutter_bloc.dart';
import 'announcement_state.dart';
import '../repositories/announcement_repository.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/connectivity_service.dart';

class AnnouncementCubit extends Cubit<AnnouncementState> {
  final AnnouncementRepository _announcementRepository = getIt<AnnouncementRepository>();
  final ConnectivityService _connectivityService = getIt<ConnectivityService>();

  AnnouncementCubit() : super(AnnouncementInitial());

  Future<void> loadAnnouncements({
    String? type,
    bool? pinned,
    int page = 1,
    int limit = 20,
  }) async {
    emit(AnnouncementLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const AnnouncementError(message: 'No internet connection.'));
        return;
      }

      final announcements = await _announcementRepository.getAnnouncements(
        type: type,
        pinned: pinned,
        page: page,
        limit: limit,
      );
      emit(AnnouncementListLoaded(announcements: announcements));
    } catch (e) {
      emit(AnnouncementError(message: e.toString()));
    }
  }

  Future<void> loadAnnouncementDetails(String id) async {
    emit(AnnouncementLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const AnnouncementError(message: 'No internet connection.'));
        return;
      }

      final announcement = await _announcementRepository.getAnnouncementDetails(id);
      emit(AnnouncementDetailsLoaded(announcement: announcement));
    } catch (e) {
      emit(AnnouncementError(message: e.toString()));
    }
  }

  Future<void> loadPinnedAnnouncements() async {
    emit(AnnouncementLoading());

    try {
      final hasConnection = await _connectivityService.checkConnection();
      if (!hasConnection) {
        emit(const AnnouncementError(message: 'No internet connection.'));
        return;
      }

      final announcements = await _announcementRepository.getPinnedAnnouncements();
      emit(PinnedAnnouncementsLoaded(announcements: announcements));
    } catch (e) {
      emit(AnnouncementError(message: e.toString()));
    }
  }

  void clearError() {
    if (state is AnnouncementError) {
      emit(AnnouncementInitial());
    }
  }
}