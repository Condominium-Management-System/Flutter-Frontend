
import '../../../core/di/service_locator.dart';
import '../services/dashboard_api_service.dart';
import '../models/dashboard_model.dart';

class DashboardRepository {
  final DashboardApiService _apiService = getIt<DashboardApiService>();

  Future<DashboardModel> getDashboard() async {
    try {
      final response = await _apiService.getDashboard();
      if (response.data == null) {
        throw Exception('No data received');
      }
      final data = response.data as Map<String, dynamic>;
      return DashboardModel.fromJson(data['data'] ?? {});
    } catch (e) {
      rethrow;
    }
  }
}