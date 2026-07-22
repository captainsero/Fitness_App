import 'package:flutter/material.dart';
import '../../../../core/constants/values_manager.dart';
import '../../../../generated/l10n.dart';
import 'categories_divider.dart';
import 'category_widget.dart';
import 'explore_containers_headline.dart';

class CategoriesContainer extends StatelessWidget {
  const CategoriesContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSize.s10,
      crossAxisAlignment: .start,
      children: [
        ExploreContainersHeadline(title: S.current.category),

        Container(
          width: .infinity,
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.surface.withAlpha(150),
            borderRadius: BorderRadius.circular(RadiusSize.r20),
          ),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              CategoryWidget(
                image: AssetsConst.gymImage,
                title: S.current.gym,
              ),

              const CategoriesDivider(),

              CategoryWidget(
                image: AssetsConst.fitnessImage,
                title: S.current.fitness,
              ),

              const CategoriesDivider(),

              CategoryWidget(
                image: AssetsConst.yogaImage,
                title: S.current.yoga,
              ),

              const CategoriesDivider(),

              CategoryWidget(
                image: AssetsConst.aerobicsImage,
                title: S.current.aerobics,
              ),

              const CategoriesDivider(),

              CategoryWidget(
                image: AssetsConst.trainerImage,
                title: S.current.trainer,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
