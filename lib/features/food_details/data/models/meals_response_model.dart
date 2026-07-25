import 'package:json_annotation/json_annotation.dart';

import 'meal_model.dart';

part 'meals_response_model.g.dart';

@JsonSerializable()
class MealsResponseModel {
  const MealsResponseModel({this.meals});
  factory MealsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MealsResponseModelFromJson(json);
  @JsonKey(name: 'meals')
  final List<MealModel>? meals;

  Map<String, dynamic> toJson() => _$MealsResponseModelToJson(this);
}
