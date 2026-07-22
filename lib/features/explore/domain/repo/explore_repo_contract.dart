import '../../../../config/base_response/base_response.dart';
import '../../data/models/muscle_model.dart';
import '../../data/models/muscles_group_model.dart';
import '../entities/exercise_by_muscles_difficulty_entity.dart';
import '../entities/meals_category_entity.dart';

abstract class ExploreRepoContract {
  Future<BaseResponse<List<MuscleModel>>> getRandomMuscles();
  Future<BaseResponse<List<MusclesGroupModel>>> getMusclesGroup();
  Future<BaseResponse<List<MuscleModel>>> getMusclesByMusclesGroup({
    required String groupId,
  });
  Future<BaseResponse<List<MealsCategoryEntity>>> getMealsCategories();
  Future<BaseResponse<List<ExerciseByMusclesDifficultyEntity>>>
  getExerciseByMuscleDifficulty();
}

