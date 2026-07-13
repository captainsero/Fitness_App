import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../core/constants/app_keys/api_keys.dart';
import '../../core/constants/app_keys/secure_storage_keys.dart';
import '../handler/secure_storage_handler.dart';
import '../services/secure_storage/secure_storage_service.dart';

@lazySingleton
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.secureStorageService);

  final SecureStorageService secureStorageService;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final response = await secureStorageService.read(
      key: SecureStorageKeys.token,
    );

    final token = SecureStorageHandler.handle<String>(response);

    if (token != null && token.isNotEmpty) {
      options.headers[ApiKeys.authorization] = '${ApiKeys.bearer} $token';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      // Token expired

      await secureStorageService.delete(key: SecureStorageKeys.token);
    }

    handler.next(err);
  }
}
