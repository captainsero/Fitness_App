import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/constants/values_manager.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/exercise_by_muscles_difficulty_entity.dart';
import '../view_model/explore_cubit.dart';
import '../view_model/explore_state.dart';
import 'explore_containers_headline.dart';
import 'popular_training_widget.dart';

class PopularTrainingContainer extends StatelessWidget {
  const PopularTrainingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSize.s10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExploreContainersHeadline(title: S.current.popularTraining),

        BlocBuilder<ExploreCubit, ExploreState>(
          buildWhen: (previous, current) =>
              previous.getExerciseByMuscleDifficultyState !=
              current.getExerciseByMuscleDifficultyState,
          builder: (context, state) {
            final exerciseState = state.getExerciseByMuscleDifficultyState;
            final isLoading = exerciseState.isLoading == true;

            if (exerciseState.errorMessage != null) {
              return Center(
                child: Text(
                  exerciseState.errorMessage!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }

            final exercises = exerciseState.data;
            if (!isLoading && (exercises == null || exercises.isEmpty)) {
              return const SizedBox.shrink();
            }

            return Skeletonizer(
              enabled: isLoading,
              child: SizedBox(
                height: AppSize.s170,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: isLoading ? 3 : exercises!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        right: index != (isLoading ? 2 : exercises!.length - 1)
                            ? AppPadding.p8
                            : 0,
                      ),
                      child: PopularTrainingWidget(
                        entity: isLoading
                            ? ExerciseByMusclesDifficultyEntity(
                                primeMoverMuscleId: '',
                                difficultylevelId: '',
                                image: '',
                                name: S.current.loading,
                                difficulty: S.current.loading,
                                tasksNumber: 0,
                              )
                            : exercises![index],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
