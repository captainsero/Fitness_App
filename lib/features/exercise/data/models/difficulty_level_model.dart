import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/difficulty_level_entity.dart';

part 'difficulty_level_model.g.dart';

@JsonSerializable()
class DifficultyLevelModel {
  DifficultyLevelModel({this.id, this.name});

  factory DifficultyLevelModel.fromJson(Map<String, dynamic> json) =>
      _$DifficultyLevelModelFromJson(json);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;

  Map<String, dynamic> toJson() => _$DifficultyLevelModelToJson(this);

  DifficultyLevelEntity toDomain() =>
      DifficultyLevelEntity(id: id ?? '', name: name ?? '');
}