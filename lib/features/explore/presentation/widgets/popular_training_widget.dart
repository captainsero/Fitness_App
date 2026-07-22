import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/constants/font_manager.dart';
import '../../../../core/constants/values_manager.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/exercise_by_muscles_difficulty_entity.dart';

class PopularTrainingWidget extends StatelessWidget {
  const PopularTrainingWidget({
    required this.entity,
    super.key,
  });

  final ExerciseByMusclesDifficultyEntity entity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(RadiusSize.r20),
          child: SizedBox(
            width: AppSize.s200,
            height: AppSize.s170,
            child: Image.network(
              entity.image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.broken_image_outlined, size: AppSize.s30),
              ),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Row(
            mainAxisAlignment: .spaceEvenly,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(RadiusSize.r20),
                  top: Radius.circular(RadiusSize.r20),
                ),
                child: Container(
                  height: AppSize.s20,
                  color: Theme.of(context).colorScheme.surface.withAlpha(150),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p12,
                  ),
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '${entity.tasksNumber} ${S.current.tasks}',
                    style:
                        Theme.of(
                          context,
                        ).textTheme.titleSmall!.copyWith(
                          fontSize: FontSize.s12,
                        ),
                  ),
                ),
              ),

              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(RadiusSize.r20),
                  top: Radius.circular(RadiusSize.r20),
                ),
                child: Container(
                  height: AppSize.s20,
                  color: Theme.of(context).colorScheme.surface.withAlpha(150),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p12,
                  ),
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    entity.difficulty,
                    style:
                        Theme.of(
                          context,
                        ).textTheme.displayLarge!.copyWith(
                          fontSize: FontSize.s12,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
