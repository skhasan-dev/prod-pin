import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:prod_pin/src/core/index.dart' show DioExceptionExt;

class APIException implements Exception {
  APIException({required this.message, required this.statusCode});

  final String? message;
  final int? statusCode;

  factory APIException.from(dynamic e, dynamic s) {
    if (kDebugMode) {
      log(e.toString(), name: 'Error', stackTrace: s);
    }
    return APIException(
      message: (e is DioException) ? e.getErrorFromResponse() : e.toString(),
      statusCode: (e is DioException) ? e.getStatusCodeFromResponse() : 500,
    );
  }
}
