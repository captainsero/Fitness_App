class ExerciseEntity {
  ExerciseEntity({
    required this.id,
    required this.title,
    required this.difficultyLevel,
    required this.targetMuscleGroup,
    required this.primeMoverMuscle,
    required this.primaryEquipment,
    this.videoUrl,
    this.explanationUrl,
  });

  final String id;
  final String title;
  final String difficultyLevel;
  final String targetMuscleGroup;
  final String primeMoverMuscle;
  final String primaryEquipment;
  final String? videoUrl;
  final String? explanationUrl;
}