import 'package:json_annotation/json_annotation.dart';
import 'exercise_model.dart';

part 'exercise_by_muscle_difficulty_response.g.dart';

@JsonSerializable()
class ExerciseByMuscleDifficultyResponse {
  ExerciseByMuscleDifficultyResponse({
    this.message,
    this.totalExercises,
    this.totalPages,
    this.currentPage,
    this.exercises,
  });

  factory ExerciseByMuscleDifficultyResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$ExerciseByMuscleDifficultyResponseFromJson(json);

  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'totalExercises')
  final int? totalExercises;
  @JsonKey(name: 'totalPages')
  final int? totalPages;
  @JsonKey(name: 'currentPage')
  final int? currentPage;
  @JsonKey(name: 'exercises')
  final List<ExerciseModel>? exercises;

  Map<String, dynamic> toJson() =>
      _$ExerciseByMuscleDifficultyResponseToJson(this);
}
