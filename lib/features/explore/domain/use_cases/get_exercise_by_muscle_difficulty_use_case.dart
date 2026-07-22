import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../entities/exercise_by_muscles_difficulty_entity.dart';
import '../repo/explore_repo_contract.dart';

@injectable
class GetExerciseByMuscleDifficultyUseCase {
  GetExerciseByMuscleDifficultyUseCase({
    required ExploreRepoContract repoContract,
  }) : _repoContract = repoContract;

  final ExploreRepoContract _repoContract;

  Future<BaseResponse<List<ExerciseByMusclesDifficultyEntity>>> call() {
    return _repoContract.getExerciseByMuscleDifficulty();
  }
}
