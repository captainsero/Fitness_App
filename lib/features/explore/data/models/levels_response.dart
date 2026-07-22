import 'package:json_annotation/json_annotation.dart';
import 'level_model.dart';

part 'levels_response.g.dart';

@JsonSerializable()
class LevelsResponse {
  LevelsResponse({
    this.message,
    this.levels,
  });

  factory LevelsResponse.fromJson(Map<String, dynamic> json) =>
      _$LevelsResponseFromJson(json);

  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'levels')
  final List<LevelModel>? levels;

  Map<String, dynamic> toJson() => _$LevelsResponseToJson(this);
}
