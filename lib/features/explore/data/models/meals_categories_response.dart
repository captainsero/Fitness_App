import 'package:json_annotation/json_annotation.dart';
import 'meals_category_model.dart';

part 'meals_categories_response.g.dart';

@JsonSerializable()
class MealsCategoriesResponse {
  MealsCategoriesResponse({
    this.categories,
  });

  factory MealsCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$MealsCategoriesResponseFromJson(json);
  @JsonKey(name: 'categories')
  final List<MealsCategoryModel>? categories;

  Map<String, dynamic> toJson() => _$MealsCategoriesResponseToJson(this);
}
