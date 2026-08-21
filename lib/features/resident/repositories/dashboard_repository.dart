
import '../../../core/di/service_locator.dart';
import '../services/dashboard_api_service.dart';
import '../models/dashboard_model.dart';

class DashboardRepository {
  final DashboardApiService _apiService = getIt<DashboardApiService>();

  Future<DashboardModel> getDashboard() async {
    try {
      final response = await _apiService.getDashboard();
      if (response.data != null && response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        return DashboardModel.fromJson(data['data'] ?? data);
      }
    } catch (_) {
      // Graceful fallback when backend dashboard endpoint returns 404
    }
    return const DashboardModel(
      totalPayments: 0.0,
      pendingPayments: 0,
      openReports: 0,
      activeGroups: 0,
      pinnedAnnouncements: [],
      recentActivity: [],
    );
  }
}