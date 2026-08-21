
// ignore_for_file: unused_import

import 'package:home_axis/features/resident/models/payment_model.dart';

import '../../../core/di/service_locator.dart';
import '../services/iddir_api_service.dart';
import '../models/iddir_model.dart';
import '../models/iddir_member_model.dart';

class IddirRepository {
  final IddirApiService _apiService = getIt<IddirApiService>();

  Future<List<IddirModel>> getMyIddirGroups() async {
    try {
      final response = await _apiService.getMyIddirGroups();
      if (response.data != null && response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        final iddirData = data['data'] as List? ?? [];
        return iddirData
            .map((item) => IddirModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  Future<IddirModel> getIddirDetails(String id) async {
    try {
      final response = await _apiService.getIddirDetails(id);
      if (response.data == null) {
        throw Exception('No data received');
      }
      final data = response.data as Map<String, dynamic>;
      return IddirModel.fromJson(data['data'] ?? {});
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> joinIddir(String id) async {
    try {
      final response = await _apiService.joinIddir(id);
      return response.data != null && response.statusCode == 200;
    } catch (e) {
      rethrow;
    }
  }

  Future<PaymentModel> makeIddirContribution({
    required String iddirId,
    required double amount,
    required String paymentMethod,
    String? receiptPath,
  }) async {
    try {
      final response = await _apiService.makeIddirContribution(
        iddirId: iddirId,
        amount: amount,
        paymentMethod: paymentMethod,
        receiptPath: receiptPath,
      );
      if (response.data == null) {
        throw Exception('No data received');
      }
      final data = response.data as Map<String, dynamic>;
      return PaymentModel.fromJson(data['data'] ?? {});
    } catch (e) {
      rethrow;
    }
  }
}