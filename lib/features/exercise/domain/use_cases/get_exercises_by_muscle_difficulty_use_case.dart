import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../entities/exercise_entity.dart';
import '../repo/exercise_repo_contract.dart';

@injectable
class GetExercisesByMuscleDifficultyUseCase {
  GetExercisesByMuscleDifficultyUseCase({
    required ExerciseRepoContract repoContract,
  }) : _repoContract = repoContract;

  final ExerciseRepoContract _repoContract;

  Future<BaseResponse<List<ExerciseEntity>>> call({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
    int? page,
  }) {
    return _repoContract.getExercisesByMuscleDifficulty(
      primeMoverMuscleId: primeMoverMuscleId,
      difficultyLevelId: difficultyLevelId,
      page: page,
    );
  }
}