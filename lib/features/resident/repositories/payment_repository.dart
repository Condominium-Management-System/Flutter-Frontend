
import '../../../core/di/service_locator.dart';
import '../services/payment_api_service.dart';
import '../models/payment_model.dart';
import '../models/transaction_model.dart';
// Add this import at the top
import 'dart:typed_data';

class PaymentRepository {
  final PaymentApiService _apiService = getIt<PaymentApiService>();

  // PAYMENTS
  Future<List<PaymentModel>> getMyPayments({
    String? status,
    String? paymentType,
    String? monthYear,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.getMyPayments(
        status: status,
        paymentType: paymentType,
        monthYear: monthYear,
        page: page,
        limit: limit,
      );
      if (response.data == null) {
        return [];
      }
      final data = response.data as Map<String, dynamic>;
      final paymentsData = data['data'] as List? ?? [];
      return paymentsData
          .map((item) => PaymentModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<PaymentModel> getPaymentDetails(String id) async {
    try {
      final response = await _apiService.getPaymentDetails(id);
      if (response.data == null) {
        throw Exception('No data received');
      }
      final data = response.data as Map<String, dynamic>;
      return PaymentModel.fromJson(data['data'] ?? {});
    } catch (e) {
      rethrow;
    }
  }

  Future<PaymentModel> makePayment({
    required String paymentType,
    required double amount,
    required String paymentMethod,
    String? equbId,
    String? iddirId,
    String? monthYear,
    String? receiptPath,
  }) async {
    try {
      final response = await _apiService.makePayment(
        paymentType: paymentType,
        amount: amount,
        paymentMethod: paymentMethod,
        equbId: equbId,
        iddirId: iddirId,
        monthYear: monthYear,
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

  Future<List<String>> getPaymentMethods() async {
    try {
      final response = await _apiService.getPaymentMethods();
      if (response.data == null) {
        return [];
      }
      final data = response.data as Map<String, dynamic>;
      final methods = data['data']?['methods'] as List? ?? [];
      return methods.map((e) => e.toString()).toList();
    } catch (e) {
      rethrow;
    }
  }

  // TRANSACTIONS
  Future<List<TransactionModel>> getMyTransactions({
    String? status,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.getMyTransactions(
        status: status,
        page: page,
        limit: limit,
      );
      if (response.data == null) {
        return [];
      }
      final data = response.data as Map<String, dynamic>;
      final transactionsData = data['data'] as List? ?? [];
      return transactionsData
          .map((item) => TransactionModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Uint8List> getReceiptPdf(String id) async {
    try {
      final response = await _apiService.getReceiptPdf(id);
      if (response.data == null) {
        throw Exception('No data received');
      }
      return response.data as Uint8List;
    } catch (e) {
      rethrow;
    }
  }
}

