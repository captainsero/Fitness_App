import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../core/constants/api_constants/base_urls.dart';
import '../auth_interceptor/auth_interceptor.dart';

@module
abstract class DioModule {
  @singleton
  Dio dio(AuthInterceptor authInterceptor) {
    final dio = Dio(
      BaseOptions(
        baseUrl: BaseUrls.fitnessBaseUrl,
        sendTimeout: const Duration(seconds: 20),
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );

    dio.interceptors.add(authInterceptor);

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
      );
    }

    return dio;
  }
}
