
import '../../../core/di/service_locator.dart';
import '../services/neighbor_api_service.dart';
import '../models/neighbor_model.dart';

class NeighborRepository {
  final NeighborApiService _apiService = getIt<NeighborApiService>();

  Future<List<NeighborModel>> getNeighbors({String? search}) async {
    try {
      final response = await _apiService.getNeighbors(search: search);
      if (response.data == null) {
        return [];
      }
      final data = response.data as Map<String, dynamic>;
      final neighborsData = data['data'] as List? ?? [];
      return neighborsData
          .map((item) => NeighborModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<NeighborModel> getNeighborDetails(String id) async {
    try {
      final response = await _apiService.getNeighborDetails(id);
      if (response.data == null) {
        throw Exception('No data received');
      }
      final data = response.data as Map<String, dynamic>;
      return NeighborModel.fromJson(data['data'] ?? {});
    } catch (e) {
      rethrow;
    }
  }
}