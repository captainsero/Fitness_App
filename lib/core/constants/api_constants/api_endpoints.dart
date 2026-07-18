import 'base_urls.dart';

abstract class ApiEndpoints {
  /// Base URL for building endpoints.
  static const String baseUrl = BaseUrls.fitnessBaseUrl;
  static const String signIn = '/auth/signin';
}
