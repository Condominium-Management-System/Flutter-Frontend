
import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';

class NeighborApiService {
  final Dio _dio = DioClient.instance;

  // Get neighbors
  Future<Response> getNeighbors({String? search}) async {
    final query = <String, dynamic>{};
    if (search != null) query['search'] = search;
    return await _dio.get(
      '/resident/neighbors',
      queryParameters: query,
    );
  }

  // Get neighbor details
  Future<Response> getNeighborDetails(String id) async {
    return await _dio.get('/resident/neighbors/$id');
  }
}