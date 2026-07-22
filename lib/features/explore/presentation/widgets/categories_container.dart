import 'package:flutter/material.dart';
import '../../../../core/constants/values_manager.dart';
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
        const ExploreContainersHeadline(title: 'Category'),

        Container(
          width: .infinity,
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.surface.withAlpha(150),
            borderRadius: BorderRadius.circular(RadiusSize.r20),
          ),
          child: const Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              CategoryWidget(
                image: 'assets/images/O15_34.png',
                title: 'Gym',
              ),

              CategoriesDivider(),

              CategoryWidget(
                image: 'assets/images/O15_19.png',
                title: 'Fitness',
              ),

              CategoriesDivider(),

              CategoryWidget(
                image: 'assets/images/O15_25.png',
                title: 'Yoga',
              ),

              CategoriesDivider(),

              CategoryWidget(
                image: 'assets/images/O15_24.png',
                title: 'Aerobics',
              ),

              CategoriesDivider(),

              CategoryWidget(
                image: 'assets/images/O15_9.png',
                title: 'Trainer',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
