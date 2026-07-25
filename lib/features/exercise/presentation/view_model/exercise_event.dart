sealed class ExerciseEvent {}

class GetDifficultyLevelsEvent extends ExerciseEvent {
  GetDifficultyLevelsEvent({required this.primeMoverMuscleId});

  final String primeMoverMuscleId;
}

class GetExercisesByMuscleDifficultyEvent extends ExerciseEvent {
  GetExercisesByMuscleDifficultyEvent({
    required this.primeMoverMuscleId,
    required this.difficultyLevelId,
    this.page,
  });

  final String primeMoverMuscleId;
  final String difficultyLevelId;
  final int? page;
}