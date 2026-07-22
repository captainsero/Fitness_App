import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/constants/values_manager.dart';
import '../../../../generated/l10n.dart';
import '../view_model/explore_cubit.dart';
import '../view_model/explore_state.dart';
import 'explore_containers_headline.dart';
import 'recommendation_widget.dart';

class RecommendationToDayContainer extends StatelessWidget {
  const RecommendationToDayContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSize.s10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExploreContainersHeadline(title: S.current.recommendationToDay),

        BlocBuilder<ExploreCubit, ExploreState>(
          buildWhen: (previous, current) =>
              previous.getRandomMusclesState != current.getRandomMusclesState,
          builder: (context, state) {
            final musclesState = state.getRandomMusclesState;
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
                height: AppSize.s100,
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
                      child: RecommendationWidget(
                        image: isLoading ? '' : muscles![index].image ?? '',
                        name: isLoading
                            ? S.current.loading
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
