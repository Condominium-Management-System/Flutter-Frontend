
import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';

class AnnouncementApiService {
  final Dio _dio = DioClient.instance;

  // Get announcements
  Future<Response> getAnnouncements({
    String? type,
    bool? pinned,
    int page = 1,
    int limit = 20,
  }) async {
    final query = <String, dynamic>{};
    if (type != null) query['type'] = type;
    if (pinned != null) query['pinned'] = pinned;
    query['page'] = page;
    query['limit'] = limit;
    return await _dio.get(
      '/resident/announcements',
      queryParameters: query,
    );
  }

  // Get announcement details
  Future<Response> getAnnouncementDetails(String id) async {
    return await _dio.get('/resident/announcements/$id');
  }
}