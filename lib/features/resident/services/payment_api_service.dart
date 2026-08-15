
import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';

class PaymentApiService {
  final Dio _dio = DioClient.instance;

  // Get my payments
  Future<Response> getMyPayments({
    String? status,
    String? paymentType,
    String? monthYear,
    int page = 1,
    int limit = 20,
  }) async {
    final query = <String, dynamic>{};
    if (status != null) query['status'] = status;
    if (paymentType != null) query['paymentType'] = paymentType;
    if (monthYear != null) query['monthYear'] = monthYear;
    query['page'] = page;
    query['limit'] = limit;
    return await _dio.get(
      '/resident/payments',
      queryParameters: query,
    );
  }

  // Get payment details
  Future<Response> getPaymentDetails(String id) async {
    return await _dio.get('/resident/payments/$id');
  }

  // Make payment (manual)
  Future<Response> makePayment({
    required String paymentType,
    required double amount,
    required String paymentMethod,
    String? equbId,
    String? iddirId,
    String? monthYear,
    String? receiptPath,
  }) async {
    final formData = FormData();
    formData.fields.add(MapEntry('paymentType', paymentType));
    formData.fields.add(MapEntry('amount', amount.toString()));
    formData.fields.add(MapEntry('paymentMethod', paymentMethod));
    if (equbId != null) formData.fields.add(MapEntry('equbId', equbId));
    if (iddirId != null) formData.fields.add(MapEntry('iddirId', iddirId));
    if (monthYear != null) formData.fields.add(MapEntry('monthYear', monthYear));
    if (receiptPath != null) {
      formData.files.add(
        MapEntry(
          'receipt',
          await MultipartFile.fromFile(receiptPath),
        ),
      );
    }
    return await _dio.post(
      '/resident/payments',
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
  }

  // Get payment methods
  Future<Response> getPaymentMethods() async {
    return await _dio.get('/payments/methods');
  }

  // Get my transactions
  Future<Response> getMyTransactions({
    String? status,
    int page = 1,
    int limit = 20,
  }) async {
    final query = <String, dynamic>{};
    if (status != null) query['status'] = status;
    query['page'] = page;
    query['limit'] = limit;
    return await _dio.get(
      '/payments/my-transactions',
      queryParameters: query,
    );
  }

  // Get payment receipt (PDF)
  Future<Response> getReceiptPdf(String id) async {
    return await _dio.get(
      '/payments/$id/receipt/pdf',
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );
  }
}