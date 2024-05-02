import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AppRestClient {
  late final Dio dio;
  AppRestClient({required String baseURL}) {
    _create(baseURL);
  }

  Future<Dio> _create(String baseURL) async {
    dio = Dio(BaseOptions(baseUrl: baseURL));

    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
      ));
    }
    return dio;
  }
}
