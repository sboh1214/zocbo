import 'dart:io';

import 'package:dio/dio.dart';
import 'package:zocbo/utils/url.dart';

class API {
  static API? _instance;
  factory API() => _instance ??= API._internal();

  final Dio _dio = Dio();
  Dio get dio => _dio;

  API._internal();

  void authenticate(List<Cookie> cookies) {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers["cookie"] =
        cookies.map((cookie) => "${cookie.name}=${cookie.value}").join("; ");
    _dio.options.headers["X-CSRFToken"] =
        cookies.firstWhere((cookie) => cookie.name == "csrftoken").value;
  }
}
