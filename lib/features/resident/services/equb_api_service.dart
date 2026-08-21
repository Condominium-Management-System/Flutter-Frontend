
import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/constants/api_constant.dart';

class EqubApiService {
  final Dio _dio = DioClient.instance;

  // Get my Equb groups
  Future<Response> getMyEqubGroups() async {
    return await _dio.get(ApiConstants.equb);
  }

  // Get Equb details
  Future<Response> getEqubDetails(String id) async {
    return await _dio.get('${ApiConstants.equb}/$id');
  }

  // Join Equb
  Future<Response> joinEqub(String id) async {
    return await _dio.post('${ApiConstants.equb}/$id/join');
  }

  // Make Equb contribution
  Future<Response> makeEqubContribution({
    required String equbId,
    required double amount,
    required String paymentMethod,
    String? receiptPath,
  }) async {
    final formData = FormData();
    formData.fields.add(MapEntry('equbId', equbId));
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
      '${ApiConstants.equb}/$equbId/contribute',
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
  }
}