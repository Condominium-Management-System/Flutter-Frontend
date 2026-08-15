
import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';

class ReportApiService {
  final Dio _dio = DioClient.instance;

  // Get my reports
  Future<Response> getMyReports({
    String? status,
    String? category,
    int page = 1,
    int limit = 20,
  }) async {
    final query = <String, dynamic>{};
    if (status != null) query['status'] = status;
    if (category != null) query['category'] = category;
    query['page'] = page;
    query['limit'] = limit;
    return await _dio.get(
      '/resident/reports',
      queryParameters: query,
    );
  }

  // Get report details
  Future<Response> getReportDetails(String id) async {
    return await _dio.get('/resident/reports/$id');
  }

  // Create report
  Future<Response> createReport({
    required String title,
    required String description,
    required String category,
    required String priority,
    String? photoPath,
  }) async {
    final formData = FormData();
    formData.fields.add(MapEntry('title', title));
    formData.fields.add(MapEntry('description', description));
    formData.fields.add(MapEntry('category', category));
    formData.fields.add(MapEntry('priority', priority));
    if (photoPath != null) {
      formData.files.add(
        MapEntry(
          'photo',
          await MultipartFile.fromFile(photoPath),
        ),
      );
    }
    return await _dio.post(
      '/resident/reports',
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
  }
}