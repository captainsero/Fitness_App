import 'package:json_annotation/json_annotation.dart';
import 'exercise_model.dart';

part 'exercises_response.g.dart';

@JsonSerializable()
class ExercisesResponse {
  ExercisesResponse({
    this.message,
    this.totalExercises,
    this.totalPages,
    this.currentPage,
    this.exercises,
  });

  factory ExercisesResponse.fromJson(Map<String, dynamic> json) =>
      _$ExercisesResponseFromJson(json);

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

  Map<String, dynamic> toJson() => _$ExercisesResponseToJson(this);
}