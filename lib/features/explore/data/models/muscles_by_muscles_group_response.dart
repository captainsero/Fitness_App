import 'package:json_annotation/json_annotation.dart';
import 'muscle_model.dart';
import 'muscles_group_model.dart';

part 'muscles_by_muscles_group_response.g.dart';

@JsonSerializable()
class MusclesByMusclesGroupResponse {
  MusclesByMusclesGroupResponse({
    this.message,
    this.muscleGroup,
    this.muscles,
  });

  factory MusclesByMusclesGroupResponse.fromJson(Map<String, dynamic> json) =>
      _$MusclesByMusclesGroupResponseFromJson(json);

  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'muscleGroup')
  final MusclesGroupModel? muscleGroup;
  @JsonKey(name: 'muscles')
  final List<MuscleModel>? muscles;

  Map<String, dynamic> toJson() => _$MusclesByMusclesGroupResponseToJson(this);
}
