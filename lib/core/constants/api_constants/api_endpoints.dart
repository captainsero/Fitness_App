import '../app_keys/api_keys.dart';
import 'base_urls.dart';

abstract class ApiEndpoints {
  /// Base URL for building endpoints.
  static const String baseUrl = BaseUrls.fitnessBaseUrl;
  static const String mealsBaseUrl = BaseUrls.mealsBaseUrl;
  static const String groupIdKey = ApiKeys.groupId;
  static const String signIn = '/auth/signin';
  static const String signUp = '/auth/signup';
  static const String forgotPassword = '$baseUrl/auth/forgotPassword';
  static const String verifyResetCode = '$baseUrl/auth/verifyResetCode';
  static const String resetPassword = '$baseUrl/auth/resetPassword';
  static const String getMealDetails = 'https://$mealsBaseUrl/1/lookup.php';
  static const String musclesRandom = '$baseUrl/muscles/random';
  static const String muscles = '$baseUrl/muscles';
  static const String musclesGroup = '$baseUrl/musclesGroup/{$groupIdKey}';
  static const String mealsCategories =
      'https://$mealsBaseUrl/1/categories.php';
  static const String levels = '$baseUrl/levels';
  static const String exerciseByMuscleDifficulty =
      '$baseUrl/exercises/by-muscle-difficulty';
  static const String difficultyLevelsByPrimeMover =
      '/levels/difficulty-levels/by-prime-mover';
  static const String exercisesByMuscleDifficulty =
      '/exercises/by-muscle-difficulty';
}
