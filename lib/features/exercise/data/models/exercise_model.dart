import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/exercise_entity.dart';

part 'exercise_model.g.dart';

@JsonSerializable()
class ExerciseModel {
  ExerciseModel({
    this.id,
    this.exercise,
    this.difficultyLevel,
    this.targetMuscleGroup,
    this.primeMoverMuscle,
    this.primaryEquipment,
    this.shortYoutubeDemonstrationLink,
    this.inDepthYoutubeExplanationLink,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseModelFromJson(json);

  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'exercise')
  final String? exercise;
  @JsonKey(name: 'difficulty_level')
  final String? difficultyLevel;
  @JsonKey(name: 'target_muscle_group')
  final String? targetMuscleGroup;
  @JsonKey(name: 'prime_mover_muscle')
  final String? primeMoverMuscle;
  @JsonKey(name: 'primary_equipment')
  final String? primaryEquipment;
  @JsonKey(name: 'short_youtube_demonstration_link')
  final String? shortYoutubeDemonstrationLink;
  @JsonKey(name: 'in_depth_youtube_explanation_link')
  final String? inDepthYoutubeExplanationLink;

  Map<String, dynamic> toJson() => _$ExerciseModelToJson(this);

  ExerciseEntity toDomain() => ExerciseEntity(
    id: id ?? '',
    title: exercise ?? '',
    difficultyLevel: difficultyLevel ?? '',
    targetMuscleGroup: targetMuscleGroup ?? '',
    primeMoverMuscle: primeMoverMuscle ?? '',
    primaryEquipment: primaryEquipment ?? '',
    videoUrl: shortYoutubeDemonstrationLink,
    explanationUrl: inDepthYoutubeExplanationLink,
  );
}