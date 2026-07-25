import 'package:equatable/equatable.dart';

import '../../../../config/base_state/base_state.dart';
import '../../domain/entities/difficulty_level_entity.dart';
import '../../domain/entities/exercise_entity.dart';

class ExerciseState extends Equatable {
  const ExerciseState({
    this.getDifficultyLevelsState =
    const BaseState<List<DifficultyLevelEntity>>(),
    this.getExercisesState = const BaseState<List<ExerciseEntity>>(),
    this.selectedDifficultyLevelId,
  });

  ExerciseState copyWith({
    BaseState<List<DifficultyLevelEntity>>? getDifficultyLevelsState,
    BaseState<List<ExerciseEntity>>? getExercisesState,
    String? selectedDifficultyLevelId,
  }) => ExerciseState(
    getDifficultyLevelsState:
    getDifficultyLevelsState ?? this.getDifficultyLevelsState,
    getExercisesState: getExercisesState ?? this.getExercisesState,
    selectedDifficultyLevelId:
    selectedDifficultyLevelId ?? this.selectedDifficultyLevelId,
  );

  final BaseState<List<DifficultyLevelEntity>> getDifficultyLevelsState;
  final BaseState<List<ExerciseEntity>> getExercisesState;
  final String? selectedDifficultyLevelId;

  @override
  List<Object?> get props => [
    getDifficultyLevelsState,
    getExercisesState,
    selectedDifficultyLevelId,
  ];
}