import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_state/base_state.dart';
import '../../../../config/handler/response_to_state_mapper.dart';
import '../../domain/use_cases/get_difficulty_levels_use_case.dart';
import '../../domain/use_cases/get_exercises_by_muscle_difficulty_use_case.dart';
import 'exercise_event.dart';
import 'exercise_state.dart';

@injectable
class ExerciseCubit extends Cubit<ExerciseState> {
  ExerciseCubit({
    required GetDifficultyLevelsUseCase getDifficultyLevelsUseCase,
    required GetExercisesByMuscleDifficultyUseCase
    getExercisesByMuscleDifficultyUseCase,
  }) : _getDifficultyLevelsUseCase = getDifficultyLevelsUseCase,
        _getExercisesByMuscleDifficultyUseCase =
            getExercisesByMuscleDifficultyUseCase,
        super(const ExerciseState());

  final GetDifficultyLevelsUseCase _getDifficultyLevelsUseCase;
  final GetExercisesByMuscleDifficultyUseCase
  _getExercisesByMuscleDifficultyUseCase;

  Future<void> onEvent(ExerciseEvent event) async {
    if (event is GetDifficultyLevelsEvent) {
      await _getDifficultyLevels(event.primeMoverMuscleId);
    } else if (event is GetExercisesByMuscleDifficultyEvent) {
      await _getExercisesByMuscleDifficulty(
        primeMoverMuscleId: event.primeMoverMuscleId,
        difficultyLevelId: event.difficultyLevelId,
        page: event.page,
      );
    }
  }

  Future<void> _getDifficultyLevels(String primeMoverMuscleId) async {
    emit(
      state.copyWith(
        getDifficultyLevelsState: const BaseState(isLoading: true),
      ),
    );

    final response = await _getDifficultyLevelsUseCase(
      primeMoverMuscleId: primeMoverMuscleId,
    );
    final handler = ResponseToStateMapper.handle(response);
    emit(state.copyWith(getDifficultyLevelsState: handler));


    if (handler.data != null && handler.data!.isNotEmpty) {
      final firstLevelId = handler.data!.first.id;
      await onEvent(
        GetExercisesByMuscleDifficultyEvent(
          primeMoverMuscleId: primeMoverMuscleId,
          difficultyLevelId: firstLevelId,
        ),
      );
    }
  }

  Future<void> _getExercisesByMuscleDifficulty({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
    int? page,
  }) async {
    emit(
      state.copyWith(
        getExercisesState: const BaseState(isLoading: true),
        selectedDifficultyLevelId: difficultyLevelId,
      ),
    );

    final response = await _getExercisesByMuscleDifficultyUseCase(
      primeMoverMuscleId: primeMoverMuscleId,
      difficultyLevelId: difficultyLevelId,
      page: page,
    );
    final handler = ResponseToStateMapper.handle(response);

    emit(state.copyWith(getExercisesState: handler));
  }
}