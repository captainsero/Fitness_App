import 'base_urls.dart';

abstract class ApiEndpoints {
  /// Base URL for building endpoints.
  static const String baseUrl = BaseUrls.fitnessBaseUrl;
  static const String signIn = '/auth/signin';
  static const String signUp = '/auth/signup';
  static const String difficultyLevelsByPrimeMover =
      '/levels/difficulty-levels/by-prime-mover';
  static const String exercisesByMuscleDifficulty =
      '/exercises/by-muscle-difficulty';
}
