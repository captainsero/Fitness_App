import 'package:json_annotation/json_annotation.dart';
import 'muscles_group_model.dart';

part 'muscles_group_response.g.dart';

@JsonSerializable()
class MusclesGroupResponse {
  MusclesGroupResponse({
    this.message,
    this.musclesGroup,
  });

  factory MusclesGroupResponse.fromJson(Map<String, dynamic> json) =>
      _$MusclesGroupResponseFromJson(json);

  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'musclesGroup')
  final List<MusclesGroupModel>? musclesGroup;

  Map<String, dynamic> toJson() => _$MusclesGroupResponseToJson(this);
}
