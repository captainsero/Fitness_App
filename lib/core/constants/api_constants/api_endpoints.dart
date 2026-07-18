import 'base_urls.dart';

abstract class ApiEndpoints {
  /// Base URL for building endpoints.
  static const String baseUrl = BaseUrls.fitnessBaseUrl;
  static const String forgotPassword = '$baseUrl/auth/forgotPassword';
  static const String verifyResetCode = '$baseUrl/auth/verifyResetCode';
  static const String resetPassword = '$baseUrl/auth/resetPassword';
}
