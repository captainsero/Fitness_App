import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../core/errors/app_error_localizer.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/workout_category_entity.dart';
import '../../domain/repositories/workouts_repository.dart';
import 'workouts_state.dart';

@injectable
class WorkoutsCubit extends Cubit<WorkoutsState> {
  WorkoutsCubit(this._workoutsRepository) : super(const WorkoutsState());

  final WorkoutsRepository _workoutsRepository;

  /// Loads the tabs, then loads the muscles for whichever tab ends up
  /// selected (index 0, "Full Body", on first load).
  Future<void> loadCategories() async {
    emit(
      state.copyWith(isLoadingCategories: true, clearCategoriesError: true),
    );

    final response = await _workoutsRepository.getWorkoutCategories();

    switch (response) {
      case SuccessBaseResponse<List<WorkoutCategoryEntity>>():
        emit(
          state.copyWith(
            categories: response.data,
            isLoadingCategories: false,
            selectedCategoryIndex: 0,
          ),
        );
        if (response.data.isNotEmpty) {
          await _loadMuscles(response.data.first);
        }
      case ErrorBaseResponse<List<WorkoutCategoryEntity>>():
        emit(
          state.copyWith(
            isLoadingCategories: false,
            categoriesErrorMessage:
                response.errorMessage ??
                    response.appError.localize(S.current),
          ),
        );
    }
  }

  Future<void> selectCategory(int index) async {
    if (index == state.selectedCategoryIndex ||
        index >= state.categories.length) {
      return;
    }

    emit(state.copyWith(selectedCategoryIndex: index));
    await _loadMuscles(state.categories[index]);
  }

  /// Re-fetches muscles for whichever tab is currently selected (used by
  /// the error state's Retry button).
  Future<void> retryMuscles() async {
    final category = state.selectedCategory;
    if (category != null) {
      await _loadMuscles(category);
    }
  }

  Future<void> _loadMuscles(WorkoutCategoryEntity category) async {
    emit(state.copyWith(isLoadingMuscles: true, clearMusclesError: true));

    final response = await _workoutsRepository.getMusclesForCategory(
      category,
    );

    switch (response) {
      case SuccessBaseResponse():
        emit(state.copyWith(isLoadingMuscles: false, muscles: response.data));
      case ErrorBaseResponse():
        emit(
          state.copyWith(
            isLoadingMuscles: false,
            musclesErrorMessage:
                response.errorMessage ??
                    response.appError.localize(S.current),
          ),
        );
    }
  }
}
