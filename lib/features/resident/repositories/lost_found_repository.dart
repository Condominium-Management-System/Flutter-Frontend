
import '../../../core/di/service_locator.dart';
import '../services/lost_found_api_service.dart';
import '../models/lost_found_model.dart';

class LostFoundRepository {
  final LostFoundApiService _apiService = getIt<LostFoundApiService>();

  Future<List<LostFoundModel>> getItems({
    String? type,
    String? status,
    String? category,
    String? search,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.getItems(
        type: type,
        status: status,
        category: category,
        search: search,
        page: page,
        limit: limit,
      );
      if (response.data != null && response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        List rawList = [];
        if (data['data'] is List) {
          rawList = data['data'] as List;
        } else if (data['data'] is Map && data['data']['items'] is List) {
          rawList = data['data']['items'] as List;
        } else if (data['items'] is List) {
          rawList = data['items'] as List;
        }
        return rawList
            .map((item) => LostFoundModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  Future<LostFoundModel> getItemDetails(String id) async {
    try {
      final response = await _apiService.getItemDetails(id);
      if (response.data == null) {
        throw Exception('No data received');
      }
      final data = response.data as Map<String, dynamic>;
      return LostFoundModel.fromJson(data['data'] ?? {});
    } catch (e) {
      rethrow;
    }
  }

  Future<LostFoundModel> createLostItem({
    required String itemName,
    required String description,
    required String category,
    required String dateLostFound,
    String? location,
    String? photoPath,
  }) async {
    try {
      final response = await _apiService.createLostItem(
        itemName: itemName,
        description: description,
        category: category,
        dateLostFound: dateLostFound,
        location: location,
        photoPath: photoPath,
      );
      if (response.data == null) {
        throw Exception('No data received');
      }
      final data = response.data as Map<String, dynamic>;
      return LostFoundModel.fromJson(data['data'] ?? {});
    } catch (e) {
      rethrow;
    }
  }

  Future<LostFoundModel> createFoundItem({
    required String itemName,
    required String description,
    required String category,
    required String dateLostFound,
    String? location,
    String? photoPath,
  }) async {
    try {
      final response = await _apiService.createFoundItem(
        itemName: itemName,
        description: description,
        category: category,
        dateLostFound: dateLostFound,
        location: location,
        photoPath: photoPath,
      );
      if (response.data == null) {
        throw Exception('No data received');
      }
      final data = response.data as Map<String, dynamic>;
      return LostFoundModel.fromJson(data['data'] ?? {});
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> claimItem(String id, {required String claimDescription}) async {
    try {
      final response = await _apiService.claimItem(id, claimDescription: claimDescription);
      return response.data != null && response.statusCode == 200;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<LostFoundModel>> getMyItems() async {
    try {
      final response = await _apiService.getMyItems();
      if (response.data == null) {
        return [];
      }
      final data = response.data as Map<String, dynamic>;
      final itemsData = data['data'] as List? ?? [];
      return itemsData
          .map((item) => LostFoundModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}