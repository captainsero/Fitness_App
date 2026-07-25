import '../../../../config/base_response/base_response.dart';
import '../../domain/entities/difficulty_level_entity.dart';
import '../../domain/entities/exercise_entity.dart';

abstract class ExerciseRemoteDataSourceContract {
  Future<BaseResponse<List<DifficultyLevelEntity>>>
  getDifficultyLevelsByPrimeMover({required String primeMoverMuscleId});

  Future<BaseResponse<List<ExerciseEntity>>> getExercisesByMuscleDifficulty({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
    int? page,
  });
}