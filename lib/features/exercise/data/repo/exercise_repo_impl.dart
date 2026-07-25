import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../domain/entities/difficulty_level_entity.dart';
import '../../domain/entities/exercise_entity.dart';
import '../../domain/repo/exercise_repo_contract.dart';
import '../data_sources/exercise_remote_data_source_contract.dart';

@Injectable(as: ExerciseRepoContract)
class ExerciseRepoImpl implements ExerciseRepoContract {
  ExerciseRepoImpl({
    required ExerciseRemoteDataSourceContract remoteDataSourceContract,
  }) : _remoteDataSourceContract = remoteDataSourceContract;

  final ExerciseRemoteDataSourceContract _remoteDataSourceContract;

  @override
  Future<BaseResponse<List<DifficultyLevelEntity>>>
  getDifficultyLevelsByPrimeMover({required String primeMoverMuscleId}) {
    return _remoteDataSourceContract.getDifficultyLevelsByPrimeMover(
      primeMoverMuscleId: primeMoverMuscleId,
    );
  }

  @override
  Future<BaseResponse<List<ExerciseEntity>>> getExercisesByMuscleDifficulty({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
    int? page,
  }) {
    return _remoteDataSourceContract.getExercisesByMuscleDifficulty(
      primeMoverMuscleId: primeMoverMuscleId,
      difficultyLevelId: difficultyLevelId,
      page: page,
    );
  }
}