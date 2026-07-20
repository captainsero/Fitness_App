import 'package:json_annotation/json_annotation.dart';

import 'muscle_model.dart';

part 'random_muscles_response.g.dart';

@JsonSerializable()
class RandomMusclesResponse {
  RandomMusclesResponse({
    this.message,
    this.totalMuscles,
    this.muscles,
  });

  factory RandomMusclesResponse.fromJson(Map<String, dynamic> json) =>
      _$RandomMusclesResponseFromJson(json);

  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'totalMuscles')
  final int? totalMuscles;
  @JsonKey(name: 'muscles')
  final List<MuscleModel>? muscles;

  Map<String, dynamic> toJson() => _$RandomMusclesResponseToJson(this);
}
