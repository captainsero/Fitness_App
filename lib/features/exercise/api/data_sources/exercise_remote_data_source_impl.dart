import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../data/data_sources/exercise_remote_data_source_contract.dart';
import '../../domain/entities/difficulty_level_entity.dart';
import '../../domain/entities/exercise_entity.dart';
import '../api_client/exercise_api_client.dart';

@Injectable(as: ExerciseRemoteDataSourceContract)
class ExerciseRemoteDataSourceImpl implements ExerciseRemoteDataSourceContract {
  ExerciseRemoteDataSourceImpl({required ExerciseApiClient apiClient})
      : _apiClient = apiClient;

  final ExerciseApiClient _apiClient;

  @override
  Future<BaseResponse<List<DifficultyLevelEntity>>>
  getDifficultyLevelsByPrimeMover({required String primeMoverMuscleId}) async {
    try {
      final response = await _apiClient.getDifficultyLevelsByPrimeMover(
        primeMoverMuscleId: primeMoverMuscleId,
      );
      return SuccessBaseResponse<List<DifficultyLevelEntity>>(
        data:
        response.difficultyLevels?.map((m) => m.toDomain()).toList() ??
            [],
      );
    } catch (e) {
      return ErrorBaseResponse<List<DifficultyLevelEntity>>(error: e);
    }
  }

  @override
  Future<BaseResponse<List<ExerciseEntity>>> getExercisesByMuscleDifficulty({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
    int? page,
  }) async {
    try {
      final response = await _apiClient.getExercisesByMuscleDifficulty(
        primeMoverMuscleId: primeMoverMuscleId,
        difficultyLevelId: difficultyLevelId,
        page: page,
      );
      return SuccessBaseResponse<List<ExerciseEntity>>(
        data: response.exercises?.map((m) => m.toDomain()).toList() ?? [],
      );
    } catch (e) {
      return ErrorBaseResponse<List<ExerciseEntity>>(error: e);
    }
  }
}