import 'package:json_annotation/json_annotation.dart';

part 'muscles_group_model.g.dart';

@JsonSerializable()
class MusclesGroupModel {
  MusclesGroupModel({
    this.id,
    this.name,
  });

  factory MusclesGroupModel.fromJson(Map<String, dynamic> json) =>
      _$MusclesGroupModelFromJson(json);

  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;

  Map<String, dynamic> toJson() => _$MusclesGroupModelToJson(this);
}
