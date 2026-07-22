class ExerciseByMusclesDifficultyEntity {
  ExerciseByMusclesDifficultyEntity({
    required this.primeMoverMuscleId,
    required this.difficultylevelId,
    required this.image,
    required this.name,
    required this.difficulty,
    required this.tasksNumber,
  });

  final String image;
  final String name;
  final String difficulty;
  final String primeMoverMuscleId;
  final String difficultylevelId;
  final int tasksNumber;
}
