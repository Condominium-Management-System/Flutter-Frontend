
import '../../../core/di/service_locator.dart';
import '../services/report_api_service.dart';
import '../models/report_model.dart';

class ReportRepository {
  final ReportApiService _apiService = getIt<ReportApiService>();

  Future<List<ReportModel>> getMyReports({
    String? status,
    String? category,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.getMyReports(
        status: status,
        category: category,
        page: page,
        limit: limit,
      );
      if (response.data == null) {
        return [];
      }
      final data = response.data as Map<String, dynamic>;
      final reportsData = data['data'] as List? ?? [];
      return reportsData
          .map((item) => ReportModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<ReportModel> getReportDetails(String id) async {
    try {
      final response = await _apiService.getReportDetails(id);
      if (response.data == null) {
        throw Exception('No data received');
      }
      final data = response.data as Map<String, dynamic>;
      return ReportModel.fromJson(data['data'] ?? {});
    } catch (e) {
      rethrow;
    }
  }

  Future<ReportModel> createReport({
    required String title,
    required String description,
    required String category,
    required String priority,
    String? photoPath,
  }) async {
    try {
      final response = await _apiService.createReport(
        title: title,
        description: description,
        category: category,
        priority: priority,
        photoPath: photoPath,
      );
      if (response.data == null) {
        throw Exception('No data received');
      }
      final data = response.data as Map<String, dynamic>;
      return ReportModel.fromJson(data['data'] ?? {});
    } catch (e) {
      rethrow;
    }
  }
}