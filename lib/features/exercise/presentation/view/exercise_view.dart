import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/color_manager.dart';
import '../../../../../core/constants/values_manager.dart';
import '../../../../config/di/di.dart';
import '../../../../core/shared_widgets/blurred_background.dart';
import '../view_model/exercise_cubit.dart';
import '../view_model/exercise_event.dart';
import '../view_model/exercise_state.dart';
import '../widgets/difficulty_tabs.dart';
import '../widgets/exercise_header.dart';
import '../widgets/exercise_list_section.dart';

/// Exercise page. Requires [primeMoverMuscleId] — the `_id` of the muscle
/// the user tapped on the previous screen. Everything else (difficulty
/// levels, exercises) is fetched from the API using that id.
class ExerciseView extends StatelessWidget {
  const ExerciseView({
    super.key,
    required this.primeMoverMuscleId,
    this.title = 'Exercises',
    this.description = '',
    this.durationLabel = '',
    this.caloriesLabel = '',
    this.headerImagePath =
        'assets/images/Handsome man working push ups at the gym. sport exercises.png',
    this.onBackTap,
  });

  final String primeMoverMuscleId;
  final String title;
  final String description;
  final String durationLabel;
  final String caloriesLabel;
  final String headerImagePath;
  final VoidCallback? onBackTap;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ExerciseCubit>()
        ..onEvent(
          GetDifficultyLevelsEvent(primeMoverMuscleId: primeMoverMuscleId),
        ),
      child: _ExerciseViewBody(
        primeMoverMuscleId: primeMoverMuscleId,
        title: title,
        description: description,
        durationLabel: durationLabel,
        caloriesLabel: caloriesLabel,
        headerImagePath: headerImagePath,
        onBackTap: onBackTap,
      ),
    );
  }
}

class _ExerciseViewBody extends StatelessWidget {
  const _ExerciseViewBody({
    required this.primeMoverMuscleId,
    required this.title,
    required this.description,
    required this.durationLabel,
    required this.caloriesLabel,
    required this.headerImagePath,
    required this.onBackTap,
  });

  final String primeMoverMuscleId;
  final String title;
  final String description;
  final String durationLabel;
  final String caloriesLabel;
  final String headerImagePath;
  final VoidCallback? onBackTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const BlurredBackground(),
          BlocBuilder<ExerciseCubit, ExerciseState>(
            builder: (context, state) {
              final levels = state.getDifficultyLevelsState.data ?? [];
              final exercises = state.getExercisesState.data ?? [];

              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: ExerciseHeader(
                      title: title,
                      description: description,
                      durationLabel: durationLabel,
                      caloriesLabel: caloriesLabel,
                      headerImagePath: headerImagePath,
                      onBackTap: onBackTap ?? () => context.pop(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: DifficultyTabs(
                      levels: levels,
                      selectedId: state.selectedDifficultyLevelId,
                      onChanged: (levelId) {
                        context.read<ExerciseCubit>().onEvent(
                          GetExercisesByMuscleDifficultyEvent(
                            primeMoverMuscleId: primeMoverMuscleId,
                            difficultyLevelId: levelId,
                          ),
                        );
                      },
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: AppSize.s8)),
                  SliverToBoxAdapter(
                    child: ExerciseListSection(
                      exercises: exercises,
                      isLoading: state.getExercisesState.isLoading ?? false,
                      errorMessage: state.getExercisesState.errorMessage,
                      onRetry: () {
                        final id = state.selectedDifficultyLevelId;
                        if (id != null) {
                          context.read<ExerciseCubit>().onEvent(
                            GetExercisesByMuscleDifficultyEvent(
                              primeMoverMuscleId: primeMoverMuscleId,
                              difficultyLevelId: id,
                            ),
                          );
                        }
                      },
                      onExerciseTap: (item, index) {
                        // e.g. open item.videoUrl / item.explanationUrl
                      },
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: AppSize.s24),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
