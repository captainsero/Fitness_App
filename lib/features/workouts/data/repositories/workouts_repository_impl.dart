import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../api/workouts_api.dart';
import '../../domain/entities/muscle_entity.dart';
import '../../domain/entities/workout_category_entity.dart';
import '../../domain/repositories/workouts_repository.dart';
import '../models/muscle_model.dart';

@Injectable(as: WorkoutsRepository)
class WorkoutsRepositoryImpl implements WorkoutsRepository {
  WorkoutsRepositoryImpl(this._workoutsApi);

  final WorkoutsApi _workoutsApi;

  static const _fullBodyCategory = WorkoutCategoryEntity(
    id: null,
    name: 'Full Body',
  );

  @override
  Future<BaseResponse<List<WorkoutCategoryEntity>>>
  getWorkoutCategories() async {
    try {
      final result = await _workoutsApi.getAllMuscleGroups();

      final categories = [
        _fullBodyCategory,
        ...result.groups.map(
          (group) =>
              WorkoutCategoryEntity(id: group.id, name: group.name),
        ),
      ];

      return SuccessBaseResponse(data: categories);
    } on Exception catch (e) {
      return ErrorBaseResponse(error: e);
    }
  }

  @override
  Future<BaseResponse<List<MuscleEntity>>> getMusclesForCategory(
    WorkoutCategoryEntity category,
  ) async {
    try {
      final muscles = category.isFullBody
          ? (await _workoutsApi.getRandomPrimeMoverMuscles()).muscles
          : (await _workoutsApi.getMusclesByGroup(category.id!)).muscles;

      return SuccessBaseResponse(data: _dedupeByName(muscles));
    } on Exception catch (e) {
      return ErrorBaseResponse(error: e);
    }
  }

  /// The API can return the same muscle name more than once (e.g. two
  /// "Triceps Brachii" entries, only one of which has an image) --
  /// collapse those down to a single card per name, preferring whichever
  /// duplicate actually has an image. Result is sorted by name for a
  /// stable, predictable grid order.
  List<MuscleEntity> _dedupeByName(List<MuscleModel> muscles) {
    final byName = <String, MuscleModel>{};

    for (final muscle in muscles) {
      final key = muscle.name.trim().toLowerCase();
      final existing = byName[key];
      final hasImage = muscle.image != null && muscle.image!.isNotEmpty;
      final existingHasImage = existing != null &&
          existing.image != null &&
          existing.image!.isNotEmpty;

      if (existing == null || (hasImage && !existingHasImage)) {
        byName[key] = muscle;
      }
    }

    return byName.values.map((muscle) => muscle.toEntity()).toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }
}
