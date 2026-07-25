import 'package:json_annotation/json_annotation.dart';
import 'difficulty_level_model.dart';

part 'difficulty_levels_response.g.dart';

@JsonSerializable()
class DifficultyLevelsResponse {
  DifficultyLevelsResponse({
    this.message,
    this.totalLevels,
    this.difficultyLevels,
  });

  factory DifficultyLevelsResponse.fromJson(Map<String, dynamic> json) =>
      _$DifficultyLevelsResponseFromJson(json);

  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'totalLevels')
  final int? totalLevels;
  @JsonKey(name: 'difficulty_levels')
  final List<DifficultyLevelModel>? difficultyLevels;

  Map<String, dynamic> toJson() => _$DifficultyLevelsResponseToJson(this);
}