import 'package:dio/dio.dart';

extension DioExceptionExt on DioException {
  Map<String, dynamic>? getMapFromResponse() {
    final data = response?.data;
    if (data is Map<String, dynamic>) {
      return data;
    }
    return null;
  }

  String getErrorFromResponse() {
    final map = getMapFromResponse();
    if (map != null && map.containsKey('message')) {
      return map['message'] as String? ?? 'Unknown Error';
    }
    return 'Unknown error';
  }

  int getStatusCodeFromResponse() {
    return response?.statusCode ?? 500;
  }
}
