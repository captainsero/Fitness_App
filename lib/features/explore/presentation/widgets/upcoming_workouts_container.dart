import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/constants/font_manager.dart';
import '../../../../core/constants/values_manager.dart';
import '../view_model/explore_cubit.dart';
import '../view_model/explore_event.dart';
import '../view_model/explore_state.dart';
import 'explore_containers_headline.dart';
import 'upcoming_workouts_widget.dart';

class UpcomingWorkoutsContainer extends StatelessWidget {
  const UpcomingWorkoutsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSize.s10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ExploreContainersHeadline(
              title: 'Upcoming Workouts',
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'See All',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: Theme.of(
                    context,
                  ).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),

        // Muscles Group chips
        BlocBuilder<ExploreCubit, ExploreState>(
          buildWhen: (previous, current) =>
              previous.getMusclesGroupState != current.getMusclesGroupState ||
              previous.selectedMusclesGroupIndex !=
                  current.selectedMusclesGroupIndex,
          builder: (context, state) {
            final musclesGroupState = state.getMusclesGroupState;
            final isLoading = musclesGroupState.isLoading == true;

            if (musclesGroupState.errorMessage != null) {
              return Center(
                child: Text(
                  musclesGroupState.errorMessage!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }

            final muscles = musclesGroupState.data;
            if (!isLoading && (muscles == null || muscles.isEmpty)) {
              return const SizedBox.shrink();
            }

            return Skeletonizer(
              enabled: isLoading,
              child: SizedBox(
                height: AppSize.s30,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: isLoading ? 5 : muscles!.length,
                  separatorBuilder: (_, _) => const SizedBox(width: AppSize.s8),
                  itemBuilder: (context, index) {
                    final selected =
                        !isLoading && state.selectedMusclesGroupIndex == index;
                    return GestureDetector(
                      onTap: isLoading
                          ? null
                          : () {
                              unawaited(
                                context.read<ExploreCubit>().onEvent(
                                  SelectMusclesGroupEvent(index: index),
                                ),
                              );
                            },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSize.s16,
                          vertical: AppSize.s8,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? Theme.of(context).colorScheme.primary
                              : null,
                          borderRadius: BorderRadius.circular(
                            RadiusSize.r20,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            isLoading ? 'Loading' : muscles![index].name ?? '',
                            style: Theme.of(context).textTheme.displayLarge!
                                .copyWith(
                                  fontSize: FontSize.s12,
                                ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),

        // Muscles by group
        BlocBuilder<ExploreCubit, ExploreState>(
          buildWhen: (previous, current) =>
              previous.getMusclesByMusclesGroupState !=
              current.getMusclesByMusclesGroupState,
          builder: (context, state) {
            final musclesState = state.getMusclesByMusclesGroupState;
            final isLoading = musclesState.isLoading == true;

            if (musclesState.errorMessage != null) {
              return Center(
                child: Text(
                  musclesState.errorMessage!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }

            final muscles = musclesState.data;
            if (!isLoading && (muscles == null || muscles.isEmpty)) {
              return const SizedBox.shrink();
            }

            return Skeletonizer(
              enabled: isLoading,
              child: SizedBox(
                height: AppSize.s80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: isLoading ? 5 : muscles!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        right: index != (isLoading ? 4 : muscles!.length - 1)
                            ? AppPadding.p8
                            : 0,
                      ),
                      child: UpcomingWorkoutsWidget(
                        image: isLoading ? '' : muscles![index].image ?? '',
                        titel: isLoading
                            ? 'Loading'
                            : muscles![index].name ?? '',
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
