
import '../../../core/di/service_locator.dart';
import '../services/announcement_api_service.dart';
import '../models/announcement_model.dart';

class AnnouncementRepository {
  final AnnouncementApiService _apiService = getIt<AnnouncementApiService>();

  Future<List<AnnouncementModel>> getAnnouncements({
    String? type,
    bool? pinned,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.getAnnouncements(
        type: type,
        pinned: pinned,
        page: page,
        limit: limit,
      );
      if (response.data != null && response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        final announcementsData = data['data'] as List? ?? [];
        return announcementsData
            .map((item) => AnnouncementModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  Future<AnnouncementModel> getAnnouncementDetails(String id) async {
    try {
      final response = await _apiService.getAnnouncementDetails(id);
      if (response.data == null) {
        throw Exception('No data received');
      }
      final data = response.data as Map<String, dynamic>;
      return AnnouncementModel.fromJson(data['data'] ?? {});
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AnnouncementModel>> getPinnedAnnouncements() async {
    return await getAnnouncements(pinned: true);
  }
}