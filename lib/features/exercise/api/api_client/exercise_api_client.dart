import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/constants/api_constants/api_endpoints.dart';
import '../../data/models/difficulty_levels_response.dart';
import '../../data/models/exercises_response.dart';

part 'exercise_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class ExerciseApiClient {
  @factoryMethod
  factory ExerciseApiClient(Dio dio) = _ExerciseApiClient;

  @GET(ApiEndpoints.difficultyLevelsByPrimeMover)
  Future<DifficultyLevelsResponse> getDifficultyLevelsByPrimeMover({
    @Query('primeMoverMuscleId') required String primeMoverMuscleId,
  });

  @GET(ApiEndpoints.exerciseByMuscleDifficulty)
  Future<ExercisesResponse> getExercisesByMuscleDifficulty({
    @Query('primeMoverMuscleId') required String primeMoverMuscleId,
    @Query('difficultyLevelId') required String difficultyLevelId,
    @Query('page') int? page,
  });
}