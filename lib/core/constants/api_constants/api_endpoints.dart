import 'base_urls.dart';

abstract class ApiEndpoints {
  /// Base URL for building endpoints.
  static const String baseUrl = BaseUrls.fitnessBaseUrl;
  static const String signIn = '/auth/signin';
  static const String signUp = '/auth/signup';
  static const String forgotPassword = '$baseUrl/auth/forgotPassword';
  static const String verifyResetCode = '$baseUrl/auth/verifyResetCode';
  static const String resetPassword = '$baseUrl/auth/resetPassword';
  static const String allMuscles = '/muscles';
  static const String randomPrimeMoverMuscles = '/muscles/random';
  static const String muscleGroups = '/muscles';
  static const String musclesByGroup = '/musclesGroup/by-muscle-group';
}
