import 'dart:math';

import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../domain/entities/exercise_by_muscles_difficulty_entity.dart';
import '../../domain/entities/meals_category_entity.dart';
import '../../domain/repo/explore_repo_contract.dart';
import '../data_sources/explore_remote_data_source_contract.dart';
import '../models/exercise_model.dart';
import '../models/level_model.dart';
import '../models/meals_category_model.dart';
import '../models/muscle_model.dart';
import '../models/muscles_group_model.dart';

@Injectable(as: ExploreRepoContract)
class ExploreRepoImpl implements ExploreRepoContract {
  ExploreRepoImpl({
    required ExploreRemoteDataSourceContract remoteDataSourceContract,
  }) : _remoteDataSourceContract = remoteDataSourceContract;

  final ExploreRemoteDataSourceContract _remoteDataSourceContract;

  static const int _musclesPerLevel = 3;

  @override
  Future<BaseResponse<List<MuscleModel>>> getRandomMuscles() {
    return _remoteDataSourceContract.getRandomMuscles();
  }

  @override
  Future<BaseResponse<List<MusclesGroupModel>>> getMusclesGroup() {
    return _remoteDataSourceContract.getMusclesGroup();
  }

  @override
  Future<BaseResponse<List<MuscleModel>>> getMusclesByMusclesGroup({
    required String groupId,
  }) {
    return _remoteDataSourceContract.getMusclesByMusclesGroup(groupId: groupId);
  }

  @override
  Future<BaseResponse<List<MealsCategoryEntity>>> getMealsCategories() async {
    final response = await _remoteDataSourceContract.getMealsCategories();
    switch (response) {
      case SuccessBaseResponse<List<MealsCategoryModel>>():
        return SuccessBaseResponse<List<MealsCategoryEntity>>(
          data: response.data.map((m) => m.toDomian()).toList(),
        );
      case ErrorBaseResponse<List<MealsCategoryModel>>():
        return ErrorBaseResponse<List<MealsCategoryEntity>>(
          error: response.error,
        );
    }
  }

  @override
  Future<BaseResponse<List<ExerciseByMusclesDifficultyEntity>>>
  getExerciseByMuscleDifficulty() async {
    // 1. Fetch levels and random muscles in parallel
    final responses = await Future.wait([
      _remoteDataSourceContract.getAllLevels(),
      _remoteDataSourceContract.getRandomMuscles(),
    ]);

    final levelsResponse = responses[0] as BaseResponse<List<LevelModel>>;
    final musclesResponse = responses[1] as BaseResponse<List<MuscleModel>>;

    // 2. Early-return on errors
    if (levelsResponse is ErrorBaseResponse<List<LevelModel>>) {
      return ErrorBaseResponse(error: levelsResponse.error);
    }
    if (musclesResponse is ErrorBaseResponse<List<MuscleModel>>) {
      return ErrorBaseResponse(error: musclesResponse.error);
    }

    final levels =
        (levelsResponse as SuccessBaseResponse<List<LevelModel>>).data;
    final muscles =
        (musclesResponse as SuccessBaseResponse<List<MuscleModel>>).data;

    if (levels.isEmpty || muscles.isEmpty) {
      return const SuccessBaseResponse(data: []);
    }

    // 3. Take up to 3 muscles per level
    final muscleCount = min(_musclesPerLevel, muscles.length);
    final selectedMuscles = muscles.sublist(0, muscleCount);

    // 4. Fetch exercise counts for every (level, muscle) pair in parallel
    final pairs = <({LevelModel level, MuscleModel muscle})>[];
    for (final level in levels) {
      for (final muscle in selectedMuscles) {
        pairs.add((level: level, muscle: muscle));
      }
    }

    final exerciseResponses = await Future.wait(
      pairs.map(
        (pair) => _remoteDataSourceContract.getExerciseByMuscleDifficulty(
          primeMoverMuscleId: pair.muscle.id ?? '',
          difficultylevelId: pair.level.id ?? '',
        ),
      ),
    );

    // 5. Map results to entities, skipping failed ones
    final entities = <ExerciseByMusclesDifficultyEntity>[];
    for (var i = 0; i < pairs.length; i++) {
      final exerciseResponse = exerciseResponses[i];
      if (exerciseResponse is SuccessBaseResponse<List<ExerciseModel>>) {
        entities.add(
          ExerciseByMusclesDifficultyEntity(
            image: pairs[i].muscle.image ?? '',
            name: pairs[i].muscle.name ?? '',
            difficulty: pairs[i].level.name ?? '',
            primeMoverMuscleId: pairs[i].muscle.id ?? '',
            difficultylevelId: pairs[i].level.id ?? '',
            tasksNumber: exerciseResponse.data.length,
          ),
        );
      }
    }

    return SuccessBaseResponse(data: entities);
  }
}
