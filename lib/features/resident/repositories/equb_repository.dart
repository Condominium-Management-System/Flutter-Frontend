
// ignore_for_file: unused_import

import 'package:home_axis/features/resident/models/payment_model.dart';

import '../../../core/di/service_locator.dart';
import '../services/equb_api_service.dart';
import '../models/equb_model.dart';
import '../models/equb_member_model.dart';

class EqubRepository {
  final EqubApiService _apiService = getIt<EqubApiService>();

  Future<List<EqubModel>> getMyEqubGroups() async {
    try {
      final response = await _apiService.getMyEqubGroups();
      if (response.data == null) {
        return [];
      }
      final data = response.data as Map<String, dynamic>;
      final equbData = data['data'] as List? ?? [];
      return equbData
          .map((item) => EqubModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<EqubModel> getEqubDetails(String id) async {
    try {
      final response = await _apiService.getEqubDetails(id);
      if (response.data == null) {
        throw Exception('No data received');
      }
      final data = response.data as Map<String, dynamic>;
      return EqubModel.fromJson(data['data'] ?? {});
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> joinEqub(String id) async {
    try {
      final response = await _apiService.joinEqub(id);
      return response.data != null && response.statusCode == 200;
    } catch (e) {
      rethrow;
    }
  }

  Future<PaymentModel> makeEqubContribution({
    required String equbId,
    required double amount,
    required String paymentMethod,
    String? receiptPath,
  }) async {
    try {
      final response = await _apiService.makeEqubContribution(
        equbId: equbId,
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