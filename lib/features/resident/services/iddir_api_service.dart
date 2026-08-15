
import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';

class IddirApiService {
  final Dio _dio = DioClient.instance;

  // Get my Iddir groups
  Future<Response> getMyIddirGroups() async {
    return await _dio.get('/resident/iddir');
  }

  // Get Iddir details
  Future<Response> getIddirDetails(String id) async {
    return await _dio.get('/resident/iddir/$id');
  }

  // Join Iddir
  Future<Response> joinIddir(String id) async {
    return await _dio.post('/resident/iddir/$id/join');
  }

  // Make Iddir contribution
  Future<Response> makeIddirContribution({
    required String iddirId,
    required double amount,
    required String paymentMethod,
    String? receiptPath,
  }) async {
    final formData = FormData();
    formData.fields.add(MapEntry('iddirId', iddirId));
    formData.fields.add(MapEntry('amount', amount.toString()));
    formData.fields.add(MapEntry('paymentMethod', paymentMethod));
    if (receiptPath != null) {
      formData.files.add(
        MapEntry(
          'receipt',
          await MultipartFile.fromFile(receiptPath),
        ),
      );
    }
    return await _dio.post(
      '/resident/iddir/$iddirId/contribute',
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
  }
}