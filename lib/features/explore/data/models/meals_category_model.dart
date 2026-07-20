import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/meals_category_entity.dart';

part 'meals_category_model.g.dart';

@JsonSerializable()
class MealsCategoryModel {
  MealsCategoryModel({
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });

  factory MealsCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$MealsCategoryModelFromJson(json);

  @JsonKey(name: 'idCategory')
  final String? idCategory;
  @JsonKey(name: 'strCategory')
  final String? strCategory;
  @JsonKey(name: 'strCategoryThumb')
  final String? strCategoryThumb;
  @JsonKey(name: 'strCategoryDescription')
  final String? strCategoryDescription;

  Map<String, dynamic> toJson() => _$MealsCategoryModelToJson(this);

  MealsCategoryEntity toDomian() => MealsCategoryEntity(
    id: idCategory ?? '',
    name: strCategory ?? '',
    image: strCategoryThumb ?? '',
  );
}
