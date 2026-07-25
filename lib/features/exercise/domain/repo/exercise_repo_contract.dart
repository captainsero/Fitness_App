import '../../../../config/base_response/base_response.dart';
import '../entities/difficulty_level_entity.dart';
import '../entities/exercise_entity.dart';

abstract class ExerciseRepoContract {
  Future<BaseResponse<List<DifficultyLevelEntity>>>
  getDifficultyLevelsByPrimeMover({required String primeMoverMuscleId});

  Future<BaseResponse<List<ExerciseEntity>>> getExercisesByMuscleDifficulty({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
    int? page,
  });
}