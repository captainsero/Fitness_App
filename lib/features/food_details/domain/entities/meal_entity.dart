class MealEntity {
  const MealEntity({
    this.idMeal = '',
    this.strMeal = '',
    this.strMealAlternate = '',
    this.strCategory = '',
    this.strArea = '',
    this.strCountry = '',
    this.strInstructions = '',
    this.strMealThumb = '',
    this.strTags = '',
    this.strYoutube = '',
    this.strSource = '',
    this.strImageSource = '',
    this.strCreativeCommonsConfirmed = '',
    this.dateModified = '',
    this.ingredients = const [],
  });

  final String idMeal;
  final String strMeal;
  final String strMealAlternate;
  final String strCategory;
  final String strArea;
  final String strCountry;
  final String strInstructions;
  final String strMealThumb;
  final String strTags;
  final String strYoutube;
  final String strSource;
  final String strImageSource;
  final String strCreativeCommonsConfirmed;
  final String dateModified;

  /// Non-empty ingredient/measure pairs parsed from the raw meal data.
  /// Each entry: key = ingredient name, value = measure.
  final List<MapEntry<String, String>> ingredients;

  /// Returns [strTags] split into a list, or an empty list if null.
  List<String> get tagList =>
      strTags.isEmpty ? [] : strTags.split(',').map((t) => t.trim()).toList();
}
