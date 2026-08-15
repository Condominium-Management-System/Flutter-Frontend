
import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';

class LostFoundApiService {
  final Dio _dio = DioClient.instance;

  // Get lost & found items
  Future<Response> getItems({
    String? type,
    String? status,
    String? category,
    String? search,
    int page = 1,
    int limit = 20,
  }) async {
    final query = <String, dynamic>{};
    if (type != null) query['type'] = type;
    if (status != null) query['status'] = status;
    if (category != null) query['category'] = category;
    if (search != null) query['search'] = search;
    query['page'] = page;
    query['limit'] = limit;
    return await _dio.get(
      '/resident/lost-found',
      queryParameters: query,
    );
  }

  // Get item details
  Future<Response> getItemDetails(String id) async {
    return await _dio.get('/resident/lost-found/$id');
  }

  // Create lost item
  Future<Response> createLostItem({
    required String itemName,
    required String description,
    required String category,
    required String dateLostFound,
    String? location,
    String? photoPath,
  }) async {
    final formData = FormData();
    formData.fields.add(MapEntry('type', 'lost'));
    formData.fields.add(MapEntry('itemName', itemName));
    formData.fields.add(MapEntry('description', description));
    formData.fields.add(MapEntry('category', category));
    formData.fields.add(MapEntry('dateLostFound', dateLostFound));
    if (location != null) formData.fields.add(MapEntry('location', location));
    if (photoPath != null) {
      formData.files.add(
        MapEntry(
          'photo',
          await MultipartFile.fromFile(photoPath),
        ),
      );
    }
    return await _dio.post(
      '/resident/lost-found',
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
  }

  // Create found item
  Future<Response> createFoundItem({
    required String itemName,
    required String description,
    required String category,
    required String dateLostFound,
    String? location,
    String? photoPath,
  }) async {
    final formData = FormData();
    formData.fields.add(MapEntry('type', 'found'));
    formData.fields.add(MapEntry('itemName', itemName));
    formData.fields.add(MapEntry('description', description));
    formData.fields.add(MapEntry('category', category));
    formData.fields.add(MapEntry('dateLostFound', dateLostFound));
    if (location != null) formData.fields.add(MapEntry('location', location));
    if (photoPath != null) {
      formData.files.add(
        MapEntry(
          'photo',
          await MultipartFile.fromFile(photoPath),
        ),
      );
    }
    return await _dio.post(
      '/resident/lost-found',
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
  }

  // Claim item
  Future<Response> claimItem(String id, {required String claimDescription}) async {
    return await _dio.post(
      '/resident/lost-found/$id/claim',
      data: {'claimDescription': claimDescription},
    );
  }

  // Get my items
  Future<Response> getMyItems() async {
    return await _dio.get('/resident/lost-found/my-items');
  }
}