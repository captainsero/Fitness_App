import '../../../../config/base_response/base_response.dart';
import '../entities/muscle_entity.dart';
import '../entities/workout_category_entity.dart';

abstract class WorkoutsRepository {
  /// The Workouts tabs: a synthetic "Full Body" entry followed by every
  /// real muscle group from `GET /muscles`.
  Future<BaseResponse<List<WorkoutCategoryEntity>>> getWorkoutCategories();

  /// Muscles for a given tab -- 20 random prime-mover muscles for
  /// "Full Body", or the muscles belonging to that tab's muscle group
  /// otherwise.
  Future<BaseResponse<List<MuscleEntity>>> getMusclesForCategory(
    WorkoutCategoryEntity category,
  );
}
