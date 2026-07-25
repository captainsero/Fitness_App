import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../entities/difficulty_level_entity.dart';
import '../repo/exercise_repo_contract.dart';

@injectable
class GetDifficultyLevelsUseCase {
  GetDifficultyLevelsUseCase({required ExerciseRepoContract repoContract})
      : _repoContract = repoContract;

  final ExerciseRepoContract _repoContract;

  Future<BaseResponse<List<DifficultyLevelEntity>>> call({
    required String primeMoverMuscleId,
  }) {
    return _repoContract.getDifficultyLevelsByPrimeMover(
      primeMoverMuscleId: primeMoverMuscleId,
    );
  }
}