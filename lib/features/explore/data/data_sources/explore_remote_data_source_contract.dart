import '../../../../config/base_response/base_response.dart';
import '../models/exercise_model.dart';
import '../models/level_model.dart';
import '../models/meals_category_model.dart';
import '../models/muscle_model.dart';
import '../models/muscles_group_model.dart';

abstract class ExploreRemoteDataSourceContract {
  Future<BaseResponse<List<MuscleModel>>> getRandomMuscles();
  Future<BaseResponse<List<MusclesGroupModel>>> getMusclesGroup();
  Future<BaseResponse<List<MuscleModel>>> getMusclesByMusclesGroup({
    required String groupId,
  });
  Future<BaseResponse<List<MealsCategoryModel>>> getMealsCategories();
  Future<BaseResponse<List<LevelModel>>> getAllLevels();
  Future<BaseResponse<List<ExerciseModel>>> getExerciseByMuscleDifficulty({
    required String primeMoverMuscleId,
    required String difficultylevelId,
  });
}
