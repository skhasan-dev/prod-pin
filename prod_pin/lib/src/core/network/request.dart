import 'package:dio/dio.dart';
import 'package:prod_pin/src/config/index.dart';

enum RequestMethod { get, post, put, patch, delete }

class Request {
  Request({
    required this.method,
    required this.endpoint,
    this.queryParams = const {},
    this.body,
    this.headers,
    this.formData,
    this.isSafeRoute = false,
  });

  final String endpoint;
  final Map<String, dynamic> queryParams;
  final Map<String, String>? headers;
  final dynamic body;
  final FormData? formData;
  final bool isSafeRoute;

  final RequestMethod method;

  String get fullPath => '${FlavorConfig.instance.baseUrl}/$endpoint';

  String get realPath => endpoint;
}
