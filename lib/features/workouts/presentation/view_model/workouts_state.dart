import 'package:equatable/equatable.dart';

import '../../domain/entities/muscle_entity.dart';
import '../../domain/entities/workout_category_entity.dart';

/// State for [WorkoutsCubit].
///
/// Unlike most features here, Workouts needs two independent pieces of
/// data (the tab list, and the muscles for whichever tab is selected),
/// so this is a dedicated class rather than a `typedef` over the shared
/// `BaseState<T>` used elsewhere.
class WorkoutsState extends Equatable {
  const WorkoutsState({
    this.categories = const [],
    this.selectedCategoryIndex = 0,
    this.isLoadingCategories = false,
    this.categoriesErrorMessage,
    this.isLoadingMuscles = false,
    this.muscles = const [],
    this.musclesErrorMessage,
  });

  final List<WorkoutCategoryEntity> categories;
  final int selectedCategoryIndex;
  final bool isLoadingCategories;
  final String? categoriesErrorMessage;

  final bool isLoadingMuscles;
  final List<MuscleEntity> muscles;
  final String? musclesErrorMessage;

  WorkoutCategoryEntity? get selectedCategory =>
      selectedCategoryIndex < categories.length
          ? categories[selectedCategoryIndex]
          : null;

  WorkoutsState copyWith({
    List<WorkoutCategoryEntity>? categories,
    int? selectedCategoryIndex,
    bool? isLoadingCategories,
    String? categoriesErrorMessage,
    bool? isLoadingMuscles,
    List<MuscleEntity>? muscles,
    String? musclesErrorMessage,
    bool clearCategoriesError = false,
    bool clearMusclesError = false,
  }) {
    return WorkoutsState(
      categories: categories ?? this.categories,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
      isLoadingCategories: isLoadingCategories ?? this.isLoadingCategories,
      categoriesErrorMessage: clearCategoriesError
          ? null
          : categoriesErrorMessage ?? this.categoriesErrorMessage,
      isLoadingMuscles: isLoadingMuscles ?? this.isLoadingMuscles,
      muscles: muscles ?? this.muscles,
      musclesErrorMessage: clearMusclesError
          ? null
          : musclesErrorMessage ?? this.musclesErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    categories,
    selectedCategoryIndex,
    isLoadingCategories,
    categoriesErrorMessage,
    isLoadingMuscles,
    muscles,
    musclesErrorMessage,
  ];
}
