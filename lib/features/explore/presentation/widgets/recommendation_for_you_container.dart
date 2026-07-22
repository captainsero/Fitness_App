import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/constants/values_manager.dart';
import '../view_model/explore_cubit.dart';
import '../view_model/explore_state.dart';
import 'explore_containers_headline.dart';
import 'recommendation_widget.dart';

class RecommendationForYouContainer extends StatelessWidget {
  const RecommendationForYouContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSize.s10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ExploreContainersHeadline(title: 'Recommendation For You'),

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

        BlocBuilder<ExploreCubit, ExploreState>(
          buildWhen: (previous, current) =>
              previous.getMealsCategoriesState !=
              current.getMealsCategoriesState,
          builder: (context, state) {
            final categoriesState = state.getMealsCategoriesState;
            final isLoading = categoriesState.isLoading == true;

            if (categoriesState.errorMessage != null) {
              return Center(
                child: Text(
                  categoriesState.errorMessage!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }

            final categories = categoriesState.data;
            if (!isLoading && (categories == null || categories.isEmpty)) {
              return const SizedBox.shrink();
            }

            return Skeletonizer(
              enabled: isLoading,
              child: SizedBox(
                height: AppSize.s100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: isLoading ? 5 : categories!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        right: index != (isLoading ? 4 : categories!.length - 1)
                            ? AppPadding.p8
                            : 0,
                      ),
                      child: RecommendationWidget(
                        image: isLoading ? '' : categories![index].image,
                        name: isLoading ? 'Loading' : categories![index].name,
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
